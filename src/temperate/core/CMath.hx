package temperate.core;

class CMath 
{	
	inline public static var INT_MAX_VALUE:Int = 0x7fffffff;
	
	inline public static var INT_MIN_VALUE:Int = -0x80000000;
	
	inline public static function min(x:Float, y:Float):Float
	{
		return x < y ? x : y;
	}
	
	inline public static function max(x:Float, y:Float):Float
	{
		return x > y ? x : y;
	}
	
	inline public static function min3(x:Float, y:Float, z:Float):Float
	{
		var min = x < y ? x : y;
		return min < z ? min : z;
	}
	
	inline public static function max3(x:Float, y:Float, z:Float):Float
	{
		var max = x > y ? x : y;
		return max > z ? max : z;
	}
	
	inline public static function intMin(x:Int, y:Int):Int
	{
		return x < y ? x : y;
	}
	
	inline public static function intMax(x:Int, y:Int):Int
	{
		return x > y ? x : y;
	}
	
	inline public static function intMin3(x:Int, y:Int, z:Int):Int
	{
		var min = x < y ? x : y;
		return min < z ? min : z;
	}
	
	inline public static function intMax3(x:Int, y:Int, z:Int):Int
	{
		var max = x > y ? x : y;
		return max > z ? max : z;
	}
	
	inline public static function abs(x:Float):Float
	{
		return x > 0 ? x : -x;
	}
	
	inline public static function intAbs(x:Int):Int
	{
		return x > 0 ? x : -x;
	}
	
	inline public static function getAlpha(color:UInt):Float
	{
		return (color >>> 24) / 0xff;
	}
	
	inline public static function getColor(color:UInt):UInt
	{
		return color & 0x00ffffff;
	}
	
	inline public static function applyAlpha(colorPart:UInt, alphaPart:Float):UInt
	{
		return (Std.int(0xff * alphaPart) << 24) | (0x00ffffff & colorPart);
	}
	
	inline public static function toPrecision(x:Float, precision:Int):String
	{
		return untyped x.toPrecision(precision);
	}
	
	inline public static function toFixed(x:Float, fractionDigits:UInt):String
	{
		return untyped x.toFixed(fractionDigits);
	}
	
	inline public static function toLimitDigits(x:Float, maxDigits:UInt):String
	{
		var k = Math.round(Math.pow(10, maxDigits));
		return Std.string(Math.round(x * k) / k);
	}
	
	inline public static function toString(x:Float, radix:Int = 10):String
	{
		return untyped x.toString(radix);
	}
}