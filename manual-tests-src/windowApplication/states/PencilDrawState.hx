package windowApplication.states;
import flash.events.MouseEvent;

class PencilDrawState extends ADrawState
{
	public function new() 
	{
		super();
	}
	
	override function subscribe()
	{
		_image.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	override function unsubscribe()
	{
		_image.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	function onMouseDown(event:MouseEvent)
	{
		_image.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_image.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		var g = _image.graphics;
		g.lineStyle(0x000000);
		g.moveTo(_image.mouseX, _image.mouseY);
	}
	
	function onMouseMove(event:MouseEvent)
	{
		var g = _image.graphics;
		g.lineTo(_image.mouseX, _image.mouseY);
	}
	
	function onMouseUp(event:MouseEvent)
	{
		_image.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_image.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
}