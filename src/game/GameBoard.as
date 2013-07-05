/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 11:37 AM
 * To change this template use File | Settings | File Templates.
 */
package game {
import flash.geom.Point;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

import interfaces.IToneMatrix;
import starling.display.Sprite;

public class GameBoard extends Sprite
{
    private const COLUMNS:int = 8;
    private const ROWS:int = 4;
    private const TILE_SIZE:int = 125;
    private const BARS_IN_TILE:int = 2;

    private var music:SoundChannel;
    private var musicTransform:SoundTransform;

    public var tiles:Array = new Array();
    private var _toneMatrix:IToneMatrix;
    private var _characterPreview:TilePreview;

    public function GameBoard()
    {

        musicTransform = new SoundTransform(1,0);
        music = StartUp.assets.playSound("Beat",40,100,musicTransform);



        var tonematrix = new StarlingToneMatrix();
        addChild(tonematrix);
        _toneMatrix = tonematrix as IToneMatrix;

        for (var x:int = 0; x < COLUMNS; x++)
        {
            tiles[x] = new Array();
            for (var y:int = 0; y < ROWS; y++)
            {
               SetTile(x, y, new EmptyTile());
            }
        }

        _characterPreview = new TilePreview();
        _characterPreview.pivotX = _characterPreview.width/2;
        _characterPreview.x = this.width/2;
        _characterPreview.y = 500;
        addChild(_characterPreview);

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
        if (tile is EmptyTile)
        {
            PlayTile(tile.getPosition().x, tile.getPosition().y,_characterPreview.next);
            _characterPreview.moveOn();
        }
    }

    private function PlayTile(x:int, y:int, tile:Tile):void {

        var character:Character = tile as Character;
        var equalNeighbours:Array = GetEqualNeighbours(x,y,character.level, true);

        if (equalNeighbours.length >= 2)
        {
            // join neighbours
            for each (var character:Character in equalNeighbours)
            {
                SetTile(character.getPosition().x, character.getPosition().y, new EmptyTile());
            }
            var pumpedUpTile = CharacterFactory.fromInt(character.level+1);
            if (pumpedUpTile)
            {
                PlayTile(x,y, pumpedUpTile);
            }
            else{
                // TODO:Player just matched lots of 4-tiles! Get loads of points!!!1!!11!!!!
                SetTile(x,y,new EmptyTile());
            }
        }
        else
        {
            SetTile(x,y,tile);
        }
    }

    private function GetEqualNeighbours(x:int, y:int, level:int, recurse:Boolean):Array {
        var neighbours:Array = new Array();
        var left:int = Math.max(0,x-1);
        var right:int = Math.min(COLUMNS-1, x+1);
        var up:int = Math.max(0, y-1);
        var down:int = Math.min(ROWS-1, y+1);

        var inspectedTiles:Array = new Array(
            new Point(x, up),
            new Point(x, down),
            new Point(left, y),
            new Point(right, y)
        );

        for each (var pt:Point in inspectedTiles)
        {
            if (pt.x == x && pt.y == y) continue;
            var inspected:Tile = tiles[pt.x][pt.y];
            if (inspected is Character)
            {
                var character:Character = inspected as Character;
                if (character.level == level)
                {
                    if (recurse)
                    {
                        var neighbourNeighbours =
                                GetEqualNeighbours(character.getPosition().x, character.getPosition().y, level, false);
                        for each (var nn:Character in neighbourNeighbours)
                        {
                            neighbours.push(nn);
                        }
                    }
                    neighbours.push(character);
                }
            }
        }

        return neighbours;

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
