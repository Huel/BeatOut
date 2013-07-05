/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 6:48 PM
 * To change this template use File | Settings | File Templates.
 */
package game {
import flash.utils.getTimer;

import starling.display.DisplayObject;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;

public class Wave extends Sprite {
    private var deltaTime:Number;
    private var prevFrame:int; // The time of the previous frame rendered.
    private var currentFrame:int;
    private var _glow:DisplayObject;
    private var _initialX:Number;
    public var speed:int;
    public var distance:int;
    // The present time.

    public function Wave() {
        super();
        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        stage.addEventListener(Event.ENTER_FRAME, update);

        prevFrame = getTimer();

        _glow = new Image(StartUp.assets.getTexture("WaveGlow"));
        _glow.x = _initialX =  -(_glow.width);
        addChild(_glow);
    }

    public function start()
    {
        _glow.x = _initialX;
        _glow.visible = true;

    }

    private function update(e:Event):void
    {
        currentFrame = getTimer();
        deltaTime = (currentFrame - prevFrame) / 1000;

        if (_glow.visible)
        {
            _glow.x += speed * deltaTime;
            if (_glow.x >= distance)
            {
                _glow.visible = false;
            }
        }

        prevFrame = currentFrame;
    }
}
}
