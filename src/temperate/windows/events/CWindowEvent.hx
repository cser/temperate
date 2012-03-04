package temperate.windows.events;
import flash.events.Event;
import temperate.events.ACEvent;
import temperate.events.CEventContext;
import temperate.windows.ACWindow;

class CWindowEvent< T > extends ACEvent
{
	public static var CLOSE = "window.close";
	
	public function new(
		type:String, window:ACWindow<T>, data:T, fast:Bool, continuePrevented:CWindowEvent<T>->Void,
		context:CEventContext = null
	)
	{
		super(type, false, true, context);
		this.window = window;
		this.data = data;
		this.fast = fast;
		_continuePrevented = continuePrevented;
	}
	
	public var window(default, null):ACWindow<T>;
	
	public var data(default, null):T;
	
	public var fast(default, null):Bool;
	
	var _continuePrevented:CWindowEvent<T>->Void;
	
	public function continuePrevented():Void
	{
		if (isDefaultPrevented())
		{
			_continuePrevented(this);
		}
	}
	
	override public function clone():Event
	{
		return new CWindowEvent(type, window, data, fast, _continuePrevented, _context);
	}
}