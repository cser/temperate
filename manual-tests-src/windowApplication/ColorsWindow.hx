package windowApplication;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
import temperate.minimal.windows.AMWindow;

class ColorsWindow extends AMWindow<Dynamic>
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
		close(null);
	}
	
	function onKeyDown(event:KeyboardEvent)
	{
		if (event.keyCode == Keyboard.ESCAPE)
		{
			close(null);
		}
	}
}