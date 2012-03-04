package temperate.events;
import flash.events.Event;

class ACEvent extends Event
{
	function new(
		type:String, bubbles:Bool, cancalable:Bool, context:CEventContext) 
	{
		super(type, bubbles, cancelable);
		#if nme
		_context == context != null ? context : new CEventContext();
		#end
	}
	
	private var _context:CEventContext;
	
	#if nme
	public function isDefaultPrevented():Bool
	{
		return cancelable && _context.defaultPrevented;
	}
	
	public function preventDefault():Void
	{
		_context.defaultPrevented = true;
	}
	#end
}