package temperate.raster;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.geom.Matrix;

class Scale3GridDrawer implements IDrawer
{
	private static inline var DEFAULT_PADDING = 8;
	
	public function new(horizontal:Bool, graphics:Graphics = null) 
	{
		_horizontal = horizontal;
		this.graphics = graphics;
		left = right = DEFAULT_PADDING;
	}
	
	var _horizontal:Bool;
	
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
	
	public function setBounds(x:Int, y:Int, width:Int, height:Int):IDrawer
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
	
	public function setBitmapData(bitmapData:BitmapData):IDrawer
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
	
	public function setInsets(left:Int, right:Int)
	{
		this.left = left;
		this.right = right;
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
			g.beginBitmapFill(bitmapData, getMatrix(1, 1, x, y));
			if (_horizontal)
			{
				g.drawRect(x, y, left, bitmapHeight);
			}
			else
			{
				g.drawRect(x, y, bitmapWidth, left);
			}
			g.endFill();
		}
		if (right > 0)
		{
			if (_horizontal)
			{
				g.beginBitmapFill(bitmapData, getMatrix(1, 1, x + w - bitmapWidth, y));
				g.drawRect(x + w - right, y, right, bitmapHeight);
				g.endFill();
			}
			else
			{
				g.beginBitmapFill(bitmapData, getMatrix(1, 1, x, y + h - bitmapHeight));
				g.drawRect(x, y + h - right, bitmapWidth, right);
				g.endFill();
			}
		}
		var padding = left + right;		
		if (_horizontal)
		{
			if (w - padding > 0)
			{
				var k = (w - padding) / (bitmapWidth - padding);
				g.beginBitmapFill(bitmapData, getMatrix(k, 1, x + (1 - k) * left, y));
				g.drawRect(x + left, y, w - padding, bitmapHeight);
				g.endFill();
			}
		}
		else
		{
			if (h - padding > 0)
			{
				var k = (h - padding) / (bitmapHeight - padding);
				g.beginBitmapFill(bitmapData, getMatrix(1, k, x, y + (1 - k) * left));
				g.drawRect(x, y + left, bitmapHeight, h - padding);
				g.endFill();
			}
		}
	}
}