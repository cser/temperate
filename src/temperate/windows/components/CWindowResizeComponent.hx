package temperate.windows.components;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import temperate.collections.ICValueSwitcher;

class CWindowResizeComponent extends ACWindowComponent
{
	public function new(isInMarker:Void->Bool, cursor:ICValueSwitcher<Dynamic>) 
	{
		super();
		
		_isInMarker = isInMarker;
		_cursor = cursor;
		_cursorShow = false;
	}
	
	var _isInMarker:Void->Bool;
	var _cursor:ICValueSwitcher<Dynamic>;
	
	override function doSubscribe()
	{
		_view.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		subscribeCursorListeners();
	}
	
	override function doUnsubscribe()
	{
		_view.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		unsubscribeCursorListeners();
	}
	
	function subscribeCursorListeners()
	{
		_view.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_view.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
	}
	
	function unsubscribeCursorListeners()
	{
		_view.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_view.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
	}
	
	function onMouseMove(event:MouseEvent)
	{
		setCursorShow(_isInMarker());
	}
	
	function onRollOut(event:MouseEvent)
	{
		setCursorShow(false);
	}
	
	var _cursorShow:Bool;
	
	function setCursorShow(value:Bool)
	{
		if (_cursorShow != value)
		{
			_cursorShow = value;
			if (_cursor != null)
			{
				if (_cursorShow)
				{
					_cursor.on();
				}
				else
				{
					_cursor.off();
				}
			}
		}
	}
	
	var _mouseX:Int;
	var _mouseY:Int;
	var _oldWidth:Int;
	var _oldHeight:Int;
	var _stage:IEventDispatcher;
	
	function onMouseDown(event:MouseEvent)
	{
		if (_isInMarker())
		{
			var view = _view;
			_mouseX = Std.int(view.mouseX);
			_mouseY = Std.int(view.mouseY);
			_oldWidth = super.getWidth();
			_oldHeight = super.getHeight();
			_stage = view.stage;
			
			unsubscribeCursorListeners();
			setCursorShow(true);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onResizeMouseMove);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onResizeMouseUp);
		}
	}
	
	function onResizeMouseMove(event:MouseEvent)
	{
		var dx = Std.int(_view.mouseX) - _mouseX;
		var dy = Std.int(_view.mouseY) - _mouseY;
		super.setSize(_oldWidth + dx, _oldHeight + dy);
		var manager = _getManager();
		super.moveDock(
			getWidth(), getHeight(), manager.areaWidth, manager.areaHeight, getX(), getY(), true
		);
	}
	
	function onResizeMouseUp(event:MouseEvent)
	{
		_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onResizeMouseMove);
		_stage.removeEventListener(MouseEvent.MOUSE_UP, onResizeMouseUp);
		_stage = null;
		
		subscribeCursorListeners();
		setCursorShow(_isInMarker());
	}
}