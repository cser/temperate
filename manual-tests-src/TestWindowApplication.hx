package ;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.Lib;
import flash.net.SharedObject;
import haxe.Serializer;
import haxe.Unserializer;
import temperate.cursors.CCursor;
import temperate.cursors.CHoverSwitcher;
import temperate.cursors.ICCursor;
import temperate.debug.FPSMonitor;
import temperate.minimal.MCursorManager;
import temperate.minimal.windows.MWindowManager;
import temperate.windows.CWindowManager;
import temperate.windows.docks.CWindowAbsoluteDock;
import temperate.windows.events.CWindowEvent;
import windowApplication.CImageManager;
import windowApplication.ColorsWindow;
import windowApplication.EditorState;
import windowApplication.ImageData;
import windowApplication.ImageWindow;
import windowApplication.NewWindow;
import windowApplication.OpenWindow;
import windowApplication.OpenWindowData;
import windowApplication.SaveWindow;
import windowApplication.states.ADrawState;
import windowApplication.states.EllipseDrawState;
import windowApplication.states.FigureDrawState;
import windowApplication.states.LineDrawState;
import windowApplication.states.PencilDrawState;
import windowApplication.states.RectDrawState;
import windowApplication.states.TextDrawState;
import windowApplication.ToolsWindow;

class TestWindowApplication extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _imageManager:CImageManager;
	var _editorState:EditorState;
	
	public function init()
	{
		_imageManager = new CImageManager(this);
		_imageManager.onImageSelect = onImageSelect;
		
		_editorState = new EditorState();
		
		var pencilState = new PencilDrawState();
		var states:Array<ADrawState> = [];
		states.push(new TextDrawState());
		states.push(new EllipseDrawState());
		states.push(new LineDrawState());
		states.push(new FigureDrawState());
		states.push(pencilState);
		states.push(new RectDrawState());
		for (state in states)
		{
			state.init(_editorState);
		}
		_toolsWindow = new ToolsWindow(this, states, pencilState, _editorState);
		MWindowManager.add(_toolsWindow, false, true);
		_toolsWindow.move(Std.int(stage.stageWidth) - _toolsWindow.width - 10, 50);
		updateSaveEnabled();
	}
	
	var _toolsWindow:ToolsWindow;
	
	function getSharedObject()
	{
		return SharedObject.getLocal("temperate_test");
	}
	
	function onImageSelect()
	{
		reinitStateByWindow();
		updateSaveEnabled();
	}
	
	function reinitStateByWindow()
	{
		var window = _imageManager.current;
		if (window != null)
		{
			_state.setImage(null, null);
			_state.setImage(window.image, window.primitives);
			_imageManager.toolCursor.setTarget(window.image);
		}
		else
		{
			_state.setImage(null, null);
			_imageManager.toolCursor.setTarget(null);
		}
	}
	
	function updateSaveEnabled()
	{
		_toolsWindow.saveButton.isEnabled = _imageManager.current != null;
	}
	
	var _state:ADrawState;
	
	public function setState(state:ADrawState)
	{
		if (_state != state)
		{
			if (_state != null)
			{
				_state.setImage(null, null);
			}
			_state = state;
			if (_state != null)
			{
				var window = _imageManager.current;
				if (window != null)
				{
					_state.setImage(window.image, window.primitives);
				}
				else
				{
					_state.setImage(null, null);
				}
				var cursorView = new Bitmap(Type.createInstance(_state.icon, []));
				var cursor = new CCursor();
				if (Std.is(_state, PencilDrawState))
				{
					cursor.setView(cursorView, true, 0, -Std.int(cursorView.height));
					cursor.setHideSystem(true);
				}
				else
				{
					cursor.setView(cursorView, true, 10, 14);
				}
				_imageManager.toolCursor.value = cursor;
			}
			else
			{
				_imageManager.toolCursor.value = null;
			}
		}
	}
	
	var _colorsWindow:ColorsWindow;
	
	public function doShowColors()
	{
		if (_colorsWindow == null)
		{
			_colorsWindow = new ColorsWindow(_editorState);
		}
		if (!_colorsWindow.isOpened)
		{
			MWindowManager.add(_colorsWindow, false);
		}
	}
	
	public function doNew()
	{
		var window = new NewWindow();
		window.addTypedListener(CWindowEvent.CLOSE, onNewWindowClose);
		MWindowManager.add(window, true);
	}
	
	function onNewWindowClose(event:CWindowEvent<Point>)
	{
		var data = event.data;
		if (data != null)
		{
			_imageManager.addNew(Std.int(data.x), Std.int(data.y), findNewName());
		}
	}
	
	function findNewName()
	{
		var name = "No name";
		var i = 1;
		while (true)
		{
			if (_imageManager.getByName(name) == null)
			{
				break;
			}
			name = "No name " + (++i);
		}
		return name;
	}
	
	public function doOpen()
	{
		var names = [];
		for (name in Reflect.fields(getSharedObject().data))
		{
			names.push(name);
		}
		var window = new OpenWindow(names);
		window.addTypedListener(CWindowEvent.CLOSE, onOpenClose);
		window.setSize(200, 150);
		MWindowManager.add(window, true);
	}
	
	public function doSave()
	{
		var name = _imageManager.current.title;
		var window = new SaveWindow(name);
		window.addTypedListener(CWindowEvent.CLOSE, onSaveClose);
		MWindowManager.add(window, true);
	}
	
	function onSaveClose(event:CWindowEvent<String>)
	{
		var name = event.data;
		if (name != null)
		{
			var window = _imageManager.current;
			var sharedObject = getSharedObject();
			var imageData:ImageData = {
				width: Std.int(window.image.width),
				height: Std.int(window.image.height),
				primitives: window.primitives
			}
			Reflect.setField(sharedObject.data, name, Serializer.run(imageData));
			sharedObject.flush();
			window.title = name;
		}
	}
	
	function onOpenClose(event:CWindowEvent<OpenWindowData>)
	{
		if (event.data != null)
		{
			switch (event.data)
			{
				case OpenWindowData.OPEN(name):
					var window = _imageManager.getByName(name);
					if (window == null)
					{
						var imageData:ImageData = Unserializer.run(
							Reflect.field(getSharedObject().data, name));
						window = _imageManager.addNew(imageData.width, imageData.height, name);
						window.drawPrimitives(imageData.primitives);
						reinitStateByWindow();
					}
					else
					{
						_imageManager.moveToTop(window);
					}
				case OpenWindowData.CLEAR_ALL:
					var data = getSharedObject().data;
					for (key in Reflect.fields(data))
					{
						Reflect.deleteField(data, key);
					}
			}
		}
	}
	
	var _fpsMonitor:FPSMonitor;
	
	public function doShowFps()
	{
		if (_fpsMonitor == null)
		{
			_fpsMonitor = new FPSMonitor();
			addChild(_fpsMonitor);
		}
		else
		{
			removeChild(_fpsMonitor);
			_fpsMonitor = null;
		}
	}
}
/*
Починить падение при повторном клике на кнопке закрыть
*/