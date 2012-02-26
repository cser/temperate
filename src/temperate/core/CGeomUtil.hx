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
		
		var lengthI = xys0.length;
		var i = lengthI - 2;
		var x0 = xys0[i];
		var y0 = xys0[i + 1];
		i = 0;
		while (i < lengthI)
		{
			var x1 = xys0[i];
			var y1 = xys0[i + 1];
			
			
			var lengthJ = xys1.length;
			var j = lengthJ - 2;
			var xj0 = xys1[j];
			var yj0 = xys1[j + 1];
			j = 0;
			while (j < lengthJ)
			{
				var xj1 = xys0[j];
				var yj1 = xys0[j + 1];
				
				var intersection = {
					var v1 = (xj1 - xj0) * (y0 - yj0) - (yj1 - yj0) * (x0 - xj0);
					var v2 = (xj1 - xj0) * (y1 - yj0) - (yj1 - yj0) * (x1 - xj0);
					var v3 = (x1 - x0) * (yj0 - y0) - (y1 - y0) * (xj0 - x0);
					var v4 = (x1 - x0) * (yj1 - y0) - (y1 - y0) * (xj1 - x0);
					(v1 * v2 < 0) && (v3 * v4 < 0);
				}
				if (intersection)
				{
					
				}
				
				xj0 = xj1;
				yj0 = yj1;
				j += 2;
			}
			
			x0 = x1;
			y0 = y1;
			i += 2;
		}
		
		result = xys0;
		return result;
	}
}