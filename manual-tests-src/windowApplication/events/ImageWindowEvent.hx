package windowApplication.events;
import flash.events.Event;
import temperate.events.ACEvent;
import temperate.events.CEventContext;
import windowApplication.ImageWindow;

class ImageWindowEvent extends ACEvent
{
	public static var CLOSE:String = "imageWindow.close";
	
	public function new(
		type:String, window:ImageWindow, continuePrevented:Void->Void, context:CEventContext = null)
	{
		super(type, true, true, context);
		this.window = window;
		this.continuePrevented = continuePrevented;
	}
	
	public var window(default, null):ImageWindow;
	
	public var continuePrevented(default, null):Void->Void;
	
	override public function clone():Event
	{
		return new ImageWindowEvent(type, window, continuePrevented, _context);
	}
}