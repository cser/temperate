package temperate.raster;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.geom.Matrix;
import temperate.core.CMath;

class CVScale12GridDrawer 
{
	static inline var DEFAULT_PADDING = 8;
	
	public function new() 
	{
		left = right = top = bottom = DEFAULT_PADDING;
	}
	
	public var bitmapData(default, null):BitmapData;
	
	public var bitmapWidth(default, null):Int;
	
	public var bitmapHeight(default, null):Int;
	
	public function setBitmapData(bitmapData:BitmapData):CVScale12GridDrawer
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
	
	public var bitmapCenterTop:Int;
	
	public var centerHeight:Int;
	
	public function setInsets(
		left:Int, right:Int, top:Int, bottom:Int, bitmapCenterTop:Int, centerHeight:Int
	):CVScale12GridDrawer
	{
		this.left = left;
		this.right = right;
		this.top = top;
		this.bottom = bottom;
		this.bitmapCenterTop = bitmapCenterTop;
		this.centerHeight = centerHeight;
		return this;
	}
	
	static var _matrix:Matrix;
	
	inline function getMatrix(kX:Float, kY:Float, tx:Float, ty:Float):Matrix
	{
		_matrix.a = kX;
		_matrix.d = kY;
		_matrix.tx = tx;
		_matrix.ty = ty;
		return _matrix;
	}
	
	public var x:Int;
	
	public var y:Int;
	
	public var width:Int;
	
	public var height:Int;
	
	public var centerTop:Int;
	
	public function setBounds(
		x:Int, y:Int, width:Int, height:Int, centerTop:Int):CVScale12GridDrawer
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.centerTop = centerTop;
		return this;
	}
	
	/**
	 * Method is not clear graphics!
	 * @param	graphics
	 */
	public function draw(graphics:Graphics):Void
	{
		if (bitmapData == null)
		{
			return;
		}
		
		if (_matrix == null)
		{
			_matrix = new Matrix();
		}
		
		/*
		   x0  x1    x2  x3
		y0 |---|-----|---|
		y1 |---|-----|---|
		   |   |     |   |
		y2 |---|-----|---|
		y3 |---|-----|---|
		   |   |     |   |
		y4 |---|-----|---|
		y5 |---|-----|---|
		*/
		
		var w = CMath.intMax(width, left + right + 1);
		var h = CMath.intMax(height, top + 1 + centerHeight + 1 + bottom);
		
		var x0 = x;
		var x1 = x + left;
		var x2 = x + w - right;
		var x3 = x + w;
		
		var y0 = y;
		var y1 = y + top;
		var y2 = y + centerTop;
		if (y2 < y + top + 1)
		{
			y2 = y + top + 1;
		}
		else if (y2 > y + h - bottom - 1 - centerHeight)
		{
			y2 = y + h - bottom - 1 - centerHeight;
		}
		var y3 = y2 + centerHeight;
		var y4 = y + height - bottom;
		var y5 = y + height;
		
		var bdX1 = left;
		var bdX2 = bitmapWidth - right;
		var bdX3 = bitmapWidth;
		
		var bdY1 = top;
		var bdY2 = bitmapCenterTop;
		var bdY3 = bdY2 + centerHeight;
		var bdY4 = bitmapHeight - bottom;
		var bdY5 = bitmapHeight;
		
		var g = graphics;
		g.lineStyle();
		
		var kx12 = (x2 - x1) / (bdX2 - bdX1);
		var tx12 = x1 - bdX1 * kx12;
		
		// Line 1
		
		g.beginBitmapFill(bitmapData, getMatrix(1, 1, x0, y0));
		g.drawRect(x0, y0, x1 - x0, y1 - y0);
		g.endFill();
		
		g.beginBitmapFill(bitmapData, getMatrix(kx12, 1, tx12, y0));
		g.drawRect(x1, y0, x2 - x1, y1 - y0);
		g.endFill();
		
		g.beginBitmapFill(bitmapData, getMatrix(1, 1, x2 - bdX2, y0));
		g.drawRect(x2, y0, x3 - x2, y1 - y0);
		g.endFill();
		
		// Line 2
		
		var ky = (y2 - y1) / (bdY2 - bdY1);
		var ty = y1 - bdY1 * ky;
		
		g.beginBitmapFill(bitmapData, getMatrix(1, ky, x0, ty));
		g.drawRect(x0, y1, x1 - x0, y2 - y1);
		g.endFill();
		
		g.beginBitmapFill(bitmapData, getMatrix(kx12, ky, tx12, ty));
		g.drawRect(x1, y1, x2 - x1, y2 - y1);
		g.endFill();
		
		g.beginBitmapFill(bitmapData, getMatrix(1, ky, x2 - bdX2, ty));
		g.drawRect(x2, y1, x3 - x2, y2 - y1);
		g.endFill();
		
		// Line 3
		
		g.beginBitmapFill(bitmapData, getMatrix(1, 1, x0, y2 - bdY2));
		g.drawRect(x0, y2, x1 - x0, y3 - y2);
		g.endFill();
		
		g.beginBitmapFill(bitmapData, getMatrix(kx12, 1, tx12, y2 - bdY2));
		g.drawRect(x1, y2, x2 - x1, y3 - y2);
		g.endFill();
		
		g.beginBitmapFill(bitmapData, getMatrix(1, 1, x2 - bdX2, y2 - bdY2));
		g.drawRect(x2, y2, x3 - x2, y3 - y2);
		g.endFill();
		
		// Line 4
		
		var ky = (y4 - y3) / (bdY4 - bdY3);
		var ty = y3 - bdY3 * ky;
		
		g.beginBitmapFill(bitmapData, getMatrix(1, ky, x0, ty));
		g.drawRect(x0, y3, x1 - x0, y4 - y3);
		g.endFill();
		
		g.beginBitmapFill(bitmapData, getMatrix(kx12, ky, tx12, ty));
		g.drawRect(x1, y3, x2 - x1, y4 - y3);
		g.endFill();
		
		g.beginBitmapFill(bitmapData, getMatrix(1, ky, x2 - bdX2, ty));
		g.drawRect(x2, y3, x3 - x2, y4 - y3);
		g.endFill();
		
		// Line 5
		
		g.beginBitmapFill(bitmapData, getMatrix(1, 1, x0, y4 - bdY4));
		g.drawRect(x0, y4, x1 - x0, y5 - y4);
		g.endFill();
		
		g.beginBitmapFill(bitmapData, getMatrix(kx12, 1, tx12, y4 - bdY4));
		g.drawRect(x1, y4, x2 - x1, y5 - y4);
		g.endFill();
		
		g.beginBitmapFill(bitmapData, getMatrix(1, 1, x2 - bdX2, y4 - bdY4));
		g.drawRect(x2, y4, x3 - x2, y5 - y4);
		g.endFill();
	}
}