package helpers;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

class Scaler extends Sprite
{
	var _target:DisplayObject;
	var _round:Sprite;
	var _top:Shape;
	
	public function new(target:DisplayObject)
	{
		super();
		
		_target = target;
		addChild(_target);
		
		_round = new Sprite();
		_round.addEventListener(MouseEvent.MOUSE_DOWN, onRoundMouseDown);
		addChild(_round);
		
		_top = new Shape();
		addChild(_top);
		
		var g = _round.graphics;
		g.beginFill(0xff0000);
		g.drawCircle(0, 0, 8);
		g.endFill();
		
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedStage);
	}
	
	function onAddedToStage(event:Event)
	{
		addEventListener(Event.ENTER_FRAME, onEnterFrameForUpdate);
	}
	
	function onRemovedStage(event:Event)
	{
		removeEventListener(Event.ENTER_FRAME, onEnterFrameForUpdate);
	}
	
	function onEnterFrameForUpdate(event:Event)
	{
		update();
	}
	
	function onRoundMouseDown(event:Event)
	{
		removeEventListener(Event.ENTER_FRAME, onEnterFrameForUpdate);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	function onMouseUp(event:Event)
	{
		addEventListener(Event.ENTER_FRAME, onEnterFrameForUpdate);
		
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	function onEnterFrame(event:Event)
	{
		_round.x = mouseX;
		_round.y = mouseY;
		_target.width = Std.int(_round.x - _target.x);
		_target.height = Std.int(_round.y - _target.y);
		redraw();
	}
	
	public function update()
	{
		redraw();
		_round.x = _target.x + _target.width;
		_round.y = _target.y + _target.height;
	}
	
	function redraw()
	{
		var g = _top.graphics;
		g.clear();
		g.lineStyle(0, 0xff0000);
		
		var x = _target.x;
		var y = _target.y;
		var width = _target.width;
		var height = _target.height;
		g.moveTo(x, y);
		g.lineTo(x + width * .5, y);
		g.moveTo(x + width * .5, y + height);
		g.lineTo(x + width, y + height);
	}
}