package temperate.windows;
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;

class CPopUpMover 
{
	public function new() 
	{
		updateOnMove = false;
	}
	
	public var updateOnMove:Bool;
	
	var _popUp:ICPopUp;
	var _target:DisplayObject;
	
	public function subscribe(popUp:ICPopUp, target:DisplayObject)
	{
		_popUp = popUp;
		_target = target;
		_target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	public function unsubscribe()
	{
		_popUp = null;
		if (_target != null)
		{
			_target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_target = null;
		}
	}
	
	var _mouseX:Int;
	var _mouseY:Int;
	var _stage:IEventDispatcher;
	
	function onMouseDown(event:MouseEvent)
	{
		var view = _popUp.view;
		_mouseX = Std.int(view.mouseX);
		_mouseY = Std.int(view.mouseY);
		_stage = view.stage;
		_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	function onMouseMove(event:MouseEvent)
	{
		var view = _popUp.view;
		var parent = view.parent;
		view.x = parent.mouseX - _mouseX;
		view.y = parent.mouseY - _mouseY;
		if (updateOnMove)
		{
			event.updateAfterEvent();
		}
	}
	
	function onMouseUp(event:MouseEvent)
	{
		_stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		_stage = null;
	}
}