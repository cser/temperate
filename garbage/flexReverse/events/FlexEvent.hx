package flexReverse.events;
import flash.events.Event;

class FlexEvent extends Event
{
	public static var UPDATE_COMPLETE:String = "updateComplete";
	
	public function new(type:String, bubbles:Bool = false, cancelable:Bool = false) 
	{
		super(type, bubbles, cancelable);
	}
	
	override public function clone():Event
	{
		return new FlexEvent(type, bubbles, cancelable);
	}	
}