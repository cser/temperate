package temperate.minimal.easing;

class MBounce extends AMEase
{
	public static var typical(get_typical, null):MBounce;
	static var _typical:MBounce;
	static function get_typical()
	{
		if (_typical == null)
		{
			_typical = new MBounce();
		}
		return _typical;
	}
	
	public static var typicalAbsolute(get_typicalAbsolute, null):MBounce;
	static var _typicalAbsolute:MBounce;
	static function get_typicalAbsolute()
	{
		if (_typicalAbsolute == null)
		{
			_typicalAbsolute = new MBounce(10, true);
		}
		return _typicalAbsolute;
	}
	
	var _maxOffset:Float;
	var _absolute:Bool;
	
	var _bezier:MQuadBezier;
	
	public function new(maxOffset:Float = .2, absolute:Bool = false)
	{
		super();
		
		_maxOffset = maxOffset;
		_absolute = absolute;
		
		_bezier = new MQuadBezier();
	}
	
	override public function easeIn(t:Float, b:Float, c:Float, d:Float):Float
	{
		var maxOffset = if (_absolute)
		{
			(c > 0 ? _maxOffset : -_maxOffset);
		}
		else
		{
			c * _maxOffset;
		}
		var x1 = .10;
		var x2 = .28;
		var x3 = .65;
		var x = t / d;
		if (x < x1)
		{
			_bezier.x0 = 0;
			_bezier.y0 = b;
			_bezier.x1 = x1 * .5;
			_bezier.y1 = b + maxOffset * 2 * .11;
			_bezier.x2 = x1;
			_bezier.y2 = b;
			return _bezier.getY(x);
		}
		else if (x < x2)
		{
			_bezier.x0 = x1;
			_bezier.y0 = b;
			_bezier.x1 = (x1 + x2) * .5;
			_bezier.y1 = b + maxOffset * 2 * .35;
			_bezier.x2 = x2;
			_bezier.y2 = b;
			return _bezier.getY(x);
		}
		else if (x < x3)
		{
			_bezier.x0 = x2;
			_bezier.y0 = b;
			_bezier.x1 = (x2 + x3) * .5;
			_bezier.y1 = b + maxOffset * 2;
			_bezier.x2 = x3;
			_bezier.y2 = b;
			return _bezier.getY(x);
		}
		else
		{
			_bezier.x0 = x3;
			_bezier.y0 = b;
			_bezier.x1 = (x3 + 1) * .5;
			_bezier.y1 = b + c;
			_bezier.x2 = 1;
			_bezier.y2 = b + c;
			return _bezier.getY(x);
		}
	}
}