package ;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;

class CppTestMainNmml
{
	public static function main()
	{
		var stage = Lib.current.stage;
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		
		/*
		Only one test runs at one time.
		But at least _all_ tests compilationable checked on any test run
		*/
		var test = new NmeTestText();
		Lib.current.addChild(test);
		test.init();
	}
}