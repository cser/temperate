package temperate.windows;
import flash.display.DisplayObjectContainer;
import temperate.windows.CPopUpManager;

class TestPopUpManager extends CPopUpManager
{
	public function new(container:DisplayObjectContainer) 
	{
		super(container);
	}
	
	public function getPopUps()
	{
		return _popUps;
	}
}