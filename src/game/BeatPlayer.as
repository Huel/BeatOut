/**
 * Created with IntelliJ IDEA.
 * User: huelfuchsberger
 * Date: 7/5/13
 * Time: 10:53 AM
 * To change this template use File | Settings | File Templates.
 */
package game
{
import flash.events.Event;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

public class BeatPlayer
{

    private var beatChannel1:SoundChannel;
    private var beatTransform1:SoundTransform;

    private var currentTrack:int;
    private var currentlyPlaying:int;
    private var nextPlaying:int;
    private var playingChannel:int;
    private var trackStartingPoint:int = 40;

    public function BeatPlayer(track:int =1)
    {
        currentTrack = track;
        init();
    }

    private function init():void
    {
        for (var i:int = 1; i < 2 ; i++)
        {
             this['beatTransform'+i] = new SoundTransform(1,0);
             trace("BeatTransform"+i+" created!");
        }
    }

    public function changeSound(layer:int)
    {
        beatChannel1.addEventListener(Event.SOUND_COMPLETE, changeSoundNow);
        nextPlaying = layer;
    }

    private function changeSoundNow(event:Event):void
    {
        switchBeat();
    }

    public function stop():void
    {
        beatChannel1.stop();
    }

    private function switchBeat():void
    {
        if (currentlyPlaying != nextPlaying)
        {

            beatChannel1.stop();

            beatChannel1 = StartUp.assets.playSound("Beat"+currentTrack+"_"+nextPlaying,trackStartingPoint,1,beatTransform1);
            currentlyPlaying = nextPlaying;
            playingChannel = 1;
        }
    }

    public function play():void
    {

           if (beatChannel1 == null)
           {
              beatChannel1 = StartUp.assets.playSound("Beat"+currentTrack+"_1",trackStartingPoint,1,beatTransform1);
              currentlyPlaying = 1;
              playingChannel = 1;

           }
           else
           beatChannel1 = StartUp.assets.playSound("Beat"+currentTrack+"_"+currentlyPlaying,trackStartingPoint,1,beatTransform1);



    }


}
}
