package temperate.windows.events;
import flash.events.Event;

class CWindowEvent< T > extends Event
{
	public static var CLOSE = "window.close";
	
	public function new(type:String, data:T)
	{
		super(type);
		this.data = data;
	}
	
	public var data(default, null):T;
}