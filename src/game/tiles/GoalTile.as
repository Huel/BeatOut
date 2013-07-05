/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/5/13
 * Time: 2:02 PM
 * To change this template use File | Settings | File Templates.
 */
package game.tiles {
import game.*;

import starling.display.Image;

public class GoalTile extends Tile {
    public function GoalTile() {
        _view = new Image(StartUp.assets.getTexture("GoalTile"));
        initialize();
    }

    override public function getToneAmount():int {
        return 0;
    }
}
}
