/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 11:37 AM
 * To change this template use File | Settings | File Templates.
 */
package game {
import flash.geom.Point;

import starling.display.DisplayObject;

public interface ITile {
    function getToneAmount():int;
    function getView():DisplayObject;
}
}
