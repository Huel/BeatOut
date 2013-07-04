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
<<<<<<< HEAD
    private static var sSequencer:StarlingToneMatrix;
=======
    private static var sSequencer:ToneMatrixStarling;
    private var theBoard:GameBoard;
>>>>>>> master

    public function Game()
    {
        if (sSequencer == null)
            sSequencer = new StarlingToneMatrix();

        theBoard = new GameBoard();

        addChild(sSequencer);
        addChild(theBoard);
    }

    public static function get sequencer():StarlingToneMatrix { return sSequencer; }

}
}
