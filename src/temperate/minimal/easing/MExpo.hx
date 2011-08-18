package temperate.minimal.easing;

class MExpo extends AMEase
{
	public static var typical(get_typical, null):MExpo;
	static var _typical:MExpo;
	static function get_typical()
	{
		if (_typical == null)
		{
			_typical = new MExpo( -1.5, 4);
		}
		return _typical;
	}
	
	var _beginValue:Float;
	var _endValue:Float;
	var _beginX:Float;
	var _endX:Float;
	
	public function new(beginX:Float, endX:Float)
	{
		super();
		
		_beginX = beginX;
		_endX = endX;
		_beginValue = Math.exp(_beginX);
		_endValue = Math.exp(_endX);
	}
	
	override public function easeIn(t:Float, b:Float, c:Float, d:Float):Float
	{
		return c * (Math.exp((_endX - _beginX) * t / d + _beginX) - _beginValue) / (_endValue -
			_beginValue) + b;
	}
}