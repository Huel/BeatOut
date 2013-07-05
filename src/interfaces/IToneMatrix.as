
package interfaces {
public interface IToneMatrix {
    function setPosition(x:int, y:int, on:Boolean) : void;
    function setNotePlayDelegate(delegate:Function):void;
    function setBeatDelegate(delegate:Function):void;
    //function clear() : void;
    function getWidth():int;
    function getHeight():int;
}
}
