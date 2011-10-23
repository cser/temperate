package ;

import massive.munit.TestSuite;

class MainTestSuite extends TestSuite
{
	public function new()
	{
		super();
		add(oldStyleCalculator.ControllerTest);
	}
}