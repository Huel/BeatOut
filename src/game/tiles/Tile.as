/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 11:37 AM
 * To change this template use File | Settings | File Templates.
 */
package game.tiles {
import game.*;

import flash.geom.Point;

import game.tiles.states.GlowState;

import game.tiles.states.NormalState;
import game.tiles.states.PreviewState;
import game.tiles.states.TileState;

import starling.display.DisplayObject;
import starling.events.Event;
import starling.events.EventDispatcher;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class Tile extends EventDispatcher {

    protected var _view:DisplayObject;
    private var _position:Point;
    protected var _amountOfTones:int;

    //States
    private var normalState:NormalState;
    private var glowState:GlowState;
    private var previewState:PreviewState;
    private var _currentState:TileState;
    private var _lastState:TileState;


    protected function initialize():void {

        //States
        normalState = new NormalState(this);
        glowState = new GlowState(this);
        previewState = new PreviewState(this);

        _currentState = normalState;

        _view.addEventListener(TouchEvent.TOUCH, onViewTapped)
        _view.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
    }

    private function onRemoved(event:Event):void {
        _currentState.Deactivate();
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

    public function setState(state:String):void
    {
        var newState:TileState;

        switch (state.toLowerCase())
        {
            case 'normal':
                newState = normalState;
                break;
            case 'glow':
                newState = glowState;
                break;
            case 'wobble':
                newState = previewState;
                break;
        }

        _currentState.Deactivate();
        _currentState = newState;
        _currentState.Activate();
    }

    public function glow():void
    {
        var glowState:GlowState = new GlowState(this);
        glowState.Activate();
    }
}
}
