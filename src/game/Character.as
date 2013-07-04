/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 11:30 AM
 * To change this template use File | Settings | File Templates.
 */
package game {
import flash.geom.Point;

import starling.display.DisplayObject;

import starling.display.Image;
import starling.display.Sprite;

import starling.display.Sprite;
import starling.textures.RenderTexture;
import starling.textures.Texture;

public class Character implements ITile{

    private var _amountOfTones:int;
    public var level:int;
    private var _view:DisplayObject;

    public function Character(amountOfTones:int, level:int, view:Texture)
    {
        super()
        this._amountOfTones = amountOfTones;
        this.level = level;
        this._view = new Image(view);
    }

    public function getToneAmount():int {
        return _amountOfTones;
    }

    public function getView():DisplayObject {
        return _view;
    }
}
}
