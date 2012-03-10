package windowApplication.states;
import flash.events.MouseEvent;
import temperate.core.CMath;
import windowApplication.BdFactory;
import windowApplication.Primitive;

class FigureDrawState extends ADrawState
{
	public function new() 
	{
		super();
		
		icon = BdFactory.getFigure();
	}
	
	override function subscribe()
	{
		_image.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		_image.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_image.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	override function unsubscribe()
	{
		if (_pointIndex > 1)
		{
			lineTo(_firstX, _firstY);
		}
		_pointIndex = 0;
		_image.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		_image.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_image.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	var _pointIndex:Int;
	
	var _state:Int;
	var _x:Float;
	var _y:Float;
	var _firstX:Float;
	var _firstY:Float;
	var _isDown:Bool;
	
	function onMouseDown(event:MouseEvent)
	{
		_topGraphics.clear();
		_isDown = true;
		var x = _image.mouseX;
		var y = _image.mouseY;
		if (_pointIndex == 0)
		{			
			_x = x;
			_y = y;
			_firstX = _x;
			_firstY = _y;
			lineStyle();
			moveTo(_x, _y);
		}
		else
		{
			_x = x;
			_y = y;
			lineTo(_x, _y);
		}
		_pointIndex++;
	}
	
	function isNearEnd()
	{
		return CMath.abs(_image.mouseX - _firstX) < 5 && CMath.abs(_image.mouseY - _firstY) < 5;
	}
	
	function onMouseMove(event:MouseEvent)
	{
		_topGraphics.clear();
		var x = _image.mouseX;
		var y = _image.mouseY;
		if (_pointIndex > 0)
		{
			if (_isDown)
			{
				_x = x;
				_y = y;
				lineTo(_x, _y);
				_pointIndex++;
			}
			else
			{
				topLineStyle();
				_topGraphics.moveTo(_x, _y);
				_topGraphics.lineTo(x, y);
			}
		}
	}
	
	function onMouseUp(event:MouseEvent)
	{
		if (_pointIndex > 1)
		{
			if (isNearEnd())
			{
				lineTo(_firstX, _firstY);
				_pointIndex = 0;
			}
		}
		_isDown = false;
		_topGraphics.clear();
	}
}