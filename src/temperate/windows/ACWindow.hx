package temperate.windows;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import temperate.core.CSprite;
import temperate.skins.CNullWindowSkin;
import temperate.skins.ICWindowSkin;
import temperate.windows.docks.CAlignedPopUpDock;
import temperate.windows.docks.ICPopUpDock;

class ACWindow extends CSprite, implements ICPopUp
{
	function new(manager:CPopUpManager) 
	{
		super();
		_manager = manager;
		view = this;
		innerDispatcher = new EventDispatcher();
		dock = new CAlignedPopUpDock();
		
		updateIsLocked();
		updateIsActive();
		
		innerDispatcher.addEventListener(Event.RESIZE, onManagerResize);
		
		_baseContainer = newContainer();
		_baseSkin = newSkin();
		_baseSkin.link(this, _baseContainer);
	}
	
	var _manager:CPopUpManager;
	
	function getManager()
	{
		return _manager;
	}
	
	public var view(default, null):DisplayObject;
	
	public var innerDispatcher(default, null):IEventDispatcher;
	
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
	
	function updateIsLocked()
	{
		mouseEnabled = !_isLocked;
		mouseChildren = !_isLocked;
	}
	
	function updateIsActive()
	{
	}
	
	public function open(modal:Bool)
	{
		onManagerResize();
		_manager.add(this, modal);
	}
	
	public function close()
	{
		_manager.remove(this);
	}
	
	function onManagerResize(event:Event = null)
	{
		dock.arrange(Std.int(width), Std.int(height), _manager.areaWidth, _manager.areaHeight);
		x = _manager.areaX + dock.x;
		y = _manager.areaY + dock.y;
	}
	
	public var dock(get_dock, set_dock):ICPopUpDock;
	var _dock:ICPopUpDock;
	function get_dock()
	{
		return _dock;
	}
	function set_dock(value)
	{
		_dock = value;
		return _dock;
	}
	
	var _baseContainer:Sprite;
	
	function newContainer():Sprite
	{
		return new Sprite();
	}
	
	var _baseSkin:ICWindowSkin;
	
	function newSkin():ICWindowSkin
	{
		return CNullWindowSkin.getInstance();
	}
}