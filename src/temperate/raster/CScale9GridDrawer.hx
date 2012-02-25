package temperate.raster;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.geom.Matrix;

class CScale9GridDrawer implements ICDrawer
{
	static inline var DEFAULT_PADDING = 8;
	
	public function new(graphics:Graphics = null) 
	{
		this.graphics = graphics;
		left = right = top = bottom = DEFAULT_PADDING;
	}
	
	public var graphics:Graphics;
	
	static var _matrix:Matrix;
	
	static inline function getMatrix(kX:Float, kY:Float, tx:Float, ty:Float):Matrix
	{
		if (_matrix == null)
		{
			_matrix = new Matrix(kX, 0, 0, kY, tx, ty);
		}
		else
		{
			var matrix:Matrix = _matrix;
			matrix.a = kX;
			matrix.d = kY;
			matrix.tx = tx;
			matrix.ty = ty;
		}
		return _matrix;
	}
	
	public var x:Int;
	
	public var y:Int;
	
	public var width:Int;
	
	public var height:Int;
	
	public function setBounds(x:Int, y:Int, width:Int, height:Int):ICDrawer
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		return this;
	}
	
	public var bitmapData(default, null):BitmapData;
	
	public var bitmapWidth(default, null):Int;
	
	public var bitmapHeight(default, null):Int;
	
	public function setBitmapData(bitmapData:BitmapData):ICDrawer
	{
		this.bitmapData = bitmapData;
		if (bitmapData != null)
		{
			bitmapWidth = bitmapData.width;
			bitmapHeight = bitmapData.height;
		}
		return this;
	}
	
	public var left:Int;
	
	public var right:Int;
	
	public var top:Int;
	
	public var bottom:Int;
	
	public function setInsets(left:Int, right:Int, top:Int, bottom:Int)
	{
		this.left = left;
		this.right = right;
		this.top = top;
		this.bottom = bottom;
		return this;
	}
	
	public function redraw()
	{
		var w = width;
		var h = height;
		var g = graphics;
		g.clear();
		if (bitmapData == null)
		{
			return;
		}
		if (left > 0)
		{
			if(top > 0)
			{
				g.beginBitmapFill(bitmapData, getMatrix(1, 1, x, y));
				g.drawRect(x, y, left, top);
				g.endFill();
			}
			if (bottom > 0)
			{
				g.beginBitmapFill(bitmapData, getMatrix(1, 1, x, y + h - bitmapHeight));
				g.drawRect(x, y + h - bottom, left, bottom);
				g.endFill();
			}
		}
		if (right > 0)
		{
			if (top > 0)
			{
				g.beginBitmapFill(bitmapData, getMatrix(1, 1, x + w - bitmapWidth, y));
				g.drawRect(x + w - right, y, right, top);
				g.endFill();
			}
			if (bottom > 0)
			{
				g.beginBitmapFill(bitmapData, getMatrix(1, 1, x + w - bitmapWidth, y + h - bitmapHeight));
				g.drawRect(x + w - right, y + h - bottom, right, bottom);
				g.endFill();
			}
		}
		var kX = 0.;
		var hPadding = left + right;
		if (w - hPadding > 0)
		{
			kX = (w - hPadding) / (bitmapWidth - hPadding);
			g.beginBitmapFill(bitmapData, getMatrix(kX, 1, x + (1 - kX) * left, y));
			g.drawRect(x + left, y, w - hPadding, top);
			g.endFill();
			g.beginBitmapFill(bitmapData, getMatrix(kX, 1, x + (1 - kX) * left, h - bitmapHeight + y));
			g.drawRect(x + left, y + h - bottom, w - hPadding, bottom);
			g.endFill();
		}
		var kY = 0.;
		var vPadding = top + bottom;
		if (h - top - bottom > 0)
		{
			kY = (h - vPadding) / (bitmapHeight - vPadding);
			g.beginBitmapFill(bitmapData, getMatrix(1, kY, x, y + (1 - kY) * top));
			g.drawRect(x, y + top, left, h - vPadding);
			g.endFill();
			g.beginBitmapFill(bitmapData, getMatrix(1, kY, x + w - bitmapWidth, y + (1 - kY) * top));
			g.drawRect(x + w - right, y + top, right, h - vPadding);
			g.endFill();
		}
		if (w - hPadding > 0 && h - vPadding > 0)
		{
			g.beginBitmapFill(bitmapData, getMatrix(kX, kY, x + (1 - kX) * left, y + (1 - kY) * top));
			g.drawRect(x + left, y + top, w - hPadding, h - vPadding);
			g.endFill();
		}
	}
	
	public function clear()
	{
		if (graphics != null)
		{
			graphics.clear();
		}
	}
}