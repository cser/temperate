package ;
import flash.utils.Dictionary;
import haxe.PosInfos;
import massive.munit.Assert;

class ArrayAssert 
{
	public static function equalToArray(
		expected:Array<Dynamic>, actual:Array<Dynamic>, ?info:PosInfos)
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
	
	public static function equalToArrayIgnoringOrder(
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
		var countByValue = new flash.utils.TypedDictionary<Dynamic, Int>();
		for (value in actual)
		{
			var count:Int = countByValue.get(value);
			count++;
			countByValue.set(value, count);
		}
		
		for (value in expected)
		{
			var count:Int = countByValue.get(value);
			count--;
			countByValue.set(value, count);
		}
		
		for (key in countByValue.keys())
		{
			var count:Int = countByValue.get(key);
			if (count != 0)
			{
				return "[" + actual + "] getted, but expected [" + expected + "]";
			}
		}
		return null;
	}
}