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

class TestMain
{
	static function main()
	{
		var stage = Lib.current.stage;
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		Log.trace = trace;
		
		var test = new TestDebugMonitor();
		var test = new TestMButton();
		var test = new TestFrameEvent();
		var test = new TestContainer();
		var test = new TestContainerSpace();		
		var test = new TestRecursiveContainer();
		var test = new TestMCheckBox();
		var test = new TestTooltipsOld();
		var test = new TestMTooltips();
		
		var test = new TestCursorManager();
		var test = new TestMCursorManager();
		var test = new TestMCharts();
		var test = new TestText();
		var test = new TestMTween();
		var test = new TestTooltips();
		
		var test = new TestScrollBar();var test = new TestNumericStepper();
		Lib.current.addChild(test);
		test.init();
	}
	
	public static function trace( v : Dynamic, ?infos : PosInfos )
	{
		Lib.trace(infos.className + ": " + v);
	}
}