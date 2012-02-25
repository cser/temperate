package temperate.core;
import flash.display.DisplayObject;
import temperate.layouts.parametrization.CChildWrapper;

class FakeBox extends ACValidatable
{	
	public function new(name:String, validator:CValidator) 
	{
		_name = name;
		
		super(validator);
		
		_width = 0;
		_height = 0;
		_components = [];
	}
	
	var _name:String;
	var _width:Float;
	var _height:Float;
	var _components:Array<DisplayObject>;
	
	override public function toString():String
	{
		return _name;
	}
	
	@:getter(width)
	function get_width():Float
	{
		__validateSize();
		return _width;
	}
	
	@:setter(width)
	function set_width(value:Float):Void
	{
		_width = value;
		_size_valid = false;
		postponeSize();
	}
	
	@:getter(height)
	function get_height():Float
	{
		__validateSize();
		return _height;
	}
	
	@:setter(height)
	function set_height(value:Float):Void
	{
		_height = value;
		_size_valid = false;
		postponeSize();
	}
	
	inline function postponeSize():Void
	{
		_validator.postponeSize(this);
	}
	
	inline function postponeView():Void
	{
		_validator.postponeView(this);
	}
	
	public function validate():Void
	{
		__validateView();
	}
	
	public function add(child:DisplayObject):Void
	{
		super.addChild(child);
		_components.push(child);
		_size_valid = false;
		postponeSize();
	}
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			for (component in _components)
			{
				var width = component.width;
			}
		}
	}
	
	public function invalidate():Void
	{
		_size_valid = false;
		postponeSize();
	}
}