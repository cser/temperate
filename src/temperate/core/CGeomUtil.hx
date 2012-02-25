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
}