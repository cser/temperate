package ;

import massive.munit.TestRunner;
import massive.munit.TestSuite;
import massive.munit.ITestResultClient;

class MUnitMain extends TestRunner
{
	public function new(resultClient:ITestResultClient)
	{
		super(resultClient);
		isDebug = false;
	}
	
	static function main()
	{
		var runner = new MUnitMain(new FDOutputClient());
		var suites:Array<Class<TestSuite>> = [];
		suites.push(MainTestSuite);
		runner.run(suites);
	}
}