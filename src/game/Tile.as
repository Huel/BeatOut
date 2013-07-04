/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 11:37 AM
 * To change this template use File | Settings | File Templates.
 */
package game {
import flash.geom.Point;

import starling.display.DisplayObject;
import starling.events.EventDispatcher;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class Tile extends EventDispatcher {

    protected var _view:DisplayObject;
    private var _position:Point;
    protected var _amountOfTones:int;

    protected function initialize():void {
        _view.addEventListener(TouchEvent.TOUCH, onViewTapped)
    }

    private function onViewTapped(event:TouchEvent):void {

        var touches:Vector.<Touch> = event.getTouches(_view,TouchPhase.ENDED);
        if(touches.length == 0) return;

        trace("here");
        event.stopPropagation();

        dispatchEvent(new TileTouchEvent(this));
    }


    public function getToneAmount():int {
        return _amountOfTones;
    }

    public function getView():DisplayObject {
        return _view;
    }

    public function getPosition():Point {
        return _position;
    }

    public function setPosition(x:int, y:int):void {
        _position = new Point(x, y);
    }
}
}
