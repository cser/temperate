package temperate.skins;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.geom.Matrix;

class CRasterScrollTiledSkin implements ICScrollSkin
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
		
		leftIndent = 0;
		rightIndent = 0;
		crossIndent = 0;
	}
	
	var leftIndent:Int;
	var rightIndent:Int;
	var crossIndent:Int;
	
	public function setIndents(leftIndent:Int, rightIndent:Int, crossIndent:Int)
	{
		this.leftIndent = leftIndent;
		this.rightIndent = rightIndent;
		this.crossIndent = crossIndent;
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
		_graphics.beginBitmapFill(bd, getMatrix());
		if (_horizontal)
		{
			_graphics.drawRect(leftIndent, crossIndent, _size - leftIndent - rightIndent, bdWidth);
		}
		else
		{
			_graphics.drawRect(crossIndent, leftIndent, bdWidth, _size - leftIndent - rightIndent);
		}
		_graphics.endFill();
	}
	
	var _matrix:Matrix;
	
	function getMatrix()
	{
		if (crossIndent == 0)
		{
			return null;
		}
		if (_matrix == null)
		{
			_matrix = new Matrix();
		}
		if (_horizontal)
		{
			_matrix.ty = crossIndent;
		}
		else
		{
			_matrix.tx = crossIndent;
		}
		return _matrix;
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
		var matrix = getMatrix();
		if (_horizontal)
		{
			_graphics.beginBitmapFill(bdLeft, matrix);
			_graphics.drawRect(leftIndent, crossIndent, thumbCenter, bdWidth);
			_graphics.endFill();
			_graphics.beginBitmapFill(bdRight, matrix);
			_graphics.drawRect(
				thumbCenter, crossIndent, _size - rightIndent - thumbCenter, bdWidth);
			_graphics.endFill();
		}
		else
		{
			_graphics.beginBitmapFill(bdLeft, matrix);
			_graphics.drawRect(crossIndent, leftIndent, bdWidth, thumbCenter);
			_graphics.endFill();
			_graphics.beginBitmapFill(bdRight, matrix);
			_graphics.drawRect(
				crossIndent, thumbCenter, bdWidth, _size - rightIndent - thumbCenter);
			_graphics.endFill();
		}
	}
}