
package interfaces {
public interface IToneMatrix {
    function setPosition(x:int, y:int, on:Boolean) : void;
    function getCurrentSequencerPosition():int;
    function clear() : void;
}
}
