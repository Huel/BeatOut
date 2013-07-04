/**
 * Created with IntelliJ IDEA.
 * User: edgar
 * Date: 7/4/13
 * Time: 1:11 PM
 * To change this template use File | Settings | File Templates.
 */
package game {
import interfaces.IToneMatrix;

import mx.utils.StringUtil;

public class MockToneMatrix implements IToneMatrix {

    public function MockToneMatrix() {
    }

    public function setPosition(x:int, y:int, on:Boolean):void {
        trace(StringUtil.substitute("Setting pos:[{0};{1}] to:{2}", x, y, on));
        trace("");



    }

    public function getCurrentSequencerPosition():int {
        return 0;
    }

    public function clear():void {
        trace("Clearing tone matrix");
    }

    public function getWidth():int {
        return 16;
    }

    public function getHeight():int {
        return 16;
    }
}
}
