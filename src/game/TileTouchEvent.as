/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 3:14 PM
 * To change this template use File | Settings | File Templates.
 */
package game {
import starling.events.Event;

public class TileTouchEvent extends Event {

    public static const TILE_TOUCHED:String = "tile_touched";
    public var tile:Tile;

    public function TileTouchEvent(tile:Tile, bubbles:Boolean = false, data:Object = null) {
        super(TILE_TOUCHED, bubbles, data);
        this.tile = tile;
    }
}
}
