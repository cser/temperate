package ;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import haxe.Log;
import haxe.PosInfos;
import massive.munit.TestRunner;
import massive.munit.TestSuite;

class CppTestRunner
{	
	static var _tf:TextField;
	
	public static function main():Void
	{
		_tf = new TextField();
		_tf.width = 550;
		_tf.height = 400;
		_tf.x = 200;
		_tf.defaultTextFormat = new TextFormat("Arial", 12);
		_tf.type = TextFieldType.INPUT;
		Lib.current.addChild(_tf);
		
		Log.trace = customTrace;
		
		var client = new CppPrintClient();
		var runner = new TestRunner(client);
		var suites:Array<Class<TestSuite>> = [];
		suites.push(CppMainTestSuite);
		runner.run(suites);
		_tf.text = client.report;
		_tf.scrollV = _tf.maxScrollV;
	}
	
	static function customTrace(v:Dynamic, ?infos:PosInfos):Void
	{
		_tf.appendText(infos.fileName + ":" + infos.lineNumber + ": " + v + "\n");
	}
}	