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

    private var loop:int=1;

    public function BeatPlayer(track:int =1)
    {
        currentTrack = track;
        init();
    }

    private function init():void
    {
        for (var i:int = 1; i < 3 ; i++)
        {
             this['beatTransform'+i] = new SoundTransform(1,0);
             trace("BeatTransform"+i+" created!");
        }

        play(1);
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

    private function switchBeat():void
    {
        if (currentlyPlaying != nextPlaying)
        {

            beatChannel1.stop();

            beatChannel1 = StartUp.assets.playSound("Beat"+currentTrack+"_"+nextPlaying,35,1,beatTransform1);
            currentlyPlaying = nextPlaying;
            playingChannel = 1;
        }
    }

    public function play(layer:int=1):void
    {

           //beatChannel1 = StartUp.assets.playSound("Beat1_1",40,100,beatTransform1);
           if (beatChannel1 == null)
           {
              beatChannel1 = StartUp.assets.playSound("Beat"+currentTrack+"_1",35,1,beatTransform1);
              currentlyPlaying = 1;
              playingChannel = 1;

           }
           else
           beatChannel1 = StartUp.assets.playSound("Beat"+currentTrack+"_"+currentlyPlaying,35,1,beatTransform1);



    }


}
}
