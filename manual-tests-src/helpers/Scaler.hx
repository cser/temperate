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
	
	var _oldX:Int;
	var _oldY:Int;
	var _oldWidth:Int;
	var _oldHeight:Int;
	
	function redraw()
	{
		var x = Std.int(_target.x);
		var y = Std.int(_target.y);
		var width = Std.int(_target.width);
		var height = Std.int(_target.height);
		if (x != _oldX || y != _oldY || width != _oldWidth || height != _oldHeight)
		{
			_oldX = x;
			_oldY = y;
			_oldWidth = width;
			_oldHeight = height;
			
			var g = _top.graphics;
			g.clear();
			g.lineStyle(0, 0xff0000);
			g.moveTo(x, y);
			g.lineTo(x + width * .5, y);
			g.moveTo(x + width * .5, y + height);
			g.lineTo(x + width, y + height);
		}
	}
	
	@:getter(width)
	function get_width():Float
	{
		return _target.width;
	}
	
	@:setter(width)
	function set_width(value:Float):Void
	{
		_target.width = value;
	}
	
	@:getter(height)
	function get_height():Float
	{
		return _target.height;
	}
	
	@:setter(height)
	function set_height(value:Float):Void
	{
		_target.height = value;
	}
}