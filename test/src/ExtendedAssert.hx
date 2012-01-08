package ;
import haxe.PosInfos;
import massive.munit.Assert;

class ExtendedAssert 
{
	public static function areUIntEqual(expected:UInt, actual:UInt, ?info:PosInfos)
	{
		Assert.assertionCount++;
		if (actual != expected)
		{
			Assert.fail(
				"Value [" + actual + "] was not equal to expected [" + expected + "]", info);
		}
	}
	
	public static function areEqual(
		expected:Dynamic, actual:Dynamic, ?msg:String, ?info:PosInfos)
	{
		Assert.assertionCount++;
		if (actual != expected)
		{
			Assert.fail(msg + " (expected [" + expected + "], actual [" + actual + "])", info);
		}
	}
}