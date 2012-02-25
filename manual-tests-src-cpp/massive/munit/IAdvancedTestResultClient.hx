package massive.munit;

/**
 * Updated Interface which all test result clients should adhere to.
 * <p>
 * A test result client is responsible for interpreting the results of tests as
 * they are executed by a test runner.
 * </p>
 * 
 * @author Dominic De Lorenzo
 * @see TestRunner
 */
interface IAdvancedTestResultClient implements ITestResultClient
{	
	/**
	 * Called before a new test class in run.
	 *
	 * @param	result			a stub test result
	 */
	function setCurrentTestClass(className:String):Void;
}