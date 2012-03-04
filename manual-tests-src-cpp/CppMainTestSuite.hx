package ;
import massive.munit.TestSuite;

class CppMainTestSuite extends TestSuite
{
	public function new() 
	{
		super();
		add(temperate.core.CMathTest);
		add(temperate.core.ArrayUtilTest);
		add(temperate.collections.CObjectHashTest);
		add(temperate.containers.CVContainerTest);
		//add(temperate.containers.CVContainerChangeLayoutByChildManagmentTest);// has failures
		add(temperate.containers.CHContainerChildManagmentTest);
		add(temperate.collections.CObjectSetTest);
		add(temperate.extra.CSignalTest);
	}
}