/**
 * Created with IntelliJ IDEA.
 * User: huelfuchsberger
 * Date: 7/3/13
 * Time: 10:49 PM
 * To change this template use File | Settings | File Templates.
 */
package
{
import flash.media.SoundChannel;

import game.GameBoard;

import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;

public class Game extends Sprite
{
    private var theBoard:GameBoard;

    public function Game()
    {


        var Background:Image = new Image(StartUp.assets.getTexture("Background"));

        theBoard = new GameBoard();
        theBoard.pivotX = theBoard.width/2;
        theBoard.pivotY = theBoard.height/2;

        theBoard.x = Starling.current.viewPort.width/2;
        theBoard.y = Starling.current.viewPort.height/2;

        addChild(Background);
        addChild(theBoard);
    }

}
}
