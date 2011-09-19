package temperate.components;
import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.events.Event;

class CSimpleButtonWrapper implements ICButton
{
	public function new(simpleButton:SimpleButton) 
	{
		this.simpleButton = simpleButton;
		
		view = simpleButton;
	}
	
	public var view(default, null):DisplayObject;
	
	public var simpleButton(default, null):SimpleButton;
	
	public function addEventListener(
		type:String, listener:Dynamic -> Void, useCapture:Bool = false, priority:Int = 0,
		useWeakReference:Bool = false):Void
	{
		simpleButton.addEventListener(type, listener, useCapture, priority, useWeakReference);
	}
	
	public function dispatchEvent(event:Event):Bool
	{
		return simpleButton.dispatchEvent(event);
	}
	
	public function hasEventListener(type:String):Bool
	{
		return simpleButton.hasEventListener(type);
	}
	
	public function removeEventListener(
		type:String, listener:Dynamic -> Void, useCapture:Bool = false):Void
	{
		simpleButton.removeEventListener(type, listener, useCapture);
	}
	
	public function willTrigger(type:String):Bool
	{
		return simpleButton.willTrigger(type);
	}
	
	public function validate():Void
	{
	}
	
	public var enabled(get_enabled, set_enabled):Bool;
	var _enabled:Bool;
	function set_enabled(value:Bool)
	{
		_enabled = value;
		return _enabled;
	}
	function get_enabled()
	{
		return _enabled;
	}
	
	public var useHandCursor:Bool;
}