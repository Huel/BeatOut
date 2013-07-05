/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 2:21 PM
 * To change this template use File | Settings | File Templates.
 */
package game.ui {
import game.tiles.*;
import game.*;

import starling.display.Button;
import starling.display.Sprite;
import starling.events.TouchEvent;

public class TilePreview extends Sprite{

    public var next:Tile;
    private var _characterSpawner:CharacterSpawner;

    public function TilePreview() {
        _characterSpawner = new CharacterSpawner();
        next = _characterSpawner.getNext();
        addChild(next.getView());
    }

    public function moveOn():void {
       removeChild(next.getView());
//       selected = next;
       next = _characterSpawner.getNext();
       addChild(next.getView());
    }


}
}
