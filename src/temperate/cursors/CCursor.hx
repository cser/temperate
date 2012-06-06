package temperate.cursors;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.IEventDispatcher;
import flash.geom.Matrix;
import flash.Lib;
import flash.ui.Mouse;
import flash.display.Shape;
import flash.display.BitmapData;
import temperate.core.CMath;

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
		// Mouse transparent for nme hack
		if (Std.is(view, Bitmap))
		{
			var bd = cast(view, Bitmap).bitmapData;
			var proxy = new Sprite();
			var g = proxy.graphics;
			g.clear();
			g.beginBitmapFill(bd);
			g.drawRect(0, 0, bd.width, bd.height);
			g.endFill();
			view = proxy;
		}
		else if (Std.is(view, Shape))
		{
			// Are getBounds() works in nme? Another hack
			var w = CMath.intMax(1, Std.int(view.width));
			var h = CMath.intMax(1, Std.int(view.height));
			var bd = new BitmapData(w << 1, h << 1, true, 0x00000000);
			bd.draw(view, new Matrix(1, 0, 0, 1, w, h));
			var proxy = new Sprite();
			var g = proxy.graphics;
			g.clear();
			g.beginBitmapFill(bd, new Matrix(1, 0, 0, 1, -w, -h));
			g.drawRect(-w, -h, w << 1, h << 1);
			g.endFill();
			view = proxy;
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