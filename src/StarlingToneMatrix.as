package
{
    import interfaces.IToneMatrix;
    import starling.display.Sprite;
    import test.effects.Delay;
    import test.poly.SimplePolySynthVoiceFactory;
    import tonfall.core.Engine;
    import tonfall.core.TimeConversion;
    import tonfall.prefab.poly.PolySynth;

public class StarlingToneMatrix extends AbstractStarlingApp implements IToneMatrix
{
    private const sequencer : TonematrixSequencer = new TonematrixSequencer();
    private const generator : PolySynth = new PolySynth( SimplePolySynthVoiceFactory.INSTANCE );
    private const delay: Delay = new Delay( TimeConversion.barsToMillis(3.0/16.0, Engine.getInstance().bpm) );

    private var _container: Sprite;

    public function StarlingToneMatrix()
    {
        initAudio();
    }

    private function initAudio() : void
    {
        engine.processors.push( sequencer );
        engine.processors.push( generator );
        engine.processors.push( delay );

        delay.signalInput = generator.signalOutput;

        sequencer.receiver = generator;

        engine.input = delay.signalOutput;
    }

    public function setNotePlayDelegate(delegate:Function):void
    {
        this.sequencer.stepDelegate = delegate;
    }

    public function setBeatDelegate(delegate:Function):void {
        this.sequencer.beatDelegate = delegate;
    }

    public function setPosition( u: int, v: int, value: Boolean ): void
    {
        sequencer.pattern[u][v] = value;
    }

    public function clear():void
    {
        for( var u: int = 0 ; u < 16 ; ++u )
        {
            for( var v: int = 0 ; v < 16 ; ++v )
            {
               sequencer.pattern [u][v] = false;
            }
        }
    }

    public function getWidth():int {
        return 16;
    }

    public function getHeight():int {
        return 16;
    }
}
}

import tonfall.core.BlockInfo;
import tonfall.core.Processor;
import tonfall.core.TimeEventNote;

final class TonematrixSequencer extends Processor
{
    public static const ToneMatrixNotes : Vector.<int> = Vector.<int>( [96,93,91,89,86,84,81,79,77,74,72,69,67,65,62,60] );

    public const pattern: Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>(16,true);

    public var receiver: Processor;

    public var stepDelegate:Function;
    public var beatDelegate:Function;

    public function TonematrixSequencer()
    {
        for(var i:int = 0 ;i <16;++i)
        {
            pattern[i] = new Vector.<Boolean>(16,true);
        }
    }

    override public function process( info : BlockInfo ) : void
    {

        var index: int = int( info.barFrom * 16.0 );
        var position: Number = index / 16.0;

        while( position < info.barTo )
        {
            if( position >= info.barFrom )
            {
                beatDelegate(index%16);

                for( var i: int = 0 ; i < 16 ; ++i )
                {
                    if(pattern[index%16][i])
                    {
                        stepDelegate(index%16, i);
                        var event: TimeEventNote = new TimeEventNote();
                        event.barPosition = position;
                        event.note = ToneMatrixNotes[i];
                        event.barDuration = 1.0/16.0;
                        receiver.addTimeEvent(event);
                    }
                }
            }

            position += 1.0/16.0;
            ++index;
        }
    }

}
