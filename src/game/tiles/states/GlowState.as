/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/5/13
 * Time: 11:04 AM
 * To change this template use File | Settings | File Templates.
 */
package game.tiles.states {
import game.tiles.Character;
import game.tiles.EmptyTile;
import game.tiles.Tile;

import starling.display.BlendMode;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.events.Event;

public class GlowState extends TileState{

    private var _glow:DisplayObject;
    private var _speed:Number;
    public function GlowState(tile:Tile) {
        super(tile);

        _glow = new Image(StartUp.assets.getTexture("TileGlow"));
        _glow.touchable = false;
    }

    override public function Activate():void
    {
        var view = _tile.getView();

        // HACK!
        if (_tile is EmptyTile)
        {
            _glow.alpha = 0.3;
            _speed = 0.01;
        }
        else
        {
            _glow.alpha = 0.9;
            _speed = 0.05;
        }

        _glow.x = view.x;
        _glow.y = view.y;

        view.blendMode = BlendMode.ADD;
        view.parent.addChild(_glow);
        view.addEventListener(Event.ENTER_FRAME, update);
        view.addEventListener(Event.REMOVED_FROM_STAGE, remove);
    }

    private function remove(event:Event):void {
        Deactivate();
    }

    private function update(event:Event):void {
        _glow.alpha -= _speed;
        if (_glow.alpha <= 0)
        {
            _tile.getView().removeEventListener(Event.ENTER_FRAME, update);
            Deactivate();
        }
    }

    override public function Deactivate() : void
    {
        var view = _tile.getView();
        view.blendMode = BlendMode.NORMAL;
        view.parent.removeChild(_glow);
    }
}
}
