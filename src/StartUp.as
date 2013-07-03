/**
 * Created with IntelliJ IDEA.
 * User: huelfuchsberger
 * Date: 7/3/13
 * Time: 7:42 PM
 * To change this template use File | Settings | File Templates.
 */
package
{
import starling.display.Sprite;
import starling.text.TextField;

public class StartUp extends Sprite
{
    public function StartUp()
    {
        var textField:TextField = new TextField(1200, 300, "BeatOut");
        textField.fontSize = 100;
        textField.color= 0xffffff;
        addChild(textField);
    }
}
}
