/**
 * Created with IntelliJ IDEA.
 * User: huelfuchsberger
 * Date: 7/3/13
 * Time: 7:42 PM
 * To change this template use File | Settings | File Templates.
 */
package
{

import flash.filesystem.File;

import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.AssetManager;

import utils.ProgressBar;

public class StartUp extends Sprite
{
    private var mGame:Game;
    private var splashScreen:Image;

    private static var sAssets:AssetManager;

    public function StartUp()
    {
        if (sAssets ==null)
            sAssets = new AssetManager();

        sAssets.verbose = true;

        sAssets.enqueue(EmbeddedAssets);

        assets.loadQueue(function(ratio:Number):void
        {
            trace("Loading assets, progress:", ratio);

            if (ratio == 1.0)
                splash();
        });

    }

    private function splash():void
    {
        splashScreen = new Image(sAssets.getTexture("Splash"));
        splashScreen.x = 0;
        splashScreen.y = 0;
        addChild(splashScreen);

        Starling.juggler.delayCall(function():void
        {
            loadGame();
            trace("loadgame");
        }, 2);
    }

    private function loadGame():void
    {
        sAssets.loadQueue(function(ratio:Number):void
        {
            splashScreen = new Image(sAssets.getTexture("Logo"));
            addChild(splashScreen);

            if (ratio == 1)
                Starling.juggler.delayCall(function():void
                {
                    showGame();
                    removeChild(splashScreen,true);
                }, 2);
        });

    }

    private function showGame():void
    {
        if (mGame == null)
            mGame = new Game();
        addChild(mGame);
    }

    public static function get assets():AssetManager { return sAssets; }
}
}
