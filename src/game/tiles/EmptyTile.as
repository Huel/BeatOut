/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 11:39 AM
 * To change this template use File | Settings | File Templates.
 */
package game.tiles {
import game.*;

import flash.geom.Point;

import starling.display.Image;

import starling.display.Sprite;
import starling.textures.Texture;
import starling.display.DisplayObject;

public class EmptyTile extends Tile{

    public function EmptyTile() {
        _view = new Image(StartUp.assets.getTexture("EmptyTile"));
        initialize();
    }

    override public function getToneAmount():int {
        return 0;
    }
}
}
