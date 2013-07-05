/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 11:43 AM
 * To change this template use File | Settings | File Templates.
 */
package game {
import flash.utils.Dictionary;

public class CharacterSpawner {

    private var _spawnRates:Object;

    public function CharacterSpawner() {
        _spawnRates = new Object();
//        _spawnRates['level4'] = 0.05;
//        _spawnRates['level3'] = 0.1;
//        _spawnRates['level2'] = 0.3;
        _spawnRates['level1'] = 0.6;
    }

    private function Randomize():String
    {
        // Assumes dictionary already sorted
        var sum:Number = 0.0;
        for (var key:String in _spawnRates)
        {
            sum += _spawnRates[key];
        }

        var roll:Number = Math.random()*sum;
        var selected:String = 'level1';

        for (var key:String in _spawnRates)
        {
            if (roll < _spawnRates[key])
            {
                selected = key;
                break;
            }
            roll -= _spawnRates[key];
        }

        return selected;
    }

    public function getNext()
    {
        var level = Randomize();
        return CharacterFactory.fromString(level);
    }
}
}
