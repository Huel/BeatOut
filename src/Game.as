/**
 * Created with IntelliJ IDEA.
 * User: huelfuchsberger
 * Date: 7/3/13
 * Time: 10:49 PM
 * To change this template use File | Settings | File Templates.
 */
package
{
import starling.display.Sprite;

public class Game extends Sprite
{
    private static var sSequencer:StarlingToneMatrix;

    public function Game()
    {
        if (sSequencer == null)
            sSequencer = new StarlingToneMatrix();

        addChild(sSequencer);
    }

    public static function get sequencer():StarlingToneMatrix { return sSequencer; }

}
}
