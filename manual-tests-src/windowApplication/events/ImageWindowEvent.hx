package windowApplication.events;
import flash.events.Event;
import windowApplication.ImageWindow;

class ImageWindowEvent extends Event
{
	public static var CLOSE:String = "imageWindow.close";
	
	public function new(type:String, window:ImageWindow, continuePrevented:Void->Void)
	{
		super(type, true, true);
		this.window = window;
		this.continuePrevented = continuePrevented;
	}
	
	public var window(default, null):ImageWindow;
	
	public var continuePrevented(default, null):Void->Void;
	
	override public function clone():Event
	{
		return new ImageWindowEvent(type, window, continuePrevented);
	}
}