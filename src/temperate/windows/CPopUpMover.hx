package temperate.windows;
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import temperate.windows.docks.ICPopUpDock;

class CPopUpMover 
{
	public function new() 
	{
	}
	
	var _popUp:ICPopUp;
	var _target:DisplayObject;
	var _getManager:Void->CPopUpManager;
	var _getDock:Void->ICPopUpDock;
	var _fixPosition:Void->Void;
	
	public function subscribe(
		getManager:Void->CPopUpManager, popUp:ICPopUp, target:DisplayObject, 
		getDock:Void->ICPopUpDock, fixPosition:Void->Void
	)
	{
		_getManager = getManager;
		_popUp = popUp;
		_target = target;
		_getDock = getDock;
		_fixPosition = fixPosition;
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
		var parent = _popUp.view.parent;
		var x = Std.int(parent.mouseX) - _mouseX;
		var y = Std.int(parent.mouseY) - _mouseY;
		move(x, y);
		var manager = _getManager();
		if (manager.updateOnMove)
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
	
	public function move(x:Int, y:Int)
	{
		var view = _popUp.view;
		view.x = x;
		view.y = y;
		_fixPosition();
		var dock = _getDock();
		var manager = _getManager();
		dock.move(
			Std.int(view.width), Std.int(view.height), manager.areaWidth, manager.areaHeight,
			x - manager.areaX, y - manager.areaY
		);
	}
}