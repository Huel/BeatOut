/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/5/13
 * Time: 11:01 AM
 * To change this template use File | Settings | File Templates.
 */
package game.tiles.states {
import game.tiles.Character;
import game.tiles.Tile;

public class TileState {
    protected var _tile:Tile;

    public function TileState(tile:Tile) {
        _tile = tile;
    }

    public function Activate() : void
    {

    }

    public function Deactivate() : void
    {

    }
}
}
