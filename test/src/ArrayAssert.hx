package ;
import flash.utils.Dictionary;
import haxe.PosInfos;
import massive.munit.Assert;

class ArrayAssert 
{
	public static function areEqual(expected:Array<Dynamic>, actual:Array<Dynamic>, ?info:PosInfos)
	{
		Assert.assertionCount++;
		if (expected == actual || expected == null && actual == null)
		{
			return;
		}
		if (actual == null || expected == null || actual.length != expected.length)
		{
			Assert.fail("[" + actual + "] getted, but expected [" + expected + "]", info);
		}
		for (i in 0 ... actual.length)
		{
			if (actual[i] != expected[i])
			{
				Assert.fail("[" + actual + "] getted, but expected [" + expected + "]", info);
			}
		}		
	}
	
	public static function areEqualIgnoringOrder(
		expected:Array<Dynamic>, actual:Array<Dynamic>, ?info:PosInfos)
	{
		Assert.assertionCount++;
		var result = checkEqualIgnoringOrder(expected, actual);
		if (result != null)
		{
			Assert.fail(result, info);
		}
	}
	
	static function checkEqualIgnoringOrder(expected:Array<Dynamic>, actual:Array<Dynamic>)
	{
		if (expected == actual || expected == null && actual == null)
		{
			return null;
		}
		if (actual == null || expected == null || actual.length != expected.length)
		{
			return "[" + actual + "] getted, but expected [" + expected + "]";
		}
		var countByValue:Dictionary = new Dictionary();
		for (value in actual)
		{
			var count:Int = untyped countByValue[cast value];
			count++;
			untyped countByValue[cast value] = count;
		}
		
		for (value in expected)
		{
			var count:Int = untyped countByValue[cast value];
			count--;
			untyped countByValue[cast value] = count;
		}
		var keys:Array<Dynamic> = untyped __keys__(countByValue);
		for (key in keys)
		{
			var count:Int = untyped countByValue[cast key];
			if (count != 0)
			{
				return "[" + actual + "] getted, but expected [" + expected + "]";
			}
		}
		return null;
	}
}