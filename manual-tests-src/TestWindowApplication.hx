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
		
		stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize();
		
		var window = new ToolsWindow();
		_windowManager.add(window, true);
	}
	
	function onStageResize(event:Event = null)
	{
		_windowManager.setBounds(10, stage.stageWidth - 10, 10, stage.stageHeight - 10);
	}
}