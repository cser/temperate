package ;
import flash.display.Sprite;
import flash.events.Event;
import temperate.core.ICArea;
import temperate.minimal.MPopUpManager;
import temperate.minimal.windows.MLockArea;
import temperate.windows.CPopUpManager;
import windowApplication.ToolsWindow;

class TestWindowApplication extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		MPopUpManager.instance.add(new ToolsWindow(), false, true);
	}
}
/*
Починить падение при повторном клике на кнопке закрыть
*/