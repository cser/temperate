package temperate.cursors;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import flash.ui.Mouse;
import temperate.cursors.ICCursor;
import temperate.minimal.graphics.MCommonBdFactory;

class CRasterPressCursor implements ICCursor
{
	public function new() 
	{
		_bitmap = new Bitmap();
		view = _bitmap;
	}
	
	var _hideSystem:Bool;
	var _system:CMouseCursor;
	
	var _up:BitmapData;
	var _down:BitmapData;
	var _bitmap:Bitmap;
	
	//----------------------------------------------------------------------------------------------
	//
	//  Initialization
	//
	//----------------------------------------------------------------------------------------------
	
	/**
	 * For once call only. It's just for minimize params in constructor
	 * @param	viewUpdateOnMove - is event.updateAfterEvent() calling on moving needed
	 */
	public function setView(
		up:BitmapData, down:BitmapData, updateOnMove:Bool = false,
		viewOffsetX:Int = 0, viewOffsetY:Int = 0)
	{
		_up = up;
		_down = down;
		this.updateOnMove = updateOnMove;
		this.viewOffsetX = viewOffsetX;
		this.viewOffsetY = viewOffsetY;
		return this;
	}
	
	/**
	 * For once call only
	 */
	public function setHideSystem(hideSystem:Bool)
	{
		_hideSystem = hideSystem;
		return this;
	}
	
	/**
	 * For once call only
	 */
	public function setSystem(system:CMouseCursor)
	{
		_system = system;
		return this;
	}
	
	@:require(flash10_2) public function setNative(name:String)
	{
		_system = cast name;
		return this;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  ICursor
	//
	//----------------------------------------------------------------------------------------------
	
	public var view(default, null):DisplayObject;
	
	public var updateOnMove(default, null):Bool;
	
	public var viewOffsetX(default, null):Int;
	
	public var viewOffsetY(default, null):Int;
	
	public function subscribe(mouseEventSource:IEventDispatcher = null)
	{
		if (_hideSystem)
		{
			Mouse.hide();
		}
		#if flash_10
		if (_system != null)
		{
			Mouse.cursor = _system;
		}
		#end
		_bitmap.bitmapData = _up;
		mouseEventSource.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		mouseEventSource.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	public function unsubscribe(mouseEventSource:IEventDispatcher = null)
	{
		if (_hideSystem)
		{
			Mouse.show();
		}
		#if flash_10
		if (_system != null)
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		#end
		mouseEventSource.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		mouseEventSource.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	function onMouseDown(event:MouseEvent)
	{
		_bitmap.bitmapData = _down;
	}
	
	function onMouseUp(event:MouseEvent)
	{
		_bitmap.bitmapData = _up;
	}
}