package temperate.windows.components;
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;
import flash.events.MouseEvent;
import temperate.windows.docks.ICPopUpDock;

class CWindowMoveComponent extends ACWindowComponent
{
	public function new(target:DisplayObject, getDock:Void->ICPopUpDock)
	{
		super();
		
		_target = target;
		_getDock = getDock;
	}
	
	var _target:DisplayObject;
	var _getDock:Void->ICPopUpDock;
	
	override function doSubscribe()
	{
		_target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	override function doUnsubscribe()
	{
		_target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
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
	
	override public function animateShow(fast:Bool):Void 
	{
		var width = getWidth();
		var height = getHeight();
		var dock = _getDock();
		var manager = _getManager();
		dock.arrange(
			width, height, manager.areaWidth, manager.areaHeight);
		super.move(dock.x + manager.areaX, dock.y + manager.areaY);
		super.animateShow(fast);
	}
	
	override public function move(x:Int, y:Int):Void
	{
		var manager = _getManager();
		if (manager != null)
		{
			var width = getWidth();
			var height = getHeight();
			var dock = _getDock();
			dock.move(
				width, height, manager.areaWidth, manager.areaHeight,
				x - manager.areaX, y - manager.areaY
			);
		}
		super.move(x, y);
	}
}