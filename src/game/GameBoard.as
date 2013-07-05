/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 11:37 AM
 * To change this template use File | Settings | File Templates.
 */
package game {
import flash.geom.Point;

import game.tiles.Character;

import game.tiles.EmptyTile;
import game.tiles.GoalTile;
import game.tiles.Tile;
import game.ui.TilePreview;
import game.tiles.TileTouchEvent;

import interfaces.IToneMatrix;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.formatString;

import tonfall.format.pcm.PCMSound;

public class GameBoard extends Sprite {
    private const COLUMNS:int = 8;
    private const ROWS:int = 4;
    private const TILE_SIZE:int = 125;
    private const BARS_IN_TILE:int = 2;
    private const TONES_IN_TILE:int = 4;
    private static var sBeats:BeatPlayer;
    private var _moves:int;
    private var _movesTextField:TextField;
    private var soundTest:int = 1 ;


    public var tiles:Array = new Array();
    private var _toneMatrix:IToneMatrix;
    private var _characterPreview:TilePreview;
//    private var _wave:Wave;

    public function GameBoard(level:int) {

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

        loadLevel(level);

        if (sBeats ==null)
            sBeats = new BeatPlayer();

        var tonematrix:StarlingToneMatrix = new StarlingToneMatrix();
        _toneMatrix = tonematrix as IToneMatrix;
        _toneMatrix.setNotePlayDelegate(onNotePlayed);
        _toneMatrix.setBeatDelegate(onSequencerStep);

//        _wave = new Wave();
//        _wave.speed = TILE_SIZE * 4;
//        _wave.distance = TILE_SIZE*COLUMNS;
//        addChild(_wave);

        addChild(tonematrix);
    }

    private function loadLevel(level:int):void {
        for each (var point:Point in Levels.config[level])
        {
            SetTile(point.x, point.y, new GoalTile());
        }

        _moves = Levels.moveLimit[level][0];

        _movesTextField= new TextField(100, 50, " Moves : " + _moves, "Verdana", 20, 0xFFFFFF, true);
        _movesTextField.x = _characterPreview.x - 300;
        _movesTextField.y = _characterPreview.y;
        addChild(_movesTextField);
    }

    private function onSequencerStep(bar:int):void {
        if (bar % BARS_IN_TILE == 0)
        {
            for each (var tile:Tile in tiles[bar/BARS_IN_TILE])
            {
               tile.glow();
            }
        }
        if(bar == 0)
        {
            sBeats.play();
        }

    }

    private function onNotePlayed(step:int, note:int):void {
//        if ((step%BARS_IN_TILE == 0) && (note%TONES_IN_TILE == 0))
//        {
//            var x:int = step/BARS_IN_TILE;
//            var y:int = note/TONES_IN_TILE;
//            var character:Character = tiles[x][y];
//            character.setState('glow');
//        }
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

        if (_toneMatrix)
        {
            SetTone(x,y,tile);
        }
    }

    private function onTileTouch(event:TileTouchEvent):void {
        var tile:Tile = event.target as Tile;
        if (tile is EmptyTile)
        {
            PlayTile(tile.getPosition().x, tile.getPosition().y,_characterPreview.next);
            _characterPreview.moveOn();
        }
        else if (tile is GoalTile)
        {
            var neighbours:Array = new Array();
            var result:Character =
                    PreviewPlay(tile.getPosition().x, tile.getPosition().y, _characterPreview.next as Character, neighbours);
            if (result.level == 4)
            {
                PlayTile(tile.getPosition().x, tile.getPosition().y,_characterPreview.next);
                var gameWon:Boolean = CheckGameWon();
                if (gameWon)
                {
                    GoToResultScreen();
                }
            }
        }

    }

    private function GoToResultScreen():void {

    }

    private function CheckGameWon():Boolean {
        for (var x:int = 0; x < COLUMNS; x++)
        {
            for (var y:int = 0; y < ROWS; y++)
            {
                 if (tiles[x][y] is GoalTile)
                 {
                     return false;
                 }
            }
        }

        return true;
    }


    private function PreviewPlay(x:int, y:int, character:Character, neighbours:Array):Character
    {
        var equalNeighbours:Array = GetEqualNeighbours(x,y,character.level, true);

        if (equalNeighbours.length >= 2)
        {
            // join neighbours
            for each (var neighbour:Character in equalNeighbours)
            {
//                SetTile(character.getPosition().x, character.getPosition().y, new EmptyTile());
                neighbours.push(neighbour);
            }
            var pumpedUpTile = CharacterFactory.fromInt(character.level+1);
            if (pumpedUpTile)
            {
                return PreviewPlay(x,y, pumpedUpTile, neighbours);
            }
            else{
                // Player just matched lots of 4-tiles.
                // Do nothing
            }
        }
        return character;
    }

    private function PlayTile(x:int, y:int, tile:Tile):void {
        var neighbours:Array = new Array();
        var result:Character = PreviewPlay(x,y, tile as Character, neighbours)
        for each (var neighbour:Character in neighbours)
        {
            SetTile(neighbour.getPosition().x, neighbour.getPosition().y, new EmptyTile());
        }
        SetTile(x,y,result);

        _moves--;
        if (_moves <= 0)
        {
            GoToResultScreen();
        }
        else
        {
            _movesTextField.text = "Moves: " + _moves;
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
        var startY:int = y*TONES_IN_TILE;
        var endY:int = startY + TONES_IN_TILE;

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

    public static function get beats():BeatPlayer { return sBeats; }

}
}
