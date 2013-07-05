/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/5/13
 * Time: 2:25 PM
 * To change this template use File | Settings | File Templates.
 */
package game.tiles.states {
import game.tiles.Tile;

import starling.display.DisplayObject;

import starling.events.Event;

public class PreviewState extends TileState {

    private var _speed:Number = 0.5;
    private var _delta:Number = 2;
    private var _startPos:Number;
    public function PreviewState(tile:Tile) {
        super(tile);
    }

    override public function Activate():void
    {
        _startPos = _tile.getView().x;
        _tile.getView().addEventListener(Event.ENTER_FRAME, update);
    }

    private function update(event:Event):void {
        var view:DisplayObject = _tile.getView();

        if (_speed > 0 && view.x >= (_startPos + _delta) ||
            _speed < 0 && view.x <= (_startPos - _delta))
        {
            _speed = -_speed;
        }

        view.x += _speed;
    }

    override public function Deactivate():void
    {
        _tile.getView().removeEventListener(Event.ENTER_FRAME, update);
    }
}
}
