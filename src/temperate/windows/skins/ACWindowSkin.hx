package temperate.windows.skins;
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import temperate.core.CSprite;

class ACWindowSkin extends CSprite, implements ICWindowSkin
{
	function new() 
	{
		super();
		view = this;
		
		_isLocked = false;
		_isActive = false;
	}
	
	public var view(default, null):DisplayObject;
	
	public var head(default, null):InteractiveObject;
	
	public var headHeight(get_headHeight, null):Float;
	function get_headHeight()
	{
		return head != null ? head.height : 0;
	}
	
	var _container:Sprite;
	
	public function link(container:Sprite):Void
	{
		_container = container;
		addChild(_container);
		
		_size_valid = false;
		postponeSize();
		
		updateIsLocked();
		updateIsActive();
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
			_isLocked = value;
			updateIsLocked();
		}
		return _isLocked;
	}
	
	function updateIsLocked()
	{
		mouseEnabled = !_isLocked;
		mouseChildren = !_isLocked;
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
	
	function updateIsActive()
	{
	}
	
	public var title(get_title, set_title):String;
	var _title:String;
	function get_title()
	{
		return _title;
	}
	function set_title(value:String)
	{
		_title = value;
		return _title;
	}
}