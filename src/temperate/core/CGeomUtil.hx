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
	 * Mast be convex and clockwise direction both
	 */
	public static function getUnionPoligon(xys0:Array<Float>, xys1:Array<Float>):Array<Float>
	{
		var result = [];
		
		var xys = xys0;
		var xys_ = xys1;
		var i = xys.length - 2;
		var x0 = xys[i];
		var y0 = xys[i + 1];
		var startI = i;
		var startXys = xys;
		while (true)
		{
			i += 2;
			if (i >= xys.length)
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
				var j = xys_.length - 2;
				var x0_ = xys_[j];
				var y0_ = xys_[j + 1];
				j = 0;
				while (j < xys_.length)
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
				result.push(x1);
				result.push(y1);
				x0 = x1;
				y0 = y1;
			}
			else
			{
				result.push(intersectX);
				result.push(intersectY);
				var c = xys;
				xys = xys_;
				xys_ = c;
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