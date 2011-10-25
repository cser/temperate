package temperate.components;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.utils.TypedDictionary;

/**
 * Events:
 * flash.events.Event.CHANGE
 */
class CButtonSelector< T > extends EventDispatcher
{
	var _useMouseDown:Bool;
	
	public function new(value:T, useMouseDown:Bool = false) 
	{
		super();
		
		_useMouseDown = useMouseDown;
		_values = new TypedDictionary();
		_value = value;
	}
	
	private var _values:TypedDictionary<ICButton, T>;
	
	public function add(button:ICButton, value:T)
	{
		_values.set(button, value);
		button.selected = value == _value;
		button.addEventListener(
			_useMouseDown ? MouseEvent.MOUSE_DOWN : MouseEvent.CLICK,
			onButtonEvent);
	}
	
	public function remove(button:ICButton)
	{
		_values.delete(button);
		button.removeEventListener(
			_useMouseDown ? MouseEvent.MOUSE_DOWN : MouseEvent.CLICK,
			onButtonEvent);
	}
	
	public var value(get_value, set_value):T;
	var _value:T;
	function get_value()
	{
		return _value;
	}
	function set_value(value)
	{
		if (value != _value)
		{
			_value = value;
			updateValue();
		}
		return _value;
	}
	
	function onButtonEvent(event:MouseEvent)
	{
		var selectedButton = cast(event.target, ICButton);
		value = _values.get(selectedButton);
	}
	
	function updateValue()
	{
		for (button in _values)
		{
			button.selected = _values.get(button) == _value;
		}
		dispatchEvent(new Event(Event.CHANGE));
	}
}