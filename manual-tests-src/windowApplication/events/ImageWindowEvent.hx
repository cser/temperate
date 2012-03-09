package windowApplication.events;
import flash.events.Event;
import temperate.windows.events.ACWindowEvent;
import temperate.windows.events.CWindowEventContext;
import windowApplication.ImageWindow;

class ImageWindowEvent extends ACWindowEvent
{
	public static var CLOSE:String = "imageWindow.close";
	
	public function new(
		type:String, window:ImageWindow, continuePrevented:Void->Void,
		context:CWindowEventContext = null)
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