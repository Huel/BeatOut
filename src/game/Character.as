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

public class Character extends Tile{


    public var level:int;

    public function Character(amountOfTones:int, level:int, view:Texture)
    {
        super()
        this._amountOfTones = amountOfTones;
        this.level = level;
        this._view = new Image(view);
        initialize();
    }
}
}
