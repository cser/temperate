package windowApplication.states;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.MouseEvent;
import temperate.core.CSprite;

class ADrawState 
{
	function new() 
	{
		_topSprite =  new Sprite();
		_topGraphics = _topSprite.graphics;
	}
	
	var _image:CSprite;
	var _graphics:Graphics;
	var _topSprite:Sprite;
	var _topGraphics:Graphics;
	
	public function setImage(image:CSprite)
	{
		if (_image != image)
		{
			if (_image != null)
			{
				unsubscribe();
				_graphics = null;
				_image.removeChild(_topSprite);
			}
			_image = image;
			if (_image != null)
			{
				_image.addChild(_topSprite);
				_graphics = _image.graphics;
				subscribe();
			}
		}
	}
	
	function subscribe()
	{
		_image.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	function unsubscribe()
	{
		_image.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	function onMouseDown(event:MouseEvent)
	{
		_image.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_image.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		doStart();
	}
	
	function onMouseMove(event:MouseEvent)
	{
		doMove();
	}
	
	function onMouseUp(event:MouseEvent)
	{
		_image.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		_image.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		doComplete();
	}
	
	function doStart()
	{
	}
	
	function doMove()
	{
	}
	
	function doComplete()
	{
	}
}