package ;
import flash.display.Sprite;
import flash.events.Event;
import temperate.debug.FPSMonitor;
import temperate.minimal.MPopUpManager;
import temperate.windows.CPopUpManager;
import temperate.windows.docks.CPopUpAbsoluteDock;
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
	
	var _imageManager:CPopUpManager;
	
	public function init()
	{
		var toolsWindow = new ToolsWindow(this);
		toolsWindow.dock = new CPopUpAbsoluteDock(10, 50);
		MPopUpManager.add(toolsWindow, false, true);
		_imageManager = new CPopUpManager(this);
		stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize();
	}
	
	var _state:ADrawState;
	
	public function setState(state:ADrawState)
	{
		_state = state;
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
			MPopUpManager.add(_colorsWindow, false);
		}
	}
	
	public function doNew()
	{
		var window = new NewWindow();
		window.signalOk.add(onNewWindowOk);
		MPopUpManager.add(window, true);
	}
	
	function onNewWindowOk(width:Int, height:Int)
	{
		var window = new ImageWindow("No name");
		window.setSize(640, 480);
		window.setImageSize(width, height);
		_imageManager.add(window, false);
	}
	
	public function doOpen()
	{
		var window = new OpenWindow();
		window.setSize(200, 150);
		MPopUpManager.add(window, true);
	}
	
	public function doSave()
	{
		var window = new SaveWindow();
		MPopUpManager.add(window, true);
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