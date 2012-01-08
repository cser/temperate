package temperate.cursors;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.events.IEventDispatcher;
import flash.Lib;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import flash.ui.MouseCursorData;

class CCursor implements ICCursor
{
	public function new() 
	{		
		viewOffsetX = 0;
		viewOffsetY = 0;
		
		_hideSystem = false;
		_system = null;
	}
	
	private var _hideSystem:Bool;
	private var _system:String;
	
	//----------------------------------------------------------------------------------------------
	//
	//  Initialization
	//
	//----------------------------------------------------------------------------------------------
	
	/**
	 * For once call only. It's just for minimize params in constructor
	 * @param	view
	 * @param	viewUpdateOnMove - is event.updateAfterEvent() calling on moving needed
	 */
	public function setView(
		view:DisplayObject, updateOnMove:Bool = false, viewOffsetX:Int = 0, viewOffsetY:Int = 0)
	{
		this.view = view;
		var interactiveObject = Lib.as(view, InteractiveObject);
		if (interactiveObject != null)
		{
			interactiveObject.mouseEnabled = false;
		}
		var container = Lib.as(view, DisplayObjectContainer);
		if (container != null)
		{
			container.mouseChildren = false;
		}
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
	public function setSystem(mouseCursor:String)
	{
		_system = mouseCursor;
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
		#if flash10
		if (_system != null)
		{
			Mouse.cursor = _system;
		}
		#end
	}
	
	public function unsubscribe(mouseEventSource:IEventDispatcher = null)
	{
		if (_hideSystem)
		{
			Mouse.show();
		}
		#if flash10
		if (_system != null)
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		#end
	}
}