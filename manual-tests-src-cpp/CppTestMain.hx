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
		var test = new TestNumericStepper();// TODO исправить медленное изменение при зажатии
		var test = new TestSimpleButtonWrapper();// TODO исправить медленное изменение при зажатии, rollOut не отлипает
		var test = new TestMCursorManager();// Падает
		var test = new TestWindowApplication();// Закрывается
		//var test = new TestKey();// Закрывается даже если не вызван init()
		
		var test = new NmeTestCurrent();
		var test = new TestWindows();// Окно не двигается и не закрывается
		Lib.current.addChild(test);
		test.init();
	}
}