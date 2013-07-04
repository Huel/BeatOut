/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 11:03 AM
 * To change this template use File | Settings | File Templates.
 */
package interfaces {
public interface IToneMatrix {
    function setPosition(x:int, y:int, on:Boolean) : void;
    function getCurrentSequencerPosition():int;
    function clear() : void;
    function getWidth():int;
    function getHeight():int;
}
}
