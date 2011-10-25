package temperate.minimal.easing;

class AMEase
{
	function new() 
	{
		
	}
	
	public function easeIn(t:Float, b:Float, c:Float, d:Float):Float
	{
		return Math.NaN;
	}
	
	public function easeOut(t:Float, b:Float, c:Float, d:Float):Float
	{
		return easeIn(d - t, b + c, -c, d);
	}
	
	public function easeInOut(t:Float, b:Float, c:Float, d:Float):Float
	{
		var halfD = .5 * d;
		return t < halfD ?
			easeIn(2 * t, b, .5 * c, d) :
			easeIn(2 * (d - t), b + c, - .5 * c, d);
	}
}