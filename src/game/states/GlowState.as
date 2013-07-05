/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/5/13
 * Time: 11:04 AM
 * To change this template use File | Settings | File Templates.
 */
package game.states {
import game.Character;
import game.Tile;

import starling.display.BlendMode;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.events.Event;

public class GlowState extends TileState{

    private var _glow:DisplayObject;
    public function GlowState(tile:Tile) {
        super(tile);

        _glow = new Image(StartUp.assets.getTexture("TileGlow"));
    }

    override public function Activate():void
    {
        var view = _tile.getView();

        _glow.alpha = 1;
        _glow.x = view.x;
        _glow.y = view.y;

        view.blendMode = BlendMode.ADD;
        view.parent.addChild(_glow);
        view.addEventListener(Event.ENTER_FRAME, update);
    }

    private function update(event:Event):void {
        _glow.alpha -= 0.05;
        if (_glow.alpha <= 0)
        {
            _tile.getView().removeEventListener(Event.ENTER_FRAME, update);
            _tile.setState('normal');
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
