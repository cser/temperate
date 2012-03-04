package temperate.events;
import flash.events.Event;

#if nme
class CEvent extends Event
{
	public function new(type:String, bubbles:Bool = false, cancalable:Bool = false) 
	{
		super(type, bubbles, cancelable);
		_defaultPrevented = false;
	}
	
	private var _defaultPrevented:Bool;
	
	public function isDefaultPrevented():Bool
	{
		return cancelable && _defaultPrevented;
	}
}
#else
typedef CEvent = Event;
#end