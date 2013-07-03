package
{
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.TouchEvent;
    import test.effects.Delay;
    import test.poly.SimplePolySynthVoiceFactory;
    import tonfall.core.Engine;
    import tonfall.core.TimeConversion;
    import tonfall.prefab.poly.PolySynth;

public class ToneMatrixStarling extends AbstractStarlingApp
{
    private const sequencer : TonematrixSequencer = new TonematrixSequencer();
    private const generator : PolySynth = new PolySynth( SimplePolySynthVoiceFactory.INSTANCE );
    private const delay: Delay = new Delay( TimeConversion.barsToMillis(3.0/16.0, Engine.getInstance().bpm) );

    private var _container: Sprite;
    public var _selectMode: Boolean;

    public function ToneMatrixStarling()
    {
        initView();
        initAudio();
        trace("ToneMatrix created!") ;
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

    public function changePattern( u: int, v: int, value: Boolean ): void
    {
        sequencer.pattern[u][v] = value;
    }

    private function initView() : void
    {
        _container = new Sprite();
        _container.x = 128;
        _container.y = 128;
        addChild( _container );

        for( var u: int = 0 ; u < 16 ; ++u )
        {
            for( var v: int = 0 ; v < 16 ; ++v )
            {
                var button: SequencerButton = new SequencerButton( u, v );

                button.x = ( u << 5 );
                button.y = ( v << 5 );

                _container.addChild( button );
            }
        }
    }

    override protected function resize( event : Event = null ) : void
    {
        if( null != _container )
        {
            _container.x = ( stage.stageWidth  - 512 ) >> 1;
            _container.y = ( stage.stageHeight - 512 ) >> 1;
        }
    }

}
}

import starling.display.Button;
import starling.events.Event;

import tonfall.core.BlockInfo;
import tonfall.core.Processor;
import tonfall.core.TimeEventNote;


final class SequencerButton extends Button
{
    private var _u : int;
    private var _v : int;

    private var _selected: Boolean;

    public function SequencerButton( u : int, v : int )
    {
        super(StartUp.assets.getTexture("BeatOutButton"));

        _u = u;
        _v = v;

        this.scaleX = 0.7;
        this.scaleY = 0.7;
        this. alpha = 0.5;

        addEventListener( Event.TRIGGERED, pressedButton )

        update();
    }

    private function pressedButton(event:Event):void
    {
        this.selected = Game.sequencer._selectMode = !this.selected;

        Game.sequencer.changePattern( this.u, this.v, this.selected );
    }

    public function get u() : int
    {
        return _u;
    }

    public function get v() : int
    {
        return _v;
    }

    public function get selected() : Boolean
    {
        return _selected;

    }

    public function set selected( selected : Boolean ) : void
    {
        _selected = selected;
        trace("Button Hit") ;

        update();
    }

    private function update(): void
    {
         _selected ? this.alpha = 1 : this.alpha = 0.5 ;
    }
}

final class TonematrixSequencer extends Processor
{
    public static const ToneMatrixNotes : Vector.<int> = Vector.<int>( [96,93,91,89,86,84,81,79,77,74,72,69,67,65,62,60] );

    public const pattern: Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>(16,true);

    public var receiver: Processor;

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
                for( var i: int = 0 ; i < 16 ; ++i )
                {
                    if(pattern[index%16][i])
                    {
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
