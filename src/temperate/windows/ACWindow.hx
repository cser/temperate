package temperate.windows;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import temperate.skins.CNullWindowSkin;
import temperate.skins.ICWindowSkin;
import temperate.windows.components.ACWindowComponent;
import temperate.windows.components.CBaseWindowComponent;
import temperate.windows.components.CMoveWindowComponent;
import temperate.windows.components.CWindowConstraintsComponent;
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
		
		initComponents();
		
		_mover = newMover();
		addComponent(new CWindowConstraintsComponent());
		addComponent(_mover);
		
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
		move(_manager.areaX + dock.x, _manager.areaY + dock.y);
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
	
	var _mover:ACWindowComponent;
	
	function newMover():ACWindowComponent
	{
		return new CMoveWindowComponent(_baseSkin.head, get_dock);
	}
	
	public var x(get_x, null):Float;
	function get_x()
	{
		return view.x;
	}
	
	public var y(get_y, null):Float;
	function get_y()
	{
		return view.y;
	}
	
	public function move(x:Float, y:Float)
	{
		_top.move(Std.int(x), Std.int(y));
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
	
	public var animator(get_animator, set_animator):ACWindowComponent;
	var _animator:ACWindowComponent;
	function get_animator()
	{
		return _animator;
	}
	function set_animator(value)
	{
		if (_animator != null)
		{
			removeComponent(_animator);
		}
		_animator = value;
		if (_animator != null)
		{
			addComponent(_animator);
		}
		return _animator;
	}
	
	public function animateShow(fast:Bool):Void
	{
		_top.animateShow(fast);
	}
	
	public function animateHide(fast:Bool, onComplete:ICPopUp->Void):Void
	{
		_top.animateHide(fast, onComplete);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Component manager
	//
	//----------------------------------------------------------------------------------------------
	
	function initComponents()
	{
		_base = new CBaseWindowComponent();
		addComponent(_base);
	}
	
	var _top:ACWindowComponent;
	var _base:ACWindowComponent;
	
	function addComponent(component:ACWindowComponent)
	{
		if (_top == null)
		{
			_top = component;
			_top.next = null;
		}
		else
		{
			component.next = _top;
			_top = component;
		}
		component.subscribe(this, getManager, _baseSkin);
	}
	
	function removeComponent(component:ACWindowComponent)
	{
		if (_top == component)
		{
			_top = component.next;
		}
		var current = _top;
		while (current != null)
		{
			if (current.next == component)
			{
				current.next = component.next;
				break;
			}
			current = current.next;
		}
		component.unsubscribe(this);
		component.next = null;
	}
}