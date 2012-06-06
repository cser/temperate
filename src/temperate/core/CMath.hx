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
	
	inline public static function getAlpha(color:Int):Float
	{
		return (color >>> 24) / 0xff;
	}
	
	inline public static function getColor(color:Int):Int
	{
		return color & 0x00ffffff;
	}
	
	inline public static function applyAlpha(colorPart:Int, alphaPart:Float):Int
	{
		return (Std.int(0xff * alphaPart) << 24) | (0x00ffffff & colorPart);
	}
	
	public static function toFixed(x:Float, fractionDigits:Int):String
	{
		#if flash9
		return untyped x.toFixed(fractionDigits);
		#else
		for (i in 0 ... fractionDigits)
		{
			x *= 10;
		}
		var text = Std.string(Math.round(x));
		if (fractionDigits <= 0)
		{
			return text == "0" ? "0." : text;
		}
		else
		{
			var index = text.length - fractionDigits;
			if (index >= 0)
			{
				var left = text.substr(0, index);
				return (left != "" ? left : "0") + "." + text.substr(index);
			}
			else
			{
				for (i in 0 ... -index)
				{
					text = "0" + text;
				}
				return "0." + text;
			}
		}
		#end
	}
	
	public static function toLimitDigits(x:Float, maxDigits:Int):String
	{
		var k = Math.round(Math.pow(10, maxDigits));
		return Std.string(Math.round(x * k) / k);
	}
	
	public static function toHex(x:Int):String
	{
		#if flash9
		return untyped x.toString(16);
		#else
		var text = "";
		var begin = false;
		for (i in 0 ... 8)
		{
			var digit = (x & 0xf0000000) >>> 28;
			if (digit != 0)
			{
				begin = true;
			}
			if (begin)
			{
				switch (digit)
				{
					case 0: text += "0";
					case 1: text += "1";
					case 2: text += "2";
					case 3: text += "3";
					case 4: text += "4";
					case 5: text += "5";
					case 6: text += "6";
					case 7: text += "7";
					case 8: text += "8";
					case 9: text += "9";
					case 10: text += "a";
					case 11: text += "b";
					case 12: text += "c";
					case 13: text += "d";
					case 14: text += "e";
					case 15: text += "f";
				};
			}
			x <<= 4;
		}
		return text != "" ? text : "0";
		#end
	}
}