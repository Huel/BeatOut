/**
 * Created with IntelliJ IDEA.
 * User: huelfuchsberger
 * Date: 7/3/13
 * Time: 10:49 PM
 * To change this template use File | Settings | File Templates.
 */
package
{

import game.GameBoard;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;

public class Game extends Sprite
{
    private var theBoard:GameBoard;
    private var startButton:Button;
    private var quitButton:Button;

    public function Game()
    {
        var Background:Image = new Image(StartUp.assets.getTexture("Background"));
        addChild(Background);

        startButton = new Button(StartUp.assets.getTexture("StartButton"));
        startButton.pivotX = startButton.width/2;
        startButton.pivotY = startButton.height/2;
        startButton.x = Starling.current.viewPort.width/2;
        startButton.y =  Starling.current.viewPort.height/2;
        startButton.addEventListener(Event.TRIGGERED, showGame);
        addChild(startButton);

        quitButton = new Button(StartUp.assets.getTexture("QuitButton"));
        quitButton.fontSize = 30;
        quitButton.scaleX = 0.7;
        quitButton.scaleY = 0.7;
        quitButton.x = Starling.current.viewPort.width - quitButton.width;
        quitButton.y = 0;
        quitButton.addEventListener(Event.TRIGGERED, showMenu);
    }

    private function showMenu(event:Event):void
    {
        removeBoard();
        addChild(startButton);
        removeChild(quitButton);
    }

    private function showGame(event:Event):void
    {
        createGameBoard();
        removeChild(startButton);
        addChild(quitButton);
    }

    public function createGameBoard():void
    {
        theBoard = new GameBoard(3);
        theBoard.pivotX = theBoard.width/2;
        theBoard.pivotY = theBoard.height/2;

        theBoard.x = Starling.current.viewPort.width/2;
        theBoard.y = Starling.current.viewPort.height/2;

        addChild(theBoard);
    }

    public function removeBoard():void
    {
        removeChild(theBoard,true);
    }

}
}
