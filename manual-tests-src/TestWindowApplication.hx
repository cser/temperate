package ;
import flash.display.Sprite;
import flash.geom.Point;
import temperate.debug.FPSMonitor;
import temperate.minimal.windows.MAlert;
import temperate.minimal.windows.MWindowedContainer;
import temperate.minimal.windows.MWindowManager;
import temperate.windows.events.CWindowEvent;
import windowApplication.CImageManager;
import windowApplication.ColorsWindow;
import windowApplication.EditorState;
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
import windowApplication.Storage;
import windowApplication.ToolsWindow;

class TestWindowApplication extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _imageManager:CImageManager;
	var _editorState:EditorState;
	var _storage:Storage;
	
	public function init()
	{
		_editorState = new EditorState();
		
		_imageManager = new CImageManager(this, _editorState);
		_imageManager.onImageSelect = onImageSelect;
		
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
		
		_editorState.toolChanged.add(onToolChanged);
		onToolChanged();
		
		_storage = new Storage();
	}
	
	var _toolsWindow:ToolsWindow;
	
	function onImageSelect()
	{
		var tool = _editorState.tool;
		_editorState.tool = null;
		_editorState.tool = tool;
		updateSaveEnabled();
	}
	
	function onToolChanged()
	{
		var state = _editorState.tool;
		if (state != null)
		{
			var window = _imageManager.current;
			if (window != null)
			{
				state.setImage(window.image, window.primitives);
			}
			else
			{
				state.setImage(null, null);
			}
		}
	}
	
	function updateSaveEnabled()
	{
		_toolsWindow.saveButton.isEnabled = _imageManager.current != null;
	}
	
	var _colorsWindow:ColorsWindow;
	
	public function doShowColors()
	{
		if (_colorsWindow == null)
		{
			_colorsWindow = new ColorsWindow(_editorState);
			_colorsWindow.dock.move(
				_colorsWindow.width, _colorsWindow.height,
				stage.stageWidth,
				stage.stageHeight,
				stage.stageWidth - _colorsWindow.width - 10,
				stage.stageHeight - _colorsWindow.height - 10,
				true
			);
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
		var window = new OpenWindow(_storage.names);
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
			if (_storage.exists(name))
			{
				event.preventDefault();
				MAlert.show(true, "File with name \"" + name + "\" already exists");
				return;
			}
			var imageData = {
				width: Std.int(window.image.width),
				height: Std.int(window.image.height),
				primitives: window.primitives
			}
			_storage.save(name, imageData);
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
						var imageData = _storage.getImageData(name);
						window = _imageManager.addNew(imageData.width, imageData.height, name);
						window.drawPrimitives(imageData.primitives);
						var tool = _editorState.tool;
						_editorState.tool = null;
						_editorState.tool = tool;
					}
					else
					{
						_imageManager.moveToTop(window);
					}
				case OpenWindowData.REMOVE(name):
					_storage.remove(name);
			}
		}
	}
	
	var _fpsMonitor:MWindowedContainer<Dynamic>;
	
	public function doShowFps()
	{
		if (_fpsMonitor == null)
		{
			_fpsMonitor = new MWindowedContainer(new FPSMonitor());
			_fpsMonitor.setSize(150, 100);
		}
		if (_fpsMonitor.isOpened)
		{
			_fpsMonitor.close(null);
		}
		else
		{
			MWindowManager.add(_fpsMonitor, false);
		}
	}
}