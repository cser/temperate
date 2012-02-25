package ;
import massive.munit.Assert;
import massive.munit.client.PrintClient;
import massive.munit.TestRunner;
import massive.munit.TestSuite;
//import massive.munit.client.PrintClient;
//import massive.munit.TestRunner;

class CppTestRunner
{	
	public static function run():Void
	{
		CppMainTestSuite;
		var runner = new TestRunner(new PrintClient());
		var suites:Array<Class<TestSuite>> = [];
		suites.push(CppMainTestSuite);
		runner.run(suites);
	}
}	