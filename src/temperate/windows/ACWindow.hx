package temperate.windows;
import flash.display.DisplayObject;
import temperate.core.CSprite;

class ACWindow extends CSprite, implements ICPopUp
{
	function new() 
	{
		super();
		view = this;
	}
	
	public var isLocked(get_isLocked, set_isLocked):Bool;
	var _isLocked:Bool;
	function get_isLocked()
	{
		return _isLocked;
	}
	function set_isLocked(value)
	{
		if (_isLocked != value)
		{
			_isLocked = true;
			updateIsLocked();
		}
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
		if (_isActive != value)
		{
			_isActive = value;
			updateIsActive();
		}
		return _isActive;
	}
	
	public var view(default, null):DisplayObject;
	
	function updateIsLocked()
	{
		mouseEnabled = _isLocked;
		mouseChildren = _isLocked;
	}
	
	function updateIsActive()
	{
	}
}