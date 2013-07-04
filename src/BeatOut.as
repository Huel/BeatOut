package
{

import flash.display.Sprite;
import starling.core.Starling;

[SWF(width="1200", height="800", frameRate="60", backgroundColor="#000000")]

public class BeatOut extends Sprite
{
    private var _starling:Starling;

    public function BeatOut()
    {
        Starling.handleLostContext = true;
<<<<<<< HEAD

=======
>>>>>>> master
        _starling = new Starling(StartUp, stage);
        _starling.start();
    }
}
}