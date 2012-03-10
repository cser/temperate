package ;
import massive.munit.client.PrintClient;
import massive.munit.TestRunner;
import massive.munit.TestSuite;

class CppTestRunner
{	
	public static function main():Void
	{
		CppMainTestSuite;
		var runner = new TestRunner(new PrintClient());
		var suites:Array<Class<TestSuite>> = [];
		suites.push(CppMainTestSuite);
		runner.run(suites);
	}
}	