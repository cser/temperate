package windowApplication;
import flash.display.Sprite;
import flash.events.MouseEvent;
import temperate.containers.CVBox;
import temperate.minimal.MWindow;
import temperate.minimal.skins.MWindowSkin;
import temperate.windows.skins.ICWindowSkin;
import temperate.windows.ACWindow;
import temperate.windows.CPopUpManager;

class ColorsWindow extends MWindow
{
	public function new() 
	{
		super();
		title = "Colors";
		
		_skin.addHeadButton(_skin.closeButton).addEventListener(MouseEvent.CLICK, onCloseClick);
	}
	
	function onCloseClick(event:MouseEvent)
	{
		manager.remove(this);
	}
}