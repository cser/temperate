package oldStyleCalculator;

class Operation 
{
	public static var PLUS = new Operation("+", calculatePlus);
	public static var MINUS = new Operation("-", calculateMinus);
	public static var MULTIPLY = new Operation("*", calculateMultiply);
	public static var DIVIDE = new Operation("/", calculateDivide);
	
	function new(sign:String, calculate:Float->Float->Float) 
	{
		this.sign = sign;
		this.calculate = calculate;
	}
	
	public var sign(default, null):String;
	
	public var calculate(default, null):Float->Float->Float;
	
	static function calculatePlus(value0:Float, value1:Float)
	{
		return value0 + value1;
	}
	
	static function calculateMinus(value0:Float, value1:Float)
	{
		return value0 - value1;
	}
	
	static function calculateMultiply(value0:Float, value1:Float)
	{
		return value0 * value1;
	}
	
	static function calculateDivide(value0:Float, value1:Float)
	{
		return value0 / value1;
	}
}