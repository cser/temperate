package windowApplication;
import flash.display.DisplayObjectContainer;
import flash.errors.Error;
import flash.events.Event;
import flash.events.EventDispatcher;
import temperate.cursors.CHoverSwitcher;
import temperate.cursors.ICCursor;
import temperate.minimal.MCursorManager;
import temperate.windows.CWindowManager;
import temperate.windows.docks.CWindowAbsoluteDock;
import temperate.windows.events.CWindowEvent;
import windowApplication.events.ImageWindowEvent;

class CImageManager extends EventDispatcher
{
	public function new(container:DisplayObjectContainer, editorState:EditorState) 
	{
		super();
		_container = container;
		_editorState = editorState;
		_manager = new CWindowManager(container);
		_manager.addEventListener(Event.SELECT, onManagerImageSelect);
		_container.stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize();
	}
	
	public var onImageSelect:Void->Void;
	
	var _manager:CWindowManager;
	var _container:DisplayObjectContainer;
	var _editorState:EditorState;
	
	function onManagerImageSelect(event:Event)
	{
		onImageSelect();
	}
	
	function onStageResize(event:Event = null)
	{
		_manager.setArea(0, 0, _container.stage.stageWidth, _container.stage.stageHeight);
	}
	
	public var current(get_current, null):ImageWindow;
	function get_current():ImageWindow
	{
		return cast _manager.topWindow;
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
		var window = new ImageWindow(name, _editorState);
		window.setSize(640, 480);
		window.setImageSize(width, height);
		window.dock = new CWindowAbsoluteDock(10, 10);
		window.addTypedListener(CWindowEvent.CLOSE, onImageWindowClose);
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
	
	function onImageWindowClose(event:CWindowEvent<Dynamic>):Void
	{
		var dispatchedEvent = new ImageWindowEvent(
			ImageWindowEvent.CLOSE, cast event.window, event.continueWindowPrevented);
		dispatchEvent(dispatchedEvent);
		if (dispatchedEvent.isWindowPrevented())
		{
			event.windowPrevent();
		}
	}
}