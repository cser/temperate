package temperate.skins;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;

class CRasterScrollSkin implements ICScrollSkin
{
	var _horizontalUp:BitmapData;
	var _verticalUp:BitmapData;
	var _horizontalDown:BitmapData;
	var _verticalDown:BitmapData;
	
	public function new(
		horizonalUp:BitmapData, verticalUp:BitmapData,
		horizontalDown:BitmapData = null, verticalDown:BitmapData = null)
	{
		_verticalUp = verticalUp;
		_horizontalUp = horizonalUp;
		_verticalDown = verticalDown;
		_horizontalDown = horizontalDown;
		
		leftIndent = 3;
		rightIndent = 3;
	}
	
	var leftIndent:Int;
	var rightIndent:Int;
	
	public function setIndents(leftIndent:Int, rightIndent:Int)
	{
		return this;
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
	
	var _scrollLeft:Int;
	var _scrollSize:Int;
	var _size:Int;
	
	public function setSize(scrollLeft:Int, scrollSize:Int, size:Int):Void
	{
		_scrollLeft = scrollLeft;
		_scrollSize = scrollSize;
		_size = size;
	}
	
	public function redrawUp()
	{
		var bd = _horizontal ? _horizontalUp : _verticalUp;
		var bdWidth = _horizontal ? bd.height : bd.width;
		_graphics.clear();
		_graphics.beginBitmapFill(bd);
		if (_horizontal)
		{
			_graphics.drawRect(leftIndent, 0, _size - leftIndent - rightIndent, bdWidth);
		}
		else
		{
			_graphics.drawRect(0, leftIndent, bdWidth, _size - leftIndent - rightIndent);
		}
		_graphics.endFill();
	}
	
	public function redrawDown(isLeft:Bool, thumbCenter:Int)
	{
		if (_horizontal && _horizontalDown == null || !_horizontal && _verticalDown == null)
		{
			redrawUp();
			return;
		}
		
		var bd = _horizontal ? _horizontalUp : _verticalUp;
		var bdWidth = _horizontal ? bd.height : bd.width;
		var indent = 3;
		_graphics.clear();
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
			_graphics.drawRect(leftIndent, 0, thumbCenter, bdWidth);
			_graphics.endFill();
			_graphics.beginBitmapFill(bdRight);
			_graphics.drawRect(
				thumbCenter, 0, _size - rightIndent - thumbCenter, bdWidth);
			_graphics.endFill();
		}
		else
		{
			_graphics.beginBitmapFill(bdLeft);
			_graphics.drawRect(0, leftIndent, bdWidth, thumbCenter);
			_graphics.endFill();
			_graphics.beginBitmapFill(bdRight);
			_graphics.drawRect(
				0, thumbCenter, bdWidth, _size - rightIndent - thumbCenter);
			_graphics.endFill();
		}
	}
}