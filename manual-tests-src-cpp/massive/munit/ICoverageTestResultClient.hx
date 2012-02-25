package massive.munit;

/**
 * Interface for supporting test coverage
 * 
 * @author Dominic De Lorenzo
 * @see TestRunner
 */
interface ICoverageTestResultClient implements IAdvancedTestResultClient
{	
	/**
	 * Called after all tests have completed for current class
	 *
	 * @param	result			missing class coverage covered by tests
	 */
	function setCurrentTestClassCoverage(result:CoverageResult):Void;

	/**
	 * Called after all test classes have finished
	 *
	 * @param	percent					overall coverage percentage
	 * @param	coverageResults			missing coverage results
	 * @param	summary					high level coverage report
	 * @param	classBreakdown			results per class
 	 * @param	packageBreakdown		results per package
	 * @param	executionFrequency		statement/branch frequency	
	 */
	function reportFinalCoverage(percent:Float, missingCoverageResults:Array<CoverageResult>, summary:String,
		?classBreakdown:String=null,
		?packageBreakdown:String=null,
		?executionFrequency:String=null
	):Void;
}