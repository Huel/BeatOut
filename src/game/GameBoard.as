/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 11:37 AM
 * To change this template use File | Settings | File Templates.
 */
package game {
import flash.display.Screen;
import flash.geom.Point;

import interfaces.IToneMatrix;

import starling.display.Sprite;
import starling.events.TouchEvent;

public class GameBoard extends Sprite {
    private const COLUMNS:int = 8;
    private const ROWS:int = 4;
    private const TILE_SIZE:int = 125;
    private const BARS_IN_TILE:int = 2;

    public var tiles:Array = new Array();
    private var _toneMatrix:IToneMatrix;
    private var _tilePreview:TilePreview;

    public function GameBoard() {

        _toneMatrix = new MockToneMatrix();

        for (var x:int = 0; x < COLUMNS; x++)
        {
            tiles[x] = new Array();
            for (var y:int = 0; y < ROWS; y++)
            {
               SetTile(x, y, new EmptyTile());
            }
        }

        _tilePreview = new TilePreview();
        _tilePreview.x = 600;
        _tilePreview.y = 600;
        addChild(_tilePreview);
    }

    private function SetTile(x:int, y:int, tile:Tile):void {

        if (tiles[x][y] != null)
        {
            var prevTile:Tile = tiles[x][y] as Tile;
            prevTile.removeEventListener(TileTouchEvent.TILE_TOUCHED, onTileTouch)
            var view = prevTile.getView();

            removeChild(view);
        }

        tile.setPosition(x, y);

        // Add to display list
        tiles[x][y] = tile;
        tile.addEventListener(TileTouchEvent.TILE_TOUCHED, onTileTouch)
        var view = tile.getView();
        view.x = x * TILE_SIZE;
        view.y = y * TILE_SIZE;
        addChild(view);

        SetTone(x,y,tile);
    }

    private function onTileTouch(event:TileTouchEvent):void {
        var tile:Tile = event.target as Tile;
        trace("Tile: " + tile);
        var pos:Point = tile.getPosition();
        var next:Tile = _tilePreview.next;
        SetTile(pos.x, pos.y, next);
        _tilePreview.moveOn();
    }

    private function SetTone(x:int, y:int, tile:Tile):void {
        var startX:int = x*BARS_IN_TILE;
        var endX:int = startX + BARS_IN_TILE;
        var tonesInTile:int = _toneMatrix.getHeight() / ROWS;
        var startY:int = y*tonesInTile;
        var endY:int = startY + tonesInTile;

        for (var ix:int = startX; ix < endX; ix++)
        {
            for (var iy:int = startY; iy < endY; iy++)
            {
                _toneMatrix.setPosition(ix, iy, false);
            }
        }

        //Change this to random function later
        var count:int = 0;
        for (var ix:int = startX; ix < endX; ix++)
        {
            for (var iy:int = startY; iy < endY; iy++)
            {
                if (count < tile.getToneAmount())
                {
                    _toneMatrix.setPosition(ix, iy, true);
                    count++;
                }
                else
                {
                    break;
                }
            }
        }
    }
}
}
