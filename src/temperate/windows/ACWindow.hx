package temperate.windows;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import temperate.collections.CPriorityList;
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
	
	public var x(get_x, null):Int;
	function get_x()
	{
		return _head.getX();
	}
	
	public var y(get_y, null):Int;
	function get_y()
	{
		return _head.getY();
	}
	
	public function move(x:Float, y:Float)
	{
		_head.move(Std.int(x), Std.int(y));
	}
	
	public var width(get_width, null):Int;
	function get_width()
	{
		return _head.getWidth();
	}
	
	public var height(get_height, null):Int;
	function get_height()
	{
		return _head.getHeight();
	}
	
	public function setSize(width:Float, height:Float):Void
	{
		_head.setSize(Std.int(width), Std.int(height));
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
			_animator.priority = PRIORITY_ANIMATOR;
			addComponent(_animator);
		}
		return _animator;
	}
	
	public function animateShow(fast:Bool):Void
	{
		_head.animateShow(fast);
	}
	
	public function animateHide(fast:Bool, onComplete:ICPopUp->Void):Void
	{
		_head.animateHide(fast, onComplete);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Component manager
	//
	//----------------------------------------------------------------------------------------------
	
	static var PRIORITY_BASE = 0;
	static var PRIORITY_ANIMATOR = 1;
	static var PRIORITY_CONSTRAINTS = 2;
	static var PRIORITY_MOVER = 3;
	
	var _components:CPriorityList<ACWindowComponent>;
	var _base:ACWindowComponent;
	var _constraints:ACWindowComponent;
	var _head:ACWindowComponent;
	
	function initComponents()
	{
		_components = new CPriorityList();
		
		_base = new CBaseWindowComponent();
		_base.priority = PRIORITY_BASE;
		addComponent(_base);
		
		_constraints = new CWindowConstraintsComponent();
		_constraints.priority = PRIORITY_CONSTRAINTS;
		addComponent(_constraints);
		
		_mover = newMover();
		_mover.priority = PRIORITY_MOVER;
		addComponent(_mover);
	}
	
	function addComponent(component:ACWindowComponent)
	{
		if (!_components.exists(component))
		{
			_components.add(component);
			component.subscribe(this, getManager, _baseSkin);
			_head = _components.head;
		}
	}
	
	function removeComponent(component:ACWindowComponent)
	{
		if (_components.exists(component))
		{
			component.unsubscribe();
			_components.remove(component);
			_head = _components.head;
		}
	}
}