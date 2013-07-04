/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 11:39 AM
 * To change this template use File | Settings | File Templates.
 */
package game {
import flash.geom.Point;

import starling.display.Image;

import starling.display.Sprite;
import starling.textures.Texture;
import starling.display.DisplayObject;

public class EmptyTile implements ITile {

    private var _view : DisplayObject;

    public function EmptyTile() {
        _view = new Image(StartUp.assets.getTexture("EmptyTile"));
    }

    public function getToneAmount():int {
        return 0;
    }

    public function getView():DisplayObject{
        return _view;
    }
}
}
