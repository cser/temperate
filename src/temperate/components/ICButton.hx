package temperate.components;
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;

interface ICButton implements IEventDispatcher
{
	public var view(default, null):DisplayObject;
	
	public var enabled(get_enabled, set_enabled):Bool;
	
	public var useHandCursor:Bool;
	
	public function validate():Void;
}