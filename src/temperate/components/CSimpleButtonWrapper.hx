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
	
	public var isEnabled(get_isEnabled, set_isEnabled):Bool;
	function set_isEnabled(value:Bool)
	{
		return simpleButton.enabled = value;
	}
	function get_isEnabled()
	{
		return simpleButton.enabled;
	}
	
	public var selected(get_selected, set_selected):Bool;
	var _selected:Bool;
	function get_selected()
	{
		return _selected;
	}
	function set_selected(value:Bool)
	{
		_selected = value;
		return _selected;
	}
	
	public function setUseHandCursor(value:Bool)
	{
		simpleButton.useHandCursor = value;
	}
}