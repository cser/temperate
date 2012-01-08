package temperate.windows.skins;
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import temperate.core.CSprite;
import temperate.layouts.parametrization.CChildWrapper;

class ACWindowSkin extends CSprite, implements ICWindowSkin
{
	function new() 
	{
		super();
		view = this;
		
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
	var _wrapper:CChildWrapper;
	
	public function link(container:Sprite, wrapper:CChildWrapper):Void
	{
		_container = container;
		addChild(_container);
		
		_wrapper = wrapper;
		
		_size_valid = false;
		postponeSize();
		
		updateIsEnabled();
		updateIsActive();
	}
	
	var _mouseEnabled:Bool;
	
	public function setMouseEnabled(value:Bool):Void
	{
		_mouseEnabled = value;
		updateMouseEnabled();
	}
	
	override function set_isEnabled(value)
	{
		if (_isEnabled != value)
		{
			_isEnabled = value;
			updateIsEnabled();
		}
		return _isEnabled;
	}
	
	function updateIsEnabled()
	{
		updateMouseEnabled();
	}
	
	function updateMouseEnabled()
	{
		mouseEnabled = _isEnabled && _mouseEnabled;
		mouseChildren = _isEnabled && _mouseEnabled;
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