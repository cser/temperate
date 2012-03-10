package temperate.windows.events;
import flash.events.Event;
import temperate.windows.ACWindow;

class CWindowEvent< T > extends ACWindowEvent
{
	public static var CLOSE = "window.close";
	
	public function new(
		type:String, window:ACWindow<T>, data:T, fast:Bool,
		continueWindowPrevented:CWindowEvent<T>->Void, context:CWindowEventContext = null
	)
	{
		super(type, false, true, context);
		this.window = window;
		this.data = data;
		this.fast = fast;
		_continueWindowPrevented = continueWindowPrevented;
	}
	
	public var window(default, null):ACWindow<T>;
	
	public var data(default, null):T;
	
	public var fast(default, null):Bool;
	
	var _continueWindowPrevented:CWindowEvent<T>->Void;
	
	public function continueWindowPrevented():Void
	{
		if (isWindowPrevented())
		{
			_continueWindowPrevented(this);
		}
	}
	
	override public function clone():Event
	{
		return new CWindowEvent(type, window, data, fast, _continueWindowPrevented, _context);
	}
}