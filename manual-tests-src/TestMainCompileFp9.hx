package ;
import minimal.TestMButton;
import minimal.TestMCharts;
import minimal.TestMCheckBox;
import minimal.TestMTooltips;
import minimal.TestMTween;
import signals.TestSignalPerformance;
import temperate.cursors.CCursorManager;
import temperate.minimal.MCursorManager;

class TestMainCompileFp9 
{
	public static function main()
	{
		var test = new TestDebugMonitor();
		var test = new TestMButton();
		var test = new TestContainer();
		var test = new TestContainerSpace();		
		var test = new TestRecursiveContainer();
		var test = new TestMCheckBox();
		var test = new TestTooltipsOld();
		var test = new TestMTooltips();
		var test = new TestNumericStepper();
		var test = new TestMCharts();
		var test = new TestText();
		var test = new TestMTween();
		var test = new TestTooltips();
		var test = new TestScrollBar();
		var test = new TestTextArea();
		var test = new TestSlider();
		var test = new TestSimpleButtonWrapper();
		
		var test = new TestScrollPane();
		var test = new TestSignalPerformance();
		
		var classes = [CCursorManager, MCursorManager];
	}
}