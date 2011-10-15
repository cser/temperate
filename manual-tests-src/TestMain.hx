package ;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import haxe.Log;
import haxe.PosInfos;
import minimal.TestMButton;
import minimal.TestMCharts;
import minimal.TestMCheckBox;
import minimal.TestMTooltips;
import minimal.TestMTween;
import signals.TestSignalPerformance;

class TestMain
{
	static function main()
	{
		var stage = Lib.current.stage;
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		Log.trace = trace;
		
		/*
		Only one test runs at one time.
		But at least _all_ tests compilationable checked on any test run
		*/
		var test = new TestDebugMonitor();
		var test = new TestMButton();
		var test = new TestFrameEvent();
		var test = new TestContainer();
		var test = new TestContainerSpace();		
		var test = new TestRecursiveContainer();
		var test = new TestMCheckBox();
		var test = new TestTooltipsOld();
		var test = new TestMTooltips();
		var test = new TestNumericStepper();
		var test = new TestCursorManager();
		var test = new TestMCursorManager();
		var test = new TestMCharts();
		var test = new TestText();
		var test = new TestMTween();
		
		var test = new TestScrollBar();
		var test = new TestTextArea();
		var test = new TestSlider();
		var test = new TestSimpleButtonWrapper();
		
		var test = new TestScrollPane();
		var test = new TestSignalPerformance();var test = new TestTooltips();
		Lib.current.addChild(test);
		test.init();
	}
	
	public static function trace( v : Dynamic, ?infos : PosInfos )
	{
		Lib.trace(
			"src/" + ~/\./g.replace(infos.className, "/") + ".hx:" + infos.lineNumber + ": " + v);
	}
}