package windowApplication;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
import temperate.minimal.MWindow;

class ColorsWindow extends MWindow
{
	public function new() 
	{
		super();
		title = "Colors";
		
		_skin.addHeadButton(_skin.closeButton).addEventListener(MouseEvent.CLICK, onCloseClick);
		innerDispatcher.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	function onCloseClick(event:MouseEvent)
	{
		close();
	}
	
	function onKeyDown(event:KeyboardEvent)
	{
		if (event.keyCode == Keyboard.ESCAPE)
		{
			close();
		}
	}
}