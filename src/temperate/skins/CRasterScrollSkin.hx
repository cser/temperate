package temperate.skins;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;

class CRasterScrollSkin implements ICScrollSkin
{
	var _horizontalUp:BitmapData;
	var _horizontalDown:BitmapData;
	var _verticalUp:BitmapData;
	var _verticalDown:BitmapData;
	
	public function new(
		horizonalUp:BitmapData, verticalUp:BitmapData,
		horizontalDown:BitmapData = null, verticalDown:BitmapData = null)
	{
		_horizontalUp = horizonalUp;
		_horizontalDown = horizontalDown;
		_verticalUp = verticalUp;
		_verticalDown = verticalDown;
		
		state = CScrollSkinState.UP;
	}
	
	var _horizontal:Bool;
	var _graphics:Graphics;
	
	public function link(
		horizontal:Bool, addChildAt0:DisplayObject->Dynamic, removeChild:DisplayObject->Dynamic,
		graphics:Graphics
	):Void
	{
		_horizontal = horizontal;
		_graphics = graphics;
	}
	
	public function unlink():Void
	{
		_graphics.clear();
		_graphics = null;
	}
	
	var _oldState:CScrollSkinState;
	
	public var state:CScrollSkinState;
	
	var _scrollLeft:Int;
	var _scrollSize:Int;
	var _size:Int;
	
	public function setSize(scrollLeft:Int, scrollSize:Int, size:Int):Void
	{
		_scrollLeft = scrollLeft;
		_scrollSize = scrollSize;
		_size = size;
	}
	
	public function redraw():Void
	{
		_oldState = state;
		var bd = _horizontal ? _horizontalUp : _verticalUp;
		var bdWidth = _horizontal ? bd.height : bd.width;
		var indent = 3;
		_graphics.clear();
		switch (state)
		{
			case CScrollSkinState.UP:
				_graphics.beginBitmapFill(bd);
				if (_horizontal)
				{
					_graphics.drawRect(indent, 0, _size - indent * 2, bdWidth);
				}
				else
				{
					_graphics.drawRect(0, indent, bdWidth, _size - indent * 2);
				}
				_graphics.endFill();
			case CScrollSkinState.DOWN(isLeft, thumbCenter):
				var bdLeft;
				var bdRight;
				if (isLeft)
				{
					bdLeft = _horizontal ? _horizontalDown : _verticalDown;
					bdRight = _horizontal ? _horizontalUp : _verticalUp;
				}
				else
				{
					bdLeft = _horizontal ? _horizontalUp : _verticalUp;
					bdRight = _horizontal ? _horizontalDown : _verticalDown;
				}
				if (_horizontal)
				{
					_graphics.beginBitmapFill(bdLeft);
					_graphics.drawRect(indent, 0, thumbCenter, bdWidth);
					_graphics.endFill();
					_graphics.beginBitmapFill(bdRight);
					_graphics.drawRect(thumbCenter, 0, _size - indent * 2 - thumbCenter, bdWidth);
					_graphics.endFill();
				}
				else
				{
					_graphics.beginBitmapFill(bdLeft);
					_graphics.drawRect(0, indent, bdWidth, thumbCenter);
					_graphics.endFill();
					_graphics.beginBitmapFill(bdRight);
					_graphics.drawRect(0, thumbCenter, bdWidth, _size - indent * 2 - thumbCenter);
					_graphics.endFill();
				}
		}
	}
}