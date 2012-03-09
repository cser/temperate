package temperate.cursors;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.IEventDispatcher;
import flash.Lib;
import flash.ui.Mouse;
import flash.display.Shape;

#if !nme
import flash.ui.MouseCursor;
#end
#if flash10_2
import flash.ui.MouseCursorData;
#end

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
	private var _container:Sprite;
	private var _containerView:DisplayObject;
	
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
		// For nme
		if (Std.is(view, Bitmap) || Std.is(view, Shape))
		{
			view.x = 0;
			view.y = 0;
			_containerView = view;
			_container = new Sprite();
			_container.addChild(_containerView);
			view = _container;
		}
		else
		{
			_container = null;
			_containerView = null;
		}
		
		this.view = view;
		if (Std.is(view, InteractiveObject))
		{
			cast(view, InteractiveObject).mouseEnabled = false;
		}
		if (Std.is(view, DisplayObjectContainer))
		{
			cast(view, DisplayObjectContainer).mouseChildren = false;
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
		if (_container != null && _containerView != null && _containerView.parent != _container)
		{
			// For allow equals cursor views on nme
			_container.addChild(_containerView);
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