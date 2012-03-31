package ;
import massive.munit.AssertionException;
import massive.munit.client.PrintClientBase;

class CppPrintClient extends PrintClientBase
{
	public function new()
	{
		super(true);
		id = "print";
		report = "";
	}
	
	public var report(default, null):String;

	override function init():Void
	{
		super.init();
	}
	
	override function printOverallResult(result:Bool)
	{
		super.printOverallResult(result);
	}
	
	override public function reportFinalStatistics(
		testCount:Int, passCount:Int, failCount:Int, errorCount:Int, ignoreCount:Int,
		time:Float):Dynamic
	{
		return super.reportFinalStatistics(
			testCount, passCount, failCount, errorCount, ignoreCount, time);
	}

	override public function print(value:Dynamic)
	{
		super.print(value);
		report += Std.string(value);
	}

	override public function printLine(value:Dynamic, ?indent:Int = 0)
	{
		super.printLine(value, indent);
	}
}