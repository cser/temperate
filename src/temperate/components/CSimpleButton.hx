package temperate.components;
import flash.display.DisplayObject;
import flash.display.SimpleButton;

class CSimpleButton extends SimpleButton, implements ICButton
{
	public function new() 
	{
		super();
		
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
}