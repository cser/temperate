package temperate.minimal.easing;

class MLinear 
{
	public static function ease(t:Float, b:Float, c:Float, d:Float):Float
	{
		return c * t / d + b;
	}
}