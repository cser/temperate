package ;
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
}