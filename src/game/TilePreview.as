/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 2:21 PM
 * To change this template use File | Settings | File Templates.
 */
package game {
import starling.display.Button;
import starling.display.Sprite;
import starling.events.TouchEvent;

public class TilePreview extends Sprite{

    private var _next:ITile;
    public var selected:ITile;
    private var _characterSpawner:CharacterSpawner;

    public function TilePreview() {
        _characterSpawner = new CharacterSpawner();
        _next = _characterSpawner.getNext();
        addChild(_next.getView());

        addEventListener(TouchEvent.TOUCH, onTouched);
    }

    private function onTouched(event:TouchEvent):void {
       removeChild(_next.getView());
       selected = _next;
       _next = _characterSpawner.getNext();
       addChild(_next.getView());
    }


}
}
