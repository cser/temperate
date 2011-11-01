package temperate.windows;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

class CWindowManager implements ICWindowOwner
{	
	public function new(container:DisplayObjectContainer) 
	{
		_container = container;
		_windows = [];
	}
	
	public var container(get_container, null):DisplayObjectContainer;
	var _container:DisplayObjectContainer;
	function get_container()
	{
		return _container;
	}
	
	public var left(default, null):Int;
	
	public var top(default, null):Int;
	
	public var right(default, null):Int;
	
	public var bottom(default, null):Int;
	
	public function setBounds(left:Int, right:Int, top:Int, bottom:Int)
	{
		this.left = left;
		this.right = right;
		this.top = top;
		this.bottom = bottom;
		
		for (window in _windows)
		{
			fixWindowPosition(window);
		}
	}
	
	var _windows:Array<ICWindow>;
	
	function fixWindowPosition(window:ICWindow)
	{
		var view = window.view;
		if (view.x < left)
		{
			view.x = left;
		}
		else if (view.x > right - view.width)
		{
			view.x = right - view.width;
		}
		if (view.y < top)
		{
			view.y = top;
		}
		else if (view.y > bottom - view.height)
		{
			view.y = bottom - view.height;
		}
	}
	
	public function add(window:ICWindow, modal:Bool)
	{
		container.addChild(window.view);
		window.subscribe(this);
		_windows.push(window);
		fixWindowPosition(window);
	}
	
	public function remove(window:ICWindow)
	{
		window.unsubscribe(this);
		container.removeChild(window.view);
		_windows.remove(window);
	}
	
	var _currentDragged:ICWindow;
	var _dragOffsetX:Float;
	var _dragOffsetY:Float;
	var _dragUpdateOnMove:Bool;
	
	public function windowStartDrag(window:ICWindow, updateOnMove:Bool):Void
	{
		if (_currentDragged != null)
		{
			windowStopDrag();
		}
		_dragOffsetX = window.view.mouseX;
		_dragOffsetY = window.view.mouseY;
		_currentDragged = window;
		_dragUpdateOnMove = updateOnMove;
		container.stage.addEventListener(MouseEvent.MOUSE_MOVE, onDragMouseMove);
		container.stage.addEventListener(MouseEvent.MOUSE_UP, onDragMouseUp);
	}
	
	function windowStopDrag()
	{
		container.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragMouseMove);
		container.stage.removeEventListener(MouseEvent.MOUSE_UP, onDragMouseUp);
		_currentDragged = null;
	}
	
	function onDragMouseUp(event:MouseEvent)
	{
		windowStopDrag();
	}
	
	function onDragMouseMove(event:MouseEvent)
	{
		var view = _currentDragged.view;
		view.x = Std.int(container.mouseX - _dragOffsetX);
		view.y = Std.int(container.mouseY - _dragOffsetY);
		fixWindowPosition(_currentDragged);
		if (_dragUpdateOnMove)
		{
			event.updateAfterEvent();
		}
	}
}