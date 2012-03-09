package ;
import flash.display.Sprite;
import flash.geom.Point;
import temperate.debug.FPSMonitor;
import temperate.minimal.windows.MAlert;
import temperate.minimal.windows.MButtonInfo;
import temperate.minimal.windows.MWindowedContainer;
import temperate.minimal.windows.MWindowManager;
import temperate.windows.ACWindow;
import temperate.windows.events.CWindowEvent;
import windowApplication.CImageManager;
import windowApplication.ColorsWindow;
import windowApplication.EditorState;
import windowApplication.events.ImageWindowEvent;
import windowApplication.ImageWindow;
import windowApplication.NewWindow;
import windowApplication.OpenWindow;
import windowApplication.OpenWindowData;
import windowApplication.Primitives;
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
		_imageManager.addEventListener(ImageWindowEvent.CLOSE, onImageWindowClose);
		
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
		_toolsWindow = new ToolsWindow(states, pencilState, _editorState);
		_toolsWindow.signalColorClick.add(onToolColorClick);
		_toolsWindow.signaleSaveClick.add(onToolSaveClick);
		_toolsWindow.signalFPSClick.add(onToolFPSClick);
		_toolsWindow.signalNewClick.add(onToolNewClick);
		_toolsWindow.signalOpenClick.add(onToolOpenClick);
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
	
	function onToolColorClick()
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
	
	function onToolNewClick()
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
	
	function onToolOpenClick()
	{
		var window = new OpenWindow(_storage.names);
		window.addTypedListener(CWindowEvent.CLOSE, onOpenClose);
		window.setSize(200, 150);
		MWindowManager.add(window, true);
	}
	
	function onToolSaveClick()
	{
		openSaveWindow();
	}
	
	function openSaveWindow()
	{
		var name = _imageManager.current.name;
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
			if (_storage.exists(name) && (name != window.name || !window.isImageOpened))
			{
				event.windowPrevent();
				var yesData = { window:window, name:name, parentWindow:event.window };
				MAlert.show(
					true, "File with name \"" + name + "\" already exists.\nRewrite it?",
					"Question",
					[new MButtonInfo(yesData, "Yes", true), new MButtonInfo(null, "No")])
					.addTypedListener(CWindowEvent.CLOSE, onRewriteYesNoClose);
				return;
			}
			save(window, name);
		}
	}
	
	function onRewriteYesNoClose(
		event:CWindowEvent<{window:ImageWindow, name:String, parentWindow:ACWindow<Dynamic>}>)
	{
		var data = event.data;
		if (data != null)
		{
			save(data.window, data.name);
			data.parentWindow.close(null);
		}
	}
	
	function save(window:ImageWindow, name:String)
	{
		var imageData = {
			width: Std.int(window.image.width),
			height: Std.int(window.image.height),
			primitives: window.primitives.toArray()
		}
		_storage.save(name, imageData);
		window.name = name;
		window.markAsSaved();
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
						window.drawPrimitives(Primitives.fromArray(imageData.primitives));
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
	
	function onImageWindowClose(event:ImageWindowEvent)
	{
		var window = event.window;
		trace("window.isChanged = " + window.isChanged);
		if (window.isChanged)
		{
			event.windowPrevent();
			var yesInfo = new MButtonInfo(
				{ window:window, name:name, yes:true, continuePrevented:event.continuePrevented },
				"Yes", true);
			var noInfo = new MButtonInfo(
				{ window:window, name:name, yes:false, continuePrevented:event.continuePrevented },
				"No");
			var cancelInfo = new MButtonInfo(null, "Cancel");
			MAlert.show(
				true, "File has unsaved changes.\nSave changes?", "Question",
				[yesInfo, noInfo, cancelInfo])
				.addTypedListener(CWindowEvent.CLOSE, onImageCloseYesNoCancel);
		}
	}
	
	function onImageCloseYesNoCancel(
		event:CWindowEvent < {
			window:ImageWindow, name:String, yes:Bool, continuePrevented:Void->Void } > )
	{
		var data = event.data;
		if (data != null)
		{
			var window = data.window;
			if (!data.yes)
			{
				data.continuePrevented();
			}
			else
			{
				openSaveWindow();
			}
		}
	}
	
	var _fpsMonitor:MWindowedContainer<Dynamic>;
	
	function onToolFPSClick()
	{
		var first = false;
		if (_fpsMonitor == null)
		{
			first = true;
			_fpsMonitor = new MWindowedContainer(new FPSMonitor());
			_fpsMonitor.containerWrapper.setPercents( -1, -1);
		}
		if (_fpsMonitor.isOpened)
		{
			_fpsMonitor.close(null, true);
		}
		else
		{
			MWindowManager.add(_fpsMonitor, false, true);
			if (first)
			{
				_fpsMonitor.move(0, 0);
			}
		}
	}
}