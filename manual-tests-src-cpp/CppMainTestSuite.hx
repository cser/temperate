package ;
import massive.munit.TestSuite;

class CppMainTestSuite extends TestSuite
{
	public function new() 
	{
		super();
		add(temperate.core.CMathTest);
		add(temperate.collections.CObjectHashTest);
	}
}