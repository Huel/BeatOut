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
    [Embed(source="/../assets/textures/splash.png")]
    public static const Splash:Class;

    private var mLoadingProgress:ProgressBar;
    private var mGame:Game;

    private static var sAssets:AssetManager;

    public function StartUp()
    {
        if (sAssets ==null)
            sAssets = new AssetManager();

        var textField:TextField = new TextField(1200, 300, "BeatOut");
        textField.fontSize = 100;
        textField.color= 0xffffff;
        addChild(textField);


        mLoadingProgress = new ProgressBar(175, 20);
        mLoadingProgress.x = 1200 / 2;
        mLoadingProgress.y = 800 / 2;
        mLoadingProgress.y = 800 * 0.7;
        addChild(mLoadingProgress);

        sAssets.verbose = true;
        sAssets.enqueue(EmbeddedAssets);

        sAssets.loadQueue(function(ratio:Number):void
        {
            mLoadingProgress.ratio = ratio;

            if (ratio == 1)
                Starling.juggler.delayCall(function():void
                {
                    mLoadingProgress.removeFromParent(true);
                    mLoadingProgress = null;
                    removeChild(textField,true);
                    showGame();
                }, 0.15);
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
