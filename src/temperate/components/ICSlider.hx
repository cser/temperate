package temperate.components;
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;

/**
 * @dispatch flash.events.Event.CHANGE
 */
interface ICSlider implements IEventDispatcher
{
	var view(default, null):DisplayObject;
	
	var value(get_value, set_value):Float;
	
	var minValue(get_minValue, set_minValue):Float;
	
	var maxValue(get_maxValue, set_maxValue):Float;
	
	var step(get_step, set_step):Float;
}