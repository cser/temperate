package temperate.components;
import flash.display.DisplayObject;
import flash.display.SimpleButton;

class CSimpleButton extends SimpleButton, implements ICButton
{
	public function new(
		?upState:DisplayObject, ?overState:DisplayObject, ?downState:DisplayObject,
		?hitTestState:DisplayObject)
	{
		super(upState, overState, downState, hitTestState);
		
		view = this;
	}
	
	public var view(default, null):DisplayObject;
	
	public function validate():Void
	{
	}
	
	public var isEnabled(get_isEnabled, set_isEnabled):Bool;
	function get_isEnabled()
	{
		return enabled;
	}
	function set_isEnabled(value)
	{
		return enabled = value;
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
		useHandCursor = value;
	}
}