/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 11:46 AM
 * To change this template use File | Settings | File Templates.
 */
package game {
public class CharacterFactory {

    public static function fromString(level:String):Character
    {
        switch (level)
        {
            case 'level1':
                return new Character(1, 1, StartUp.assets.getTexture("Level1Tile"));
            case 'level2':
                return new Character(2, 2, StartUp.assets.getTexture("Level2Tile"));
            case 'level3':
                return new Character(3, 3, StartUp.assets.getTexture("Level3Tile"));
            case 'level4':
                return new Character(4, 4, StartUp.assets.getTexture("Level4Tile"));
        }

        return null;
    }

    public static function fromInt(level:int):Character
    {
        switch (level)
        {
            case 1:
                return new Character(1, 1, StartUp.assets.getTexture("Level1Tile"));
            case 2:
                return new Character(2, 2, StartUp.assets.getTexture("Level2Tile"));
            case 3:
                return new Character(3, 3, StartUp.assets.getTexture("Level3Tile"));
            case 4:
                return new Character(4, 4, StartUp.assets.getTexture("Level4Tile"));
        }

        return null;
    }
}
}
