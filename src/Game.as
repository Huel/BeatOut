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

import starling.display.Sprite;

public class Game extends Sprite
{
    private var theBoard:GameBoard;

    public function Game()
    {

        theBoard = new GameBoard();
        addChild(theBoard);
    }

}
}
