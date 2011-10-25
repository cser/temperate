package temperate.minimal.easing;

class MPower extends AMEase
{
	public static var quad(get_quad, null):MPower;
	static var _quad:MPower;
	static function get_quad()
	{
		if (_quad == null)
		{
			_quad = new MPower(2);
		}
		return _quad;
	}
	
	public static var cubic(get_cubic, null):MPower;
	static var _cubic:MPower;
	static function get_cubic()
	{
		if (_cubic == null)
		{
			_cubic = new MPower(2);
		}
		return _cubic;
	}
	
	var _power:Int;
	
	public function new(power:Int) 
	{
		super();
		
		_power = power;
	}
	
	override public function easeIn(t:Float, b:Float, c:Float, d:Float):Float
	{
		var tratio = t / d;
		return c * tratio * Math.pow(tratio, _power) + b;
	}
}