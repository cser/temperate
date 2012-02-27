package temperate.core;

class CGeomUtil 
{
	public static function isInTriangle(
		x0:Float, y0:Float, x1:Float, y1:Float, x2:Float, y2:Float, x:Float, y:Float):Bool
	{
		return (x1 - x0) * (y - y0) - (y1 - y0) * (x - x0) >= 0 &&
			(x2 - x1) * (y - y1) - (y2 - y1) * (x - x1) >= 0 &&
			(x0 - x2) * (y - y2) - (y0 - y2) * (x - x2) >= 0;
	}
	
	public static function isInConvexPoligon(xys:Array<Float>, x:Float, y:Float):Bool
	{
		var length = xys.length;
		var i = length - 2;
		var x0 = xys[i];
		var y0 = xys[i + 1];
		var directionK = {
			var x1 = xys[i - 2];
			var y1 = xys[i - 1];
			var x2 = xys[i - 4];
			var y2 = xys[i - 3];
			(x1 - x0) * (y2 - y1) - (y1 - y0) * (x2 - x1) > 0 ? -1 : 1;
		}
		i = 0;
		while (i < length)
		{
			var x1 = xys[i];
			var y1 = xys[i + 1];
			if (directionK * ((x1 - x0) * (y - y0) - (y1 - y0) * (x - x0)) < 0)
			{
				return false;
			}
			x0 = x1;
			y0 = y1;
			i += 2;
		}
		return true;
	}
	
	/**
	 * Need clockwise direction both
	 */
	public static function getUnionPoligon(xys0:Array<Float>, xys1:Array<Float>):Array<Float>
	{
		var result = [];
		
		var length0 = xys0.length;
		var length1 = xys1.length;
		
		var xys = xys0;
		var xys_ = xys1;
		var length = length0;
		var length_ = length1;
		var i = 0;
		var x0 = xys[i];
		var y0 = xys[i + 1];
		for (k in 0 ... 100)
		{
			i += 2;
			if (i >= length)
			{
				i = 0;
			}
			var x1 = xys[i];
			var y1 = xys[i + 1];
			
			var j = length_ - 2;
			var x0_ = xys_[j];
			var y0_ = xys_[j + 1];
			j = 0;
			while (j < length_)
			{
				var x1_ = xys_[j];
				var y1_ = xys_[j + 1];
				
				if (isSegmentsCross(x0, y0, x1, y1, x0_, y0_, x1_, y1_))
				{
					getLineIntersect(x0, y0, x1, y1, x0_, y0_, x1_, y1_);
					result.push(lineIntersectX);
					result.push(lineIntersectY);
				}
				
				x0_ = x1_;
				y0_ = y1_;
				j += 2;
			}
			
			if (!isInConvexPoligon(xys1, x0, y0))
			{
				result.push(x0);
				result.push(y0);
			}
			
			x0 = x1;
			y0 = y1;
			i += 2;
		}
		
		return result;
	}
	
	public static inline function isSegmentsCross(
		x1:Float, y1:Float, x2:Float, y2:Float, x1_:Float, y1_:Float, x2_:Float, y2_:Float):Bool
	{
		var v1 = (x2_ - x1_) * (y1 - y1_) - (y2_ - y1_) * (x1 - x1_);
		var v2 = (x2_ - x1_) * (y2 - y1_) - (y2_ - y1_) * (x2 - x1_);
		var v3 = (x2 - x1) * (y1_ - y1) - (y2 - y1) * (x1_ - x1);
		var v4 = (x2 - x1) * (y2_ - y1) - (y2 - y1) * (x2_ - x1);
		return (v1 * v2 < 0) && (v3 * v4 < 0);
	}
	
	public static inline function getLineIntersect(
		x1:Float, y1:Float, x2:Float, y2:Float, x1_:Float, y1_:Float, x2_:Float, y2_:Float):Void
	{
		var a = y1 - y2;
		var b = x2 - x1;
		var c = x1 * y2 - x2 * y1;
		var a_ = y1_ - y2_;
		var b_ = x2_ - x1_;
		var c_ = x1_ * y2_ - x2_ * y1_;
		var k = (a * b_ - a_ * b);
		lineIntersectX = (b * c_ - b_ * c) / k;
		lineIntersectY = (c * a_ - c_ * a) / k;
	}
	
	public static var lineIntersectX(default, null):Float;
	public static var lineIntersectY(default, null):Float;
}