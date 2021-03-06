/****
* Copyright 2011 Massive Interactive. All rights reserved.
* 
* Redistribution and use in source and binary forms, with or without modification, are
* permitted provided that the following conditions are met:
* 
*    1. Redistributions of source code must retain the above copyright notice, this list of
*       conditions and the following disclaimer.
* 
*    2. Redistributions in binary form must reproduce the above copyright notice, this list
*       of conditions and the following disclaimer in the documentation and/or other materials
*       provided with the distribution.
* 
* THIS SOFTWARE IS PROVIDED BY MASSIVE INTERACTIVE ``AS IS'' AND ANY EXPRESS OR IMPLIED
* WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
* FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL MASSIVE INTERACTIVE OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
* ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
* ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* 
* The views and conclusions contained in the software and documentation are those of the
* authors and should not be interpreted as representing official policies, either expressed
* or implied, of Massive Interactive.
****/

package massive.munit.client;
import massive.munit.client.PrintClientBase;
import massive.munit.AssertionException;
import massive.munit.ITestResultClient;
import massive.munit.TestResult;
import massive.haxe.util.ReflectUtil;
import massive.munit.util.Timer;

/**
 * Generates basic text formatted test result output.
 * 
 * <p>
 * Example output:
 * </p>
 * <pre>
 * MUnit Results
 * ------------------------------
 * 
 * Class: SampleTest ...
 * Class: sub.ItemTest ..
 * 
 * PASSED
 * Tests: 5  Passed: 5  Failed: 0 Errors: 0 Ignored: 0 Time: 0.202
 * ==============================
 * </pre>
 * 
 * @author Mike Stead
 */
class PrintClient extends PrintClientBase
{

	/**
	 * Default id of this client.
	 */
	public static inline var DEFAULT_ID:String = "print";

	#if (js||flash)
		var external:ExternalPrintClient;
		#if flash9
			var textField:flash.text.TextField;
		#elseif flash
			var textField:flash.TextField;
		#elseif js
			var textArea:Dynamic;
		#end
	#end 
	
	public function new(?includeIgnoredReport:Bool = true)
	{
		super(includeIgnoredReport);
		id = DEFAULT_ID;
	}

	override function init():Void
	{
		super.init();
		
		#if (js || flash)
			external = new ExternalPrintClientJS();
			#if flash
				initFlash();
			#elseif js
				initJS();
			#end
		#end
	}

	#if flash
	function initFlash()
	{
		if(!flash.external.ExternalInterface.available)
		{
			throw new MUnitException("ExternalInterface not available");
		}
		
		#if flash9
			textField = new flash.text.TextField();
			textField.selectable = true;
			textField.width = flash.Lib.current.stage.stageWidth;
			textField.height = flash.Lib.current.stage.stageHeight;
			flash.Lib.current.addChild(textField);
		#elseif flash
			textField = flash.Lib.current.createTextField("__munitOutput", 20000, 0, 0, flash.Stage.width, flash.Stage.height);
			textField.wordWrap = true;
			textField.selectable = true;
		#end
	}
	#elseif js
	function initJS()
	{
		var div = js.Lib.document.getElementById("haxe:trace");
		
		if (div == null) 
		{
			var positionInfo = ReflectUtil.here();
			var error:String = "MissingElementException: 'haxe:trace' element not found at " + positionInfo.className + "#" + positionInfo.methodName + "(" + positionInfo.lineNumber + ")";
			js.Lib.alert(error);
		}	
	}
	#end


	////// TEST CLASS LIFECYCLE //////
	override function printOverallResult(result:Bool)
	{
		super.printOverallResult(result);

		#if (js || flash)
			external.setResult(result);
			external.setResultBackground(result);
		#end
	}
	
	////// PRINT APIS //////

	override public function reportFinalStatistics(testCount:Int, passCount:Int, failCount:Int, errorCount:Int, ignoreCount:Int, time:Float):Dynamic
	{
		return super.reportFinalStatistics(testCount, passCount, failCount, errorCount, ignoreCount, time);
	}

	override public function print(value:Dynamic)
	{
		super.print(value);

		#if flash9
			textField.appendText(value);
			textField.scrollV = textField.maxScrollV;
		#elseif flash
			value = untyped flash.Boot.__string_rec(value, "");
			textField.text += value;
			textField.scroll = textField.maxscroll;
		#end

		#if (js || flash)
			external.print(value);
		#elseif neko
			neko.Lib.print(value);
		#elseif cpp
			cpp.Lib.print(value);
		#elseif php
			php.Lib.print(value);
		#end
	}

	override public function printLine(value, ?indent:Int = 0)
	{
		super.printLine(value, indent);
	}

}