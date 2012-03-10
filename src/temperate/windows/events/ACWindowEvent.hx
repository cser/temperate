package temperate.windows.events;
import flash.events.Event;

class ACWindowEvent extends Event
{
	function new(
		type:String, bubbles:Bool, cancelable:Bool, context:CWindowEventContext) 
	{
		super(type, bubbles, cancelable);
		if (context == null)
		{
			_context = new CWindowEventContext();
		}
		else
		{
			_context = context;
		}
	}
	
	private var _context:CWindowEventContext;
	
	public function isWindowPrevented():Bool
	{
		return cancelable && _context.windowPrevented;
	}
	
	public function windowPrevent():Void
	{
		_context.windowPrevented = true;
	}
}