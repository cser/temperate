package ;
import flash.display.Sprite;
import flash.events.Event;
import temperate.windows.CPopUpManager;
import windowApplication.ToolsWindow;

class TestWindowApplication extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _windowManager:CPopUpManager;
	
	public function init()
	{
		_windowManager = new CPopUpManager(this);
		_windowManager.updateOnMove = true;
		
		stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize();
		
		new ToolsWindow(_windowManager).open(false);
	}
	
	function onStageResize(event:Event = null)
	{
		_windowManager.setArea(10, 10, stage.stageWidth - 20, stage.stageHeight - 20);
		var g = graphics;
		g.clear();
		g.lineStyle(0, 0x808080);
		g.drawRect(
			_windowManager.areaX, _windowManager.areaY,
			_windowManager.areaWidth, _windowManager.areaHeight);
	}
}