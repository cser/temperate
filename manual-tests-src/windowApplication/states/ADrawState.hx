package windowApplication.states;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.MouseEvent;
import temperate.core.CSprite;
import windowApplication.EditorState;
import windowApplication.Primitive;
import windowApplication.Primitives;

class ADrawState 
{
	function new() 
	{
		_topSprite =  new Sprite();
		_topGraphics = _topSprite.graphics;
	}
	
	var _editorState:EditorState;
	
	public function init(editorState:EditorState)
	{
		_editorState = editorState;
	}
	
	public var icon(default, null):Class<BitmapData>;
	
	var _image:CSprite;
	var _graphics:Graphics;
	var _topSprite:Sprite;
	var _topGraphics:Graphics;
	var _primitives:Primitives;
	
	public function setImage(image:CSprite, primitives:Primitives)
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
			_primitives = primitives;
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
		_image.addEventListener(MouseEvent.MOUSE_DOWN, onImageMouseDown);
	}
	
	function unsubscribe()
	{
		_image.removeEventListener(MouseEvent.MOUSE_DOWN, onImageMouseDown);
	}
	
	function onImageMouseDown(event:MouseEvent)
	{
		_image.addEventListener(MouseEvent.MOUSE_MOVE, onImageMouseMove);
		_image.stage.addEventListener(MouseEvent.MOUSE_UP, onImageMouseUp);
		doStart();
	}
	
	function onImageMouseMove(event:MouseEvent)
	{
		doMove();
	}
	
	function onImageMouseUp(event:MouseEvent)
	{
		_image.removeEventListener(MouseEvent.MOUSE_MOVE, onImageMouseMove);
		_image.stage.removeEventListener(MouseEvent.MOUSE_UP, onImageMouseUp);
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
	
	function moveTo(x:Float, y:Float)
	{
		_graphics.moveTo(x, y);
		_primitives.push(MOVE_TO(x, y));
	}
	
	function lineTo(x:Float, y:Float)
	{
		_graphics.lineTo(x, y);
		_primitives.push(LINE_TO(x, y));
	}
	
	function topLineStyle()
	{
		_topGraphics.lineStyle(0, _editorState.color);
	}
	
	function lineStyle()
	{
		_graphics.lineStyle(0, _editorState.color);
		_primitives.push(LINE_STYLE(_editorState.color));
	}
}