package{import flash.display.Sprite;import starling.core.Starling;[SWF(width="1280", height="720", frameRate="60", backgroundColor="#000000")]public class BeatOut extends Sprite{    private var _starling:Starling;    public function BeatOut()    {        Starling.handleLostContext = true;        _starling = new Starling(StartUp, stage);        _starling.start();    }}}