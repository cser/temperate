package ;
import flash.display.Sprite;
import flash.events.Event;

class TestFrameEvent extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		addEventListener(Event.ENTER_FRAME, onEvent);
		addEventListener(Event.EXIT_FRAME, onEvent);
		stage.addEventListener(Event.RENDER, onEvent);
		stage.invalidate();
	}
	
	function onEvent(event:Event)
	{
		stage.invalidate();
		trace(event.type);
	}
}