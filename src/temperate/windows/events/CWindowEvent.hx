package temperate.windows.events;
import flash.events.Event;
import temperate.windows.ACWindow;

class CWindowEvent< T > extends Event
{
	public static var CLOSE = "window.close";
	
	public function new(type:String, window:ACWindow<T>, data:T)
	{
		super(type, false, true);
		this.window = window;
		this.data = data;
	}
	
	public var window(default, null):ACWindow<T>;
	
	public var data(default, null):T;
}