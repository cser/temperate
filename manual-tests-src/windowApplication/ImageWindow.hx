package windowApplication;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.minimal.MWindow;

class ImageWindow extends MWindow
{
	public function new() 
	{
		super();
		
		title = "No name";
		
		_skin.addHeadButton(_skin.maximizeButton).addEventListener(Event.CHANGE, onMaximizeChange);
		_skin.addHeadButton(_skin.closeButton).addEventListener(MouseEvent.CLICK, onCloseClick);
		moveToTopOnMouseDown = false;
		resizable = true;
	}
	
	function onMaximizeChange(event:Event)
	{
		maximized = _skin.maximizeButton.selected;
	}
	
	function onCloseClick(event:MouseEvent)
	{
		close();
	}
}