package temperate.minimal.easing;

class MQuadBezier
{
	public function new() 
	{
	}
	
	public var x0:Float;
	public var y0:Float;
	public var x1:Float;
	public var y1:Float;
	public var x2:Float;
	public var y2:Float;
	
	inline public function getY(x:Float):Float
	{
		var t;
		var a = x0 - 2 * x1 + x2;
		if ((a > 0 ? a : -a) < .000000001)
		{
			/*
			2 * (x1 - x0) * t + x0 - x = 0;
			*/
			t = (x - x0) / (2 * (x1 - x0));
		}
		else
		{
			/*
			x = (x2 - 2 * x1 + x0) * t * t + 2 * (x1 - x0) * t + x0;
			(x0 - 2 * x1 + x2) * t * t + 2 * (x1 - x0) * t + x0 - x = 0;
			t = ( -2 * (x1 - x0) + Math.sqrt(D)) / (2 * (x0 - 2 * x1 + x2));
			*/
			var D = 4 * (x1 - x0) * (x1 - x0) - 4 * (x2 - 2 * x1 + x0) * (x0 - x);
			t = ( -2 * (x1 - x0) + Math.sqrt(D)) / (2 * a);
		}
		return (y2 - 2 * y1 + y0) * t * t + 2 * (y1 - y0) * t + y0;
	}
}