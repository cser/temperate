package temperate.cursors;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import flash.ui.Mouse;
import flash.ui.MouseCursorData;
import temperate.collections.CLinkedStack;
import temperate.collections.ICValueSwitcher;
import temperate.core.CMath;

class CCursorManager 
{	
	public function new(owner:DisplayObjectContainer, mouseEventSource:IEventDispatcher = null) 
	{
		_owner = owner;
		_mouseEventSource = mouseEventSource;
		
		_stack = new CLinkedStack(onCursorChange);
		_defaultSwitcher = _stack.newSwitcher(CMath.INT_MIN_VALUE);
		_defaultSwitcher.on();
	}
	
	var _owner:DisplayObjectContainer;
	var _mouseEventSource:IEventDispatcher;
	var _stack:CLinkedStack<ICCursor>;
	
	function onCursorChange()
	{
		setCursor(_stack.value);
	}
	
	/**
	 * Addition native flashplayer 10.2 cursor.
	 * Fixed for native cursor class for haXe 2.07 - incorrect way to MouseCursorData!
	 */
	@:require(flash10_2) public function addNative(
		name:String, data:flash.Vector<flash.display.BitmapData>, frameRate:Float,
		hotSpot:flash.geom.Point)
	{
		var cursor = new MouseCursorData();
		cursor.data = data;
		cursor.frameRate = frameRate;
		cursor.hotSpot = hotSpot;
		Mouse.registerCursor(name, cursor);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Factories
	//
	//----------------------------------------------------------------------------------------------
	
	var _defaultSwitcher:ICValueSwitcher<ICCursor>;
	
	/**
	 * Not very useful, just access to one first switcher with 0 priority
	 */
	public var defaultCursor(get_defaultCursor, set_defaultCursor):ICCursor;
	function get_defaultCursor()
	{
		return _defaultSwitcher.value;
	}
	function set_defaultCursor(value)
	{
		_defaultSwitcher.value = value;
		return value;
	}
	
	public function newSwitcher(priority:Int = 0):ICValueSwitcher<ICCursor>
	{
		return _stack.newSwitcher(priority);
	}
	
	public function newHover(priority:Int = 0):CHoverSwitcher<ICCursor>
	{
		return new CHoverSwitcher(_stack, priority);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Cursor application
	//
	//----------------------------------------------------------------------------------------------
	
	var _cursor:ICCursor;
	
	function setCursor(cursor:ICCursor)
	{
		if (_cursor != cursor)
		{
			if (_cursor != null)
			{
				_cursor.unsubscribe(_mouseEventSource);
				if (_cursor.view != null)
				{
					_owner.removeChild(_cursor.view);
					_owner.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
				if (_mouseEventSource != null)
				{
					_mouseEventSource.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				}
			}
			_cursor = cursor;
			if (_cursor != null)
			{
				_cursor.subscribe(_mouseEventSource);
				if (_cursor.view != null)
				{
					_owner.addChild(_cursor.view);
					_owner.addEventListener(Event.ENTER_FRAME, onEnterFrame);
					if (_mouseEventSource != null && _cursor.updateOnMove)
					{
						_mouseEventSource.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
					}
					updateViewPosition();
				}
			}
		}
	}
	
	function onEnterFrame(event:Event)
	{
		updateViewPosition();
	}
	
	function onMouseMove(event:MouseEvent)
	{
		if (_cursor != null && _owner != null)
		{
			updateViewPosition();
			event.updateAfterEvent();
		}
	}
	
	function updateViewPosition()
	{
		var view = _cursor.view;
		view.x = _owner.mouseX + _cursor.viewOffsetX;
		view.y = _owner.mouseY + _cursor.viewOffsetY;
		
		var maxIndex = _owner.numChildren - 1;
		if (_owner.getChildIndex(view) < maxIndex)
		{
			_owner.setChildIndex(view, maxIndex);
		}
	}
}