package windows;
import flash.events.MouseEvent;
import temperate.minimal.windows.AMWindow;

class MMaximizedWindow extends AMWindow<Dynamic>
{
	public function new() 
	{
		super();
		
		_baseSkin.title = "Maximized window";
		_skin.addHeadButton(_skin.getMaximizeButton())
			.addEventListener(MouseEvent.CLICK, onMaximizeClick);
		_skin.addHeadButton(_skin.getCloseButton())
			.addEventListener(MouseEvent.CLICK, onCloseClick);
	}
	
	function onCloseClick(event:MouseEvent)
	{
		manager.remove(this);
	}
	
	function onMaximizeClick(event:MouseEvent)
	{
		maximized = _skin.getMaximizeButton().selected;
	}
}