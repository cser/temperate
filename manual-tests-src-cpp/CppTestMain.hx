package ;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import minimal.TestMBdFactory;
import minimal.TestMButton;
import minimal.TestMCharts;
import minimal.TestMCheckBox;
import minimal.TestMTooltips;
import minimal.TestMTween;
import signals.TestSignalPerformance;

class CppTestMain
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
		
		var test = new TestDebugMonitor();
		var test = new TestMButton();
		var test = new TestFrameEvent();
		var test = new TestContainer();
		var test = new TestContainerSpace();
		var test = new TestRecursiveContainer();
		var test = new TestMCheckBox();
		var test = new TestMCharts();
		var test = new TestMTween();
		var test = new TestTooltipsOld();
		var test = new TestMTooltips();
		var test = new TestMBdFactory();
		var test = new TestText();
		var test = new TestValidationBug();
		var test = new TestCursorManager();
		var test = new TestSignalPerformance();
		var test = new TestTooltips();
		var test = new TestScrollBar();
		var test = new TestSlider();
		var test = new TestScrollPane();
		var test = new TestTextArea();
		var test = new TestRasterImageButton();
		var test = new TestMCursorManager();
		var test = new TestKey();
		var test = new TestWindows();
		var test = new TestNumericStepper();
		var test = new TestSimpleButtonWrapper();
		
		var test = new NmeTestCurrent();
		var test = new TestMouseEvents();
		var test = new TestWindowApplication();
		Lib.current.addChild(test);
		test.init();
	}
}