/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/5/13
 * Time: 11:02 AM
 * To change this template use File | Settings | File Templates.
 */
package game.states {
import game.Character;
import game.Tile;

public class NormalState extends TileState{

    public function NormalState(tile:Tile) {
        super(tile);
    }

    public override function Activate() : void
    {

    }

    public override function Deactivate():void{

    }
}
}
