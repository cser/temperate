package temperate.windows;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

class CPopUpManager
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
	
	var _windows:Array<ICPopUp>;
	
	function fixWindowPosition(window:ICPopUp)
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
	
	public function add(window:ICPopUp, modal:Bool)
	{
		container.addChild(window.view);
		_windows.push(window);
		fixWindowPosition(window);
	}
	
	public function remove(window:ICPopUp)
	{
		container.removeChild(window.view);
		_windows.remove(window);
	}
}