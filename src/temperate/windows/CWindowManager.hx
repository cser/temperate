package temperate.windows;
import flash.display.DisplayObjectContainer;

class CWindowManager 
{
	public function new() 
	{
	}
	
	public var container(get_container, set_container):DisplayObjectContainer;
	var _container:DisplayObjectContainer;
	function get_container()
	{
		return _container;
	}
	function set_container(value:DisplayObjectContainer)
	{
		_container = value;
		return _container;
	}
	
	public var left(default, null):Int;
	
	public var top(default, null):Int;
	
	public var right(default, null):Int;
	
	public var bottom(default, null):Int;
	
	public function setBounds(left:Int, right:Int, top:Int, bottom:Int)
	{
		this.left = left;
		this.right = right;
		this.top = top;
		this.bottom = bottom;
	}
}