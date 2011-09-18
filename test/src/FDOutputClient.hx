package ;
import flash.errors.Error;
import flash.Lib;
import haxe.PosInfos;
import massive.munit.AssertionException;
import massive.munit.ITestResultClient;
import massive.munit.TestResult;
import massive.munit.util.MathUtil;
import massive.haxe.util.ReflectUtil;

class FDOutputClient implements ITestResultClient
{
	/**
	 * Default id of this client.
	 */
	public static inline var DEFAULT_ID:String = "FD output";

	/**
	 * The unique identifier for the client.
	 */
	public var id(default, null):String;
	
	/**
	 * Handler which if present, is called when the client has completed generating its results.
	 */
	public var completionHandler(get_completeHandler, set_completeHandler):
		ITestResultClient -> Void;
	private function get_completeHandler():ITestResultClient -> Void 
	{
		return completionHandler;
	}
	private function set_completeHandler(value:ITestResultClient -> Void):ITestResultClient -> Void
	{
		return completionHandler = value;
	}
	
	/**
	 * Newline delimiter. Defaults to '\n' for all platforms except 'js' where it defaults to
	 * '<br/>'.
	 * 
	 * <p>
	 * Should be set before the client is passed to a test runner.
	 * </p>
	 */
	public var newline:String;
	
	private var failures:String;
	private var errors:String;
	private var ignored:String;
	private var output:String;
	private var currentTestClass:String;
	private var originalTrace:Dynamic;

	/**
	 * Class constructor.
	 */
	public function new()
	{
		id = DEFAULT_ID;
		init();
		print("MUnit Results" + newline);
		print("------------------------------" + newline);
	}
	
	function processComplete()
	{
		#if flash
		Lib.fscommand("quit");
		#end
	}
	
	private function init():Void
	{
		originalTrace = haxe.Log.trace;
		haxe.Log.trace = customTrace;
		output = "";
		failures = "";
		errors = "";
		ignored = "";
		currentTestClass = "";
		newline = "\n";
		
		#if flash
		newline = "";
		#end

		#if js
			textArea = js.Lib.document.getElementById("haxe:trace");
			if (textArea == null) 
			{
				var positionInfo = ReflectUtil.here();
				var error:String = "MissingElementException: 'haxe:trace' element not found at " +
					positionInfo.className + "#" + positionInfo.methodName +
					"(" + positionInfo.lineNumber + ")";
				js.Lib.alert(error);
			}
		#end
	}
	
	/**
	 * Called when a test passes.
	 *  
	 * @param	result			a passed test result
	 */
	public function addPass(result:TestResult):Void
	{
		checkForNewTestClass(result);
		print(".");
	}
	
	/**
	 * Called when a test fails.
	 *  
	 * @param	result			a failed test result
	 */
	public function addFail(result:TestResult):Void
	{
		checkForNewTestClass(result);
		failures += newline + result.failure;
		
		var info:PosInfos = result.failure.info;
		var lineNumber = info != null ? info.lineNumber : 0;
		print("test/src/" + result.className.split(".").join("/") + ".hx" + ":" +  lineNumber +
			":" + result.failure);
	}
	
	/**
	 * Called when a test has been ignored.
	 *
	 * @param	result			an ignored test
	 */
	public function addIgnore(result:TestResult):Void
	{
		checkForNewTestClass(result);
		print(",");
		ignored += "\ntest/src/" + result.className.split(".").join("/") + ".hx" +
			":0:Ignored: " + result.location + " - " + result.description;
	}
	
	/**
	 * Called when a test triggers an unexpected exception.
	 *  
	 * @param	result			an erroneous test result
	 */
	public function addError(result:TestResult):Void
	{
		checkForNewTestClass(result);
		errors += newline + "3:" + result.error;
	}
	
	/**
	 * Called when all tests are complete.
	 *  
	 * @param	testCount		total number of tests run
	 * @param	passCount		total number of tests which passed
	 * @param	failCount		total number of tests which failed
	 * @param	errorCount		total number of tests which were erroneous
	 * @param	time			number of milliseconds taken for all tests to be executed
	 * @return	collated test result data
	 */
	public function reportFinalStatistics(
		testCount:Int, passCount:Int, failCount:Int, errorCount:Int, ignoreCount:Int, time:Float
	):Dynamic
	{
		printExceptions();
		
		if (ignoreCount > 0)
		{
			print("------------------------------");
			print("Ignored tests:" + ignored);
			print("------------------------------");
		}
		else
		{
			print(newline + newline);
		}
		
		print((passCount == testCount) ? "PASSED" : "3:FAILED");
		
		var text = newline + "Tests: " + testCount + "  Passed: " + passCount + "  Failed: " +
			failCount + " Errors: " + errorCount + " Time: " + MathUtil.round(time, 5) + newline;
		if (ignoreCount > 0)
		{
			text += " |  Ignored: " + ignoreCount;
		}
		
		print(text);
		print("==============================" + newline);
		
		haxe.Log.trace = originalTrace;
		if (completionHandler != null) completionHandler(this); 
		processComplete();
		return output;
	}
	
	private function checkForNewTestClass(result:TestResult):Void
	{
		if (result.className != currentTestClass)
		{
			printExceptions();
			currentTestClass = result.className;
			print(newline + "Class: " + currentTestClass + " ");
		}
	}
	
	// We print exceptions captured (failures or errors) after all tests 
	// have completed for a test class.
	private function printExceptions():Void
	{
		if (errors != "") 
		{
			print(errors + newline);
			errors = "";
		}
		if (failures != "")
		{
			print(failures + newline);
			failures = "";
		}
	}
	
	private function print(value:Dynamic):Void
	{
		#if flash
			flash.Lib.trace(value);
		#elseif js
			value = untyped js.Boot.__string_rec(value, "");
			var v:String = StringTools.htmlEscape(value);
			v = v.split(newline).join("<br/>");
			if (textArea != null) textArea.innerHTML += v;
		#elseif neko
			neko.Lib.print(value);
		#elseif cpp
			cpp.Lib.print(value);
		#elseif php
			php.Lib.print(value);
		#end
		
		output += value;
	}

	private function customTrace(value, ?info:haxe.PosInfos)
	{
		print("test/src/" + info.className.split(".").join("/") + ".hx:" + info.lineNumber + ": " +
			value + newline);
	}
	
	public static function parseStackTrace(text:String):Array<String>
	{
		var result = [];
		var index = 0;
		while (true)
		{
			var braIndex = text.indexOf("[", index);
			if (braIndex == -1)
			{
				break;
			}
			var methodName = text.substr(index, braIndex - index);
			var spaceIndex = methodName.lastIndexOf(" ");
			if (spaceIndex != -1)
			{
				methodName = methodName.substr(spaceIndex + 1);
			}
			var ketIndex = text.indexOf("]", braIndex);
			if (ketIndex == -1)
			{
				break;
			}
			result.push(text.substr(braIndex + 1, ketIndex - braIndex - 1) + ":" + methodName);
			index = ketIndex + 1;
		}
		return result;
	}
}