package temperate.windows;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import temperate.collections.CPriorityList;
import temperate.collections.ICValueSwitcher;
import temperate.core.CGeomUtil;
import temperate.windows.components.ACWindowComponent;
import temperate.windows.components.CWindowBaseComponent;
import temperate.windows.components.CWindowConstraintsComponent;
import temperate.windows.components.CWindowMaximizeComponent;
import temperate.windows.components.CWindowMoveComponent;
import temperate.windows.components.CWindowResizeComponent;
import temperate.windows.docks.CWindowAlignedDock;
import temperate.windows.docks.ICWindowDock;
import temperate.windows.skins.ICWindowSkin;

class ACWindow implements ICWindow
{
	function new() 
	{
		isOpened = false;
		innerDispatcher = new EventDispatcher();
		dock = new CWindowAlignedDock();
		
		innerDispatcher.addEventListener(Event.RESIZE, onManagerResize);
		
		_baseContainer = newContainer();
		_baseSkin = newSkin();
		_baseSkin.link(_baseContainer);
		view = _baseSkin.view;
		
		initComponents();
		
		moveToTopOnMouseDown = true;
	}
	
	function getManager()
	{
		return manager;
	}
	
	public var moveToTopOnMouseDown(get_moveToTopOnMouseDown, set_moveToTopOnMouseDown):Bool;
	var _moveToTopOnMouseDown:Bool;
	function get_moveToTopOnMouseDown()
	{
		return _moveToTopOnMouseDown;
	}
	function set_moveToTopOnMouseDown(value)
	{
		_moveToTopOnMouseDown = value;
		if (_moveToTopOnMouseDown)
		{
			view.addEventListener(MouseEvent.MOUSE_DOWN, onMoveToTopMouseDown);
		}
		else
		{
			view.removeEventListener(MouseEvent.MOUSE_DOWN, onMoveToTopMouseDown);
		}
		return _moveToTopOnMouseDown;
	}
	
	public var isOpened:Bool;
	
	public var manager:CWindowManager;
	
	public var view(default, null):DisplayObject;
	
	public var innerDispatcher(default, null):IEventDispatcher;
	
	public var title(get_title, set_title):String;
	function get_title()
	{
		return _baseSkin.title;
	}
	function set_title(value)
	{
		_baseSkin.title = value;
		return value;
	}
	
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
	
	function onManagerResize(event:Event = null)
	{
		dock.arrange(Std.int(width), Std.int(height), manager.areaWidth, manager.areaHeight);
		_head.move(manager.areaX + dock.x, manager.areaY + dock.y, false);
	}
	
	public var dock(get_dock, set_dock):ICWindowDock;
	var _dock:ICWindowDock;
	function get_dock()
	{
		return _dock;
	}
	function set_dock(value)
	{
		_dock = value;
		return _dock;
	}
	
	function onMoveToTopMouseDown(event:MouseEvent)
	{
		if (manager != null)
		{
			manager.moveToTop(this);
		}
	}
	
	var _baseContainer:Sprite;
	
	function newContainer():Sprite
	{
		return new Sprite();
	}
	
	var _baseSkin:ICWindowSkin;
	
	function newSkin():ICWindowSkin
	{
		return null;
	}
	
	var _mover:ACWindowComponent;
	
	function newMover():ACWindowComponent
	{
		return new CWindowMoveComponent(_baseSkin.head);
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
		_head.move(Std.int(x), Std.int(y), true);
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
			_animator.priority = CWindowComponentPriority.ANIMATOR;
			addComponent(_animator);
		}
		return _animator;
	}
	
	public function animateShow(fast:Bool):Void
	{
		_head.animateShow(fast);
	}
	
	public function animateHide(fast:Bool, onComplete:ICWindow->Void):Void
	{
		_head.animateHide(fast, onComplete);
	}
	
	public var maximized(get_maximized, set_maximized):Bool;
	var _maximized:Bool;
	function get_maximized()
	{
		return _maximized;
	}
	function set_maximized(value)
	{
		if (_maximized != value)
		{
			_maximized = value;
			if (_maximized)
			{
				if (_maximizeComponent == null)
				{
					_maximizeComponent = newMaximizeComponent();
					_maximizeComponent.priority = CWindowComponentPriority.MAXIMIZE;
				}
				addComponent(_maximizeComponent);
			}
			else
			{
				removeComponent(_maximizeComponent);
			}
		}
		return _maximized;
	}
	
	var _maximizeComponent:ACWindowComponent;
	
	function newMaximizeComponent():ACWindowComponent
	{
		return new CWindowMaximizeComponent();
	}
	
	var _resizeComponent:ACWindowComponent;
	
	public var resizable(get_resizable, set_resizable):Bool;
	var _resizable:Bool;
	function get_resizable()
	{
		return _resizable;
	}
	function set_resizable(value)
	{
		if (_resizable != value)
		{
			_resizable = value;
			if (_resizable)
			{
				if (_resizeComponent == null)
				{
					_resizeComponent = newResizeComponent();
					_resizeComponent.priority = CWindowComponentPriority.RESIZE;
				}
				addComponent(_resizeComponent);
			}
		}
		else
		{
			removeComponent(_resizeComponent);
		}
		return _resizable;
	}
	
	function newResizeComponent():ACWindowComponent
	{
		return new CWindowResizeComponent(isInMarker, newResizeCursor());
	}
	
	function isInMarker():Bool
	{
		var w = view.width;
		var h = view.height;
		var d = 20;
		return CGeomUtil.isInTriangle(w, h, w - d, h, w, h - d, view.mouseX, view.mouseY);
	}
	
	function newResizeCursor():ICValueSwitcher<Dynamic>
	{
		return null;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Component manager
	//
	//----------------------------------------------------------------------------------------------
	
	var _components:CPriorityList<ACWindowComponent>;
	var _base:ACWindowComponent;
	var _constraints:ACWindowComponent;
	var _head:ACWindowComponent;
	
	function initComponents()
	{
		_components = new CPriorityList();
		
		_base = new CWindowBaseComponent();
		_base.priority = CWindowComponentPriority.BASE;
		addComponent(_base);
		
		_constraints = new CWindowConstraintsComponent();
		_constraints.priority = CWindowComponentPriority.CONSTRAINTS;
		addComponent(_constraints);
		
		_mover = newMover();
		_mover.priority = CWindowComponentPriority.MOVER;
		addComponent(_mover);
	}
	
	function addComponent(component:ACWindowComponent)
	{
		if (!_components.exists(component))
		{
			_components.add(component);
			component.subscribe(this, getManager, get_dock, _baseSkin);
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
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	public function close(fast:Bool = false):Void
	{
		if (manager != null)
		{
			manager.remove(this, fast);
		}
	}
}