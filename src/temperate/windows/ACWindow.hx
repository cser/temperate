package temperate.windows;
import flash.display.DisplayObject;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import temperate.core.CSprite;
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
		startDock = new CAlignedPopUpDock();
		
		updateIsLocked();
		updateIsActive();
	}
	
	var _manager:CPopUpManager;
	
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
		startDock.arrange(Std.int(width), Std.int(height), _manager.areaWidth, _manager.areaHeight);
		x = _manager.areaX + startDock.x;
		y = _manager.areaY + startDock.y;
		_manager.add(this, modal);
	}
	
	public function close()
	{
		_manager.remove(this);
	}
	
	public var startDock:ICPopUpDock;
}