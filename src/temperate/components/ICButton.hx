package temperate.components;
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;

interface ICButton implements IEventDispatcher
{
	public var view(default, null):DisplayObject;
	
	public var isEnabled(get_isEnabled, set_isEnabled):Bool;
	
	public var useHandCursor:Bool;
	
	public function validate():Void;
}