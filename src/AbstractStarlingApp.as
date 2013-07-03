/**
 * Created with IntelliJ IDEA.
 * User: huelfuchsberger
 * Date: 7/3/13
 * Time: 7:59 PM
 * To change this template use File | Settings | File Templates.
 */
package
{
    import flash.utils.setTimeout;

    import starling.events.Event;
    import starling.display.Sprite;


    import tonfall.core.blockSize;
    import tonfall.core.Driver;
    import tonfall.core.Engine;
    import tonfall.core.Memory;
    import tonfall.core.Parameter;
    import tonfall.display.ParameterSlider;
    import tonfall.display.Spectrum;

public class AbstractStarlingApp extends Sprite
{
    protected const driver: Driver = Driver.getInstance();
    protected const engine: Engine = Engine.getInstance();

    protected const spectrum: Spectrum = new Spectrum();

    private var _showSpectrum: Boolean;

    private var _sliderIndex: int = 0;

    public function AbstractStarlingApp()
    {
        addEventListener( Event.ADDED_TO_STAGE, addedToStage );

        // preallocate memory for processing single block
        Memory.length = blockSize << 3;

        driver.engine = engine;

        // delay call to avoid glitches (Flashplayer issue)
        setTimeout( driver.init, 100 );
    }

    public function addParameterSlider( parameter: Parameter ): ParameterSlider
    {
        const slider : ParameterSlider = new ParameterSlider( parameter );

        slider.x = 16.0;
        slider.y = 36.0 * ( _sliderIndex++ ) + 16.0;

        addChild( slider as starling.display.DisplayObject );

        return slider;
    }

    public function get showSpectrum() : Boolean
    {
        return _showSpectrum;
    }

    public function set showSpectrum( value: Boolean ) : void
    {
        if( _showSpectrum != value )
        {

            if( value )
                addChild( spectrum  as starling.display.DisplayObject );
            else
                removeChild( spectrum  as starling.display.DisplayObject );

            _showSpectrum = value;
        }
    }

    protected function resize( event: Event = null ) : void
    {
        spectrum.x = ( stage.stageWidth - spectrum.width ) >> 1;
        spectrum.y = ( stage.stageHeight - spectrum.height ) >> 1;
    }

    protected function addedToStage( event: Event ): void
    {
        removeEventListener( Event.ADDED_TO_STAGE, addedToStage );

        stage.addEventListener( Event.RESIZE, resize );

        resize();
    }


}
}
