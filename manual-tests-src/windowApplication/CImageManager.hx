package windowApplication;
import flash.display.DisplayObjectContainer;
import flash.errors.Error;
import flash.events.Event;
import temperate.cursors.CHoverSwitcher;
import temperate.cursors.ICCursor;
import temperate.minimal.MCursorManager;
import temperate.windows.CWindowManager;
import temperate.windows.docks.CWindowAbsoluteDock;

class CImageManager
{
	public function new(container:DisplayObjectContainer) 
	{
		_container = container;
		_manager = new CWindowManager(container);
		_manager.addEventListener(Event.SELECT, onManagerImageSelect);
		_container.stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize();
		toolCursor = MCursorManager.newHover(-1);
	}
	
	public var onImageSelect:Void->Void;
	public var toolCursor(default, null):CHoverSwitcher<ICCursor>;
	
	var _manager:CWindowManager;
	var _container:DisplayObjectContainer;
	
	function onManagerImageSelect(event:Event)
	{
		onImageSelect();
	}
	
	function onStageResize(event:Event = null)
	{
		_manager.setArea(0, 0, _container.stage.stageWidth, _container.stage.stageHeight);
	}
	
	public var current(get_current, null):ImageWindow;
	function get_current()
	{
		return cast(_manager.topWindow, ImageWindow);
	}
	
	public function getByName(name:String)
	{
		for (window in _manager)
		{
			var imageWindow = cast(window, ImageWindow);
			if (imageWindow.title == name)
			{
				return imageWindow;
			}
		}
		return null;
	}
	
	public function addNew(width:Int, height:Int, name:String)
	{
		if (getByName(name) != null)
		{
			throw new Error("Window already exists");
		}
		var window = new ImageWindow(name);
		window.setSize(640, 480);
		window.setImageSize(width, height);
		window.dock = new CWindowAbsoluteDock(10, 10);
		var top = _manager.topWindow;
		_manager.add(window, false);
		if (top != null)
		{
			window.move(top.view.x + 20, top.view.y + 20);
		}
		return window;
	}
	
	public function moveToTop(window:ImageWindow)
	{
		_manager.moveToTop(window);
	}
}