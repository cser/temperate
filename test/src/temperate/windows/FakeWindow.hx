package temperate.windows;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import temperate.windows.ICWindow;

class FakeWindow implements ICWindow
{
	public function new() 
	{
		view = new Shape();
		innerDispatcher = new EventDispatcher();
		isOpened = false;
	}
	
	public var isOpened:Bool;
	public var view(default, null):DisplayObject;
	public var innerDispatcher(default, null):IEventDispatcher;
	public var manager:CWindowManager;
	
	public var isLocked(get_isLocked, set_isLocked):Bool;
	var _isLocked:Bool;
	function get_isLocked()
	{
		return _isLocked;
	}
	function set_isLocked(value)
	{
		_isLocked = value;
		return _isLocked;
	}
	
	public var isActive(get_isActive, set_isActive):Bool;
	var _isActive:Bool;
	function get_isActive()
	{
		return _isActive;
	}
	function set_isActive(value)
	{
		_isActive = value;
		return _isActive;
	}
	
	public function animateShow(fast:Bool):Void
	{
	}
	
	public function animateHide(fast:Bool, onComplete:ICWindow->Void):Void
	{
		if (onComplete != null)
		{
			onComplete(this);
		}
	}
}