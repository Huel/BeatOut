/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/5/13
 * Time: 2:06 PM
 * To change this template use File | Settings | File Templates.
 */
package game {
import flash.geom.Point;

public class Levels {
    public static var config:Array = new Array(
            // level 0 - hack!
            new Array(),

            // level 1
            new Array(new Point(2,3), new Point(6,2)),

            // level 2
            new Array(new Point(1,3), new Point(5,3), new Point(8,4)),

            // level 3
            new Array(new Point(1,4), new Point(2,2), new Point(3,4),new Point(5,2), new Point(8,4) )

    );

    public static var moveLimit:Array = new Array(
            // level 0 - hack!
            new Array(),

            // level 1
            new Array(25,22,18),

            // level 2
            new Array(40,35,28),

            // level 3
            new Array(68,56,50)
    );
}
}
