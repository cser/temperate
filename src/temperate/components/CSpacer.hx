package temperate.components;
import flash.display.Shape;

/**
 * Needs in some layout cases for filling spans
 */
class CSpacer extends Shape
{
	public function new() 
	{
		super();
		_width = 0;
		_height = 0;
	}
	
	var _width:Float;
	var _height:Float;
	
	@:getter(width)
	function get_width():Float
	{
		return _width;
	}
	
	@:setter(width)
	function set_width(value:Float):Void
	{
		_width = value;
	}
	
	@:getter(height)
	function get_height():Float
	{
		return _height;
	}
	
	@:setter(height)
	function set_height(value:Float):Void
	{
		_height = value;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	public function setSize(width:Float, height:Float)
	{
		_width = width;
		_height = height;
		return this;
	}
}