package ;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.Lib;
import temperate.core.CSprite;
import temperate.cursors.CCursor;
import temperate.cursors.CHoverSwitcher;
import temperate.cursors.ICCursor;
import temperate.debug.FPSMonitor;
import temperate.minimal.MCursorManager;
import temperate.minimal.MWindowManager;
import temperate.windows.CWindowManager;
import temperate.windows.docks.CWindowAbsoluteDock;
import temperate.windows.events.CWindowEvent;
import windowApplication.ColorsWindow;
import windowApplication.ImageWindow;
import windowApplication.NewWindow;
import windowApplication.OpenWindow;
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
	
	var _imageManager:CWindowManager;
	var _toolCursor:CHoverSwitcher<ICCursor>;
	
	public function init()
	{
		_imageManager = new CWindowManager(this);
		_imageManager.addEventListener(Event.SELECT, onImageSelect);
		stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize();
		
		_toolCursor = MCursorManager.newHover(-1);
		
		var pencilState = new PencilDrawState();
		var states:Array<ADrawState> = [];
		states.push(new TextDrawState());
		states.push(new EllipseDrawState());
		states.push(new LineDrawState());
		states.push(new FigureDrawState());
		states.push(pencilState);
		states.push(new RectDrawState());
		var toolsWindow = new ToolsWindow(this, states, pencilState);
		MWindowManager.add(toolsWindow, false, true);
		toolsWindow.move(Std.int(stage.stageWidth) - toolsWindow.width - 10, 50);
	}
	
	function onImageSelect(event:Event)
	{
		var image = getCurrentImage();
		_state.setImage(image);
		_toolCursor.setTarget(image);
	}
	
	var _state:ADrawState;
	
	public function setState(state:ADrawState)
	{
		if (_state != state)
		{
			if (_state != null)
			{
				_state.setImage(null);
			}
			_state = state;
			if (_state != null)
			{
				_state.setImage(getCurrentImage());
				_toolCursor.value = new CCursor()
					.setView(new Bitmap(Type.createInstance(_state.icon, [])), true, 10, 14);
			}
			else
			{
				_toolCursor.value = null;
			}
		}
	}
	
	function getCurrentImage():CSprite
	{
		if (_imageManager == null)
		{
			return null;
		}
		var window = Lib.as(_imageManager.topWindow, ImageWindow);
		return window != null ? window.image : null;
	}
	
	function onStageResize(event:Event = null)
	{
		_imageManager.setArea(0, 0, stage.stageWidth, stage.stageHeight);
	}
	
	var _colorsWindow:ColorsWindow;
	
	public function doShowColors()
	{
		if (_colorsWindow == null)
		{
			_colorsWindow = new ColorsWindow();
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
		if (data == null)
		{
			return;
		}
		
		var window = new ImageWindow("No name");
		window.setSize(640, 480);
		window.setImageSize(Std.int(data.x), Std.int(data.y));
		window.dock = new CWindowAbsoluteDock(10, 10);
		var top = _imageManager.topWindow;
		_imageManager.add(window, false);
		if (top != null)
		{
			window.move(top.view.x + 20, top.view.y + 20);
		}
	}
	
	public function doOpen()
	{
		var window = new OpenWindow();
		window.setSize(200, 150);
		MWindowManager.add(window, true);
	}
	
	public function doSave()
	{
		var window = new SaveWindow();
		MWindowManager.add(window, true);
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