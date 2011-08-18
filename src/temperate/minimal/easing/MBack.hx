package temperate.minimal.easing;

class MBack extends AMEase
{
	public static var typical(get_typical, null):MBack;
	static var _typical:MBack;
	static function get_typical()
	{
		if (_typical == null)
		{
			_typical = new MBack();
		}
		return _typical;
	}
	
	public static var typicalAbsolute(get_typicalAbsolute, null):MBack;
	static var _typicalAbsolute:MBack;
	static function get_typicalAbsolute()
	{
		if (_typicalAbsolute == null)
		{
			_typicalAbsolute = new MBack(.65, 5, true);
		}
		return _typicalAbsolute;
	}
	
	var _extremumRatio:Float;
	var _offset:Float;
	var _absolute:Bool;
	
	var _bezier:MQuadBezier;
	
	public function new(extremumRatio:Float = .65, offset:Float = .1, absolure:Bool = false)
	{
		super();
		
		_extremumRatio = extremumRatio;
		_offset = offset;
		_absolute = absolure;
		
		_bezier = new MQuadBezier();
	}
	
	override public function easeIn(t:Float, b:Float, c:Float, d:Float):Float
	{
		var extremumY = if (_absolute)
		{
			b + c + (c > 0 ? _offset : -_offset);
		}
		else
		{
			b + c + c * _offset;
		}
		
		var x = t / d;
		if (x < _extremumRatio)
		{
			_bezier.x0 = 0;
			_bezier.y0 = b;
			_bezier.x1 = _extremumRatio * .5;
			_bezier.y1 = extremumY;
			_bezier.x2 = _extremumRatio;
			_bezier.y2 = extremumY;
			return _bezier.getY(x);
		}
		else if (x < (_extremumRatio + 1) * .5)
		{
			_bezier.x0 = _extremumRatio;
			_bezier.y0 = extremumY;
			_bezier.x1 = _extremumRatio + .25 * (1 - _extremumRatio);
			_bezier.y1 = extremumY;
			_bezier.x2 = _extremumRatio + .5 * (1 - _extremumRatio);
			_bezier.y2 = (b + c + extremumY) * .5;
			return _bezier.getY(x);
		}
		else
		{
			_bezier.x0 = _extremumRatio + .5 * (1 - _extremumRatio);
			_bezier.y0 = (b + c + extremumY) * .5;
			_bezier.x1 = _extremumRatio + .75 * (1 - _extremumRatio);
			_bezier.y1 = b + c;
			_bezier.x2 = 1;
			_bezier.y2 = b + c;
			return  _bezier.getY(x);
		}
	}
}