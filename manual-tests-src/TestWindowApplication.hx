package ;
import flash.display.Sprite;
import flash.events.Event;
import temperate.core.ICArea;
import temperate.minimal.windows.MPopUpScaleAnimator;
import temperate.minimal.windows.MLockArea;
import temperate.windows.CPopUpManager;
import windowApplication.ToolsWindow;

class TestWindowApplication extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _windowManager:CPopUpManager;
	var _lockArea:MLockArea;
	
	public function init()
	{
		_windowManager = new CPopUpManager(this);
		_windowManager.updateOnMove = true;
		
		_lockArea = new MLockArea().setManager(_windowManager);
		addChild(_lockArea.container);
		
		stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize();
		
		new ToolsWindow(_windowManager).open(false);
	}
	
	function onStageResize(event:Event = null)
	{
		var areas:Array<ICArea> = [];
		areas.push(_windowManager);
		areas.push(_lockArea);
		for (area in areas)
		{
			area.setArea(10, 10, stage.stageWidth - 20, stage.stageHeight - 20);
		}
		var g = graphics;
		g.clear();
		g.lineStyle(0, 0x808080);
		g.drawRect(
			_windowManager.areaX, _windowManager.areaY,
			_windowManager.areaWidth, _windowManager.areaHeight);
	}
}