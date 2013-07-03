package {

import flash.display.Sprite;
import flash.text.TextField;

public class BeatOut extends Sprite {
    public function BeatOut() {
        var textField:TextField = new TextField();
        textField.text = "Hello, World";
        addChild(textField);
    }
}
}
