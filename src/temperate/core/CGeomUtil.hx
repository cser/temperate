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
	
	public static function getUnionOfConvexPoligons(
		xys0:Array<Float>, xys1:Array<Float>, maxIterations:Int = 1000
	):Array<Float>
	{
		xys0 = getClockwized(xys0);
		xys1 = getClockwized(xys1);
		
		var result = [];
		var resultIndex = 0;
		
		var xys = xys0;
		var xys_ = xys1;
		var length = xys.length;
		var length_ = xys_.length;
		
		var j = length;
		var i = 0;
		while (true)
		{
			j -= 2;
			if (j < 0)
			{
				break;
			}
			if (!isInConvexPoligon(xys_, xys[j], xys[j + 1]))
			{
				i = j;
				break;
			}
		}
		
		var x0 = xys[i];
		var y0 = xys[i + 1];
		var startI = i;
		var startXys = xys;
		while (true)
		{
			maxIterations--;
			if (maxIterations < 0)
			{
				break;
			}
			i += 2;
			if (i >= length)
			{
				i = 0;
			}
			var x1 = xys[i];
			var y1 = xys[i + 1];
			
			var minDistance = -1.;
			var intersectX = 0.;
			var intersectY = 0.;
			var intersectJ = 0;
			{
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
						var dx = lineIntersectX - x0;
						var dy = lineIntersectY - y0;
						var distance = dx * dx + dy * dy;
						if (minDistance < 0 || distance < minDistance)
						{
							minDistance = distance;
							intersectX = lineIntersectX;
							intersectY = lineIntersectY;
							intersectJ = j;
						}
					}
					
					x0_ = x1_;
					y0_ = y1_;
					j += 2;
				}
			}
			
			if (minDistance < 0)
			{
				result[resultIndex++] = x1;
				result[resultIndex++] = y1;
				x0 = x1;
				y0 = y1;
			}
			else
			{
				result[resultIndex++] = intersectX;
				result[resultIndex++] = intersectY;
				var c = xys;
				xys = xys_;
				xys_ = c;
				var c = length;
				length = length_;
				length_ = c;
				i = intersectJ - 2;
				x0 = intersectX;
				y0 = intersectY;
			}
			if (i == startI && xys == startXys)
			{
				break;
			}
		}
		return result;
	}
	
	private static function getClockwized(xys:Array<Float>):Array<Float>
	{
		var clockwized = {
			var x0 = xys[0];
			var y0 = xys[1];
			var x1 = xys[2];
			var y1 = xys[3];
			var x2 = xys[4];
			var y2 = xys[5];
			(x1 - x0) * (y2 - y1) - (y1 - y0) * (x2 - x1) > 0;
		}
		if (clockwized)
		{
			return xys;
		}
		var result = [];
		var i = xys.length;
		var j = 0;
		while (true)
		{
			i -= 2;
			if (i < 0)
			{
				break;
			}
			result[j++] = xys[i];
			result[j++] = xys[i + 1];
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
		return (v1 * v2 < -.001) && (v3 * v4 < -.001);
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
	
	public static function getNearestRectCross(
		x0:Float, y0:Float, x1:Float, y1:Float,
		rectX:Float, rectY:Float, rectWidth:Float, rectHeight:Float, crossIndent:Float)
	{
		var rectX0 = rectX - crossIndent;
		var rectX1 = rectX + rectWidth + crossIndent;
		var rectY0 = rectY - crossIndent;
		var rectY1 = rectY + rectHeight + crossIndent;
		
		var dx = x1 - x0;
		var dy = y1 - y0;
		
		var k = getMinPositive(
			(rectX0 - x1) / dx,
			(rectX1 - x1) / dx,
			(rectY0 - y1) / dy,
			(rectY1 - y1) / dy
		);
		
		crossX = x1 - k * dx;
		crossY = y1 - k * dy;
	}
	
	static function getMinPositive(k0:Float, k1:Float, k2:Float, k3:Float)
	{
		var k = Math.POSITIVE_INFINITY;
		if (k0 > 0)
		{
			k = k0;
		}
		if (k1 > 0 && k1 < k)
		{
			k = k1;
		}
		if (k2 > 0 && k2 < k)
		{
			k = k2;
		}
		if (k3 > 0 && k3 < k)
		{
			k = k3;
		}
		return k == Math.POSITIVE_INFINITY ? 0 : k;
	}
	
	public static var crossX(default, null):Float;
	public static var crossY(default, null):Float;
}