package ;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import temperate.core.CSprite;
import temperate.debug.FPSMonitor;
import temperate.minimal.MWindowManager;
import temperate.windows.CWindowManager;
import temperate.windows.docks.CWindowAbsoluteDock;
import windowApplication.ColorsWindow;
import windowApplication.ImageWindow;
import windowApplication.NewWindow;
import windowApplication.OpenWindow;
import windowApplication.SaveWindow;
import windowApplication.states.ADrawState;
import windowApplication.ToolsWindow;

class TestWindowApplication extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _imageManager:CWindowManager;
	
	public function init()
	{
		_imageManager = new CWindowManager(this);
		_imageManager.addEventListener(Event.SELECT, onImageSelect);
		stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize();
		
		var toolsWindow = new ToolsWindow(this);
		MWindowManager.add(toolsWindow, false, true);
		toolsWindow.move(Std.int(stage.stageWidth) - toolsWindow.width - 10, 50);
	}
	
	function onImageSelect(event:Event)
	{
		_state.setImage(getCurrentImage());
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
		window.signalOk.add(onNewWindowOk);
		MWindowManager.add(window, true);
	}
	
	function onNewWindowOk(width:Int, height:Int)
	{
		var window = new ImageWindow("No name");
		window.setSize(640, 480);
		window.setImageSize(width, height);
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