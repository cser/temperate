package signals;
import flash.display.Sprite;
import flash.Lib;
import temperate.containers.CVBox;
import temperate.minimal.charts.MBarChart;
import temperate.minimal.charts.MLineChart;
import temperate.signals.CSignal;

class TestSignalPerformance extends Sprite
{
	static var DEFAULT_NUM_ITERATIONS = 1000;
	
	public function new() 
	{
		super();
	}
	
	var _tests:Array<SignalPerformanceTest>;
	
	public function init()
	{
		var main = new CVBox().addTo(this);
		var chart = new MBarChart();
		chart.showValueLabels = true;
		chart.includedValue = 0;
		chart.width = 800;
		chart.showBoundLabels = true;
		main.add(chart);
		
		_tests = [];
		addTest("empty", DEFAULT_NUM_ITERATIONS, null, doNothing);
		addTest(
			"add and remove\none listener",
			DEFAULT_NUM_ITERATIONS,
			addAndRemoveOneListener_init,
			addAndRemoveOneListener_execute);
		addTest(
			"instantination",
			DEFAULT_NUM_ITERATIONS,
			null,
			instantination_execute);
		addTest(
			"dispatching to one",
			DEFAULT_NUM_ITERATIONS,
			dispatchingToOne_init,
			dispatchingToOne_execute);
		addTest(
			"add and remove\n3 listeners",
			DEFAULT_NUM_ITERATIONS,
			addAndRemove3Listeners_init,
			addAndRemove3Listeners_execute);
		addTest(
			"dispatching to 3",
			DEFAULT_NUM_ITERATIONS,
			dispatchingTo3_init,
			dispatchingTo3_execute);
		addTest(
			"add and remove\n20 listeners",
			DEFAULT_NUM_ITERATIONS,
			addAndRemove20Listeners_init,
			addAndRemove20Listeners_execute);
		addTest(
			"dispatching to 20",
			DEFAULT_NUM_ITERATIONS,
			dispatchingTo20_init,
			dispatchingTo20_execute);
		
		var values:Array<Float> = [];
		var labels:Array<String> = [];
		
		for (test in _tests)
		{
			if (test.init != null)
			{
				test.init();
			}
			var firstTime = Lib.getTimer();
			for (i in 0 ... test.numIterations)
			{
				test.execute();
			}
			var time = Std.int(((Lib.getTimer() - firstTime) / test.numIterations) * 1000);
			
			values.push(time);
			labels.push(test.name + "\n" + time + "mcs");
		}
		
		chart.values = values;
		chart.labels = labels;
	}
	
	function addTest(name:String, numIterations:Int, init:Void->Void, execute:Void->Void)
	{
		var test = new SignalPerformanceTest();
		test.name = name;
		test.numIterations = numIterations;
		test.init = init;
		test.execute = execute;
		_tests.push(test);
	}
	
	function addAndRemoveOneListener_init()
	{
		_signal = new CSignal();
	}
	
	function addAndRemoveOneListener_execute()
	{
		_signal.add(doNothing);
		_signal.remove(doNothing);
	}
	
	function instantination_execute()
	{
		new CSignal();
	}
	
	function dispatchingToOne_init()
	{
		_signal = new CSignal();
		_signal.add(doNothing);
	}
	
	function dispatchingToOne_execute()
	{
		_signal.dispatch();
	}
	
	function addAndRemove3Listeners_init()
	{
		_signal = new CSignal();
	}
	
	function addAndRemove3Listeners_execute()
	{
		_signal.add(listener1);
		_signal.add(listener2);
		_signal.add(listener3);
		_signal.remove(listener1);
		_signal.remove(listener2);
		_signal.remove(listener3);
	}
	
	function dispatchingTo3_init()
	{
		_signal = new CSignal();
		_signal.add(listener1);
		_signal.add(listener2);
		_signal.add(listener3);
	}
	
	function dispatchingTo3_execute()
	{
		_signal.dispatch();
	}
	
	function addAndRemove20Listeners_init()
	{
		_signal = new CSignal();
	}
	
	function addAndRemove20Listeners_execute()
	{
		_signal.add(listener1);
		_signal.add(listener2);
		_signal.add(listener3);
		_signal.add(listener4);
		_signal.add(listener5);
		_signal.add(listener6);
		_signal.add(listener7);
		_signal.add(listener8);
		_signal.add(listener9);
		_signal.add(listener10);
		_signal.add(listener11);
		_signal.add(listener12);
		_signal.add(listener13);
		_signal.add(listener14);
		_signal.add(listener15);
		_signal.add(listener16);
		_signal.add(listener17);
		_signal.add(listener18);
		_signal.add(listener19);
		_signal.add(listener20);
		
		_signal.remove(listener1);
		_signal.remove(listener2);
		_signal.remove(listener3);
		_signal.remove(listener4);
		_signal.remove(listener5);
		_signal.remove(listener6);
		_signal.remove(listener7);
		_signal.remove(listener8);
		_signal.remove(listener9);
		_signal.remove(listener10);
		_signal.remove(listener11);
		_signal.remove(listener12);
		_signal.remove(listener13);
		_signal.remove(listener14);
		_signal.remove(listener15);
		_signal.remove(listener16);
		_signal.remove(listener17);
		_signal.remove(listener18);
		_signal.remove(listener19);
		_signal.remove(listener20);
	}
	
	function dispatchingTo20_init()
	{
		_signal = new CSignal();
		_signal.add(listener1);
		_signal.add(listener2);
		_signal.add(listener3);
		_signal.add(listener4);
		_signal.add(listener5);
		_signal.add(listener6);
		_signal.add(listener7);
		_signal.add(listener8);
		_signal.add(listener9);
		_signal.add(listener10);
		_signal.add(listener11);
		_signal.add(listener12);
		_signal.add(listener13);
		_signal.add(listener14);
		_signal.add(listener15);
		_signal.add(listener16);
		_signal.add(listener17);
		_signal.add(listener18);
		_signal.add(listener19);
		_signal.add(listener20);
	}
	
	function dispatchingTo20_execute()
	{
		_signal.dispatch();
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	var _signal:CSignal < Void->Void > ;
	
	function doNothing()
	{
	}
	
	function listener1() { }
	function listener2() { }
	function listener3() { }
	function listener4() { }
	function listener5() { }
	function listener6() { }
	function listener7() { }
	function listener8() { }
	function listener9() { }
	function listener10() { }
	function listener11() { }
	function listener12() { }
	function listener13() { }
	function listener14() { }
	function listener15() { }
	function listener16() { }
	function listener17() { }
	function listener18() { }
	function listener19() { }
	function listener20() { }
}
class SignalPerformanceTest 
{
	public function new()
	{
	}
	
	public var name:String;
	
	public var numIterations:Int;
	
	public var init:Void->Void;
	
	public var execute:Void->Void;
}