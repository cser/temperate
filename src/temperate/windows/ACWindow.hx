package temperate.windows;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import temperate.core.CSprite;
import temperate.skins.CNullWindowSkin;
import temperate.skins.ICWindowSkin;
import temperate.windows.docks.CAlignedPopUpDock;
import temperate.windows.docks.ICPopUpDock;

class ACWindow implements ICPopUp
{
	function new(manager:CPopUpManager) 
	{
		_manager = manager;
		innerDispatcher = new EventDispatcher();
		dock = new CAlignedPopUpDock();
		
		innerDispatcher.addEventListener(Event.RESIZE, onManagerResize);
		
		_baseContainer = newContainer();
		_baseSkin = newSkin();
		_baseSkin.link(_baseContainer);
		view = _baseSkin.view;
		
		_mover = newMover();
		var head = _baseSkin.head;
		if (head != null)
		{
			_mover.subscribe(getManager, this, head, get_dock);
		}
		
		view.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	var _manager:CPopUpManager;
	
	function getManager()
	{
		return _manager;
	}
	
	public var view(default, null):DisplayObject;
	
	public var innerDispatcher(default, null):IEventDispatcher;
	
	public var isLocked(get_isLocked, set_isLocked):Bool;
	function get_isLocked()
	{
		return _baseSkin.isLocked;
	}
	function set_isLocked(value)
	{
		return _baseSkin.isLocked = value;
	}
	
	public var isActive(get_isActive, set_isActive):Bool;
	function get_isActive()
	{
		return _baseSkin.isActive;
	}
	function set_isActive(value)
	{
		return _baseSkin.isActive = value;
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
		view.x = _manager.areaX + dock.x;
		view.y = _manager.areaY + dock.y;
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
	
	function onMouseDown(event:MouseEvent)
	{
		_manager.moveToTop(this);
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
	
	var _mover:CPopUpMover;
	
	function newMover()
	{
		return new CPopUpMover();
	}
	
	public var width(get_width, set_width):Float;
	function get_width()
	{
		return view.width;
	}
	function set_width(value)
	{
		return view.width = value;
	}
	
	public var height(get_height, set_height):Float;
	function get_height()
	{
		return view.height;
	}
	function set_height(value)
	{
		return view.height = value;
	}
}