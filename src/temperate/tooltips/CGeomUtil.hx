package temperate.tooltips;

class CGeomUtil
{
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