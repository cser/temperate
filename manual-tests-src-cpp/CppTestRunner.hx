package ;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import massive.munit.TestRunner;
import massive.munit.TestSuite;

class CppTestRunner
{	
	public static function main():Void
	{
		var tf = new TextField();
		tf.width = 500;
		tf.height = 400;
		tf.x = 200;
		tf.defaultTextFormat = new TextFormat("Arial", 12);
		tf.type = TextFieldType.INPUT;
		Lib.current.addChild(tf);
		var client = new CppPrintClient();
		var runner = new TestRunner(client);
		var suites:Array<Class<TestSuite>> = [];
		suites.push(CppMainTestSuite);
		runner.run(suites);
		tf.text = client.report;
		tf.scrollV = tf.maxScrollV;
		trace("End");
	}
}	