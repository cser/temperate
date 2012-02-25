package signals;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.Lib;
import temperate.containers.CVBox;
import temperate.minimal.charts.MBarChart;
import temperate.minimal.MLabel;
import temperate.extra.CSignal;

class TestSignalPerformance extends Sprite
{
	static var DEFAULT_NUM_ITERATIONS = 1000;
	
	public function new() 
	{
		super();
	}
	
	var _main:CVBox;
	var _tests:Array<SignalPerformanceTest>;
	
	public function init()
	{
		_main = new CVBox();
		addChild(_main);
		
		_main.add(new MLabel().setText("Signal:"));
		
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
		processTests();
		
		_main.add(new MLabel().setText("Test signal:"));
		
		_tests = [];
		addTest("empty", DEFAULT_NUM_ITERATIONS, null, doNothing);
		addTest(
			"add and remove\none listener",
			DEFAULT_NUM_ITERATIONS,
			test_addAndRemoveOneListener_init,
			test_addAndRemoveOneListener_execute);
		addTest(
			"instantination",
			DEFAULT_NUM_ITERATIONS,
			null,
			test_instantination_execute);
		addTest(
			"dispatching to one",
			DEFAULT_NUM_ITERATIONS,
			test_dispatchingToOne_init,
			test_dispatchingToOne_execute);
		addTest(
			"add and remove\n3 listeners",
			DEFAULT_NUM_ITERATIONS,
			test_addAndRemove3Listeners_init,
			test_addAndRemove3Listeners_execute);
		addTest(
			"dispatching to 3",
			DEFAULT_NUM_ITERATIONS,
			test_dispatchingTo3_init,
			test_dispatchingTo3_execute);
		addTest(
			"add and remove\n20 listeners",
			DEFAULT_NUM_ITERATIONS,
			test_addAndRemove20Listeners_init,
			test_addAndRemove20Listeners_execute);
		addTest(
			"dispatching to 20",
			DEFAULT_NUM_ITERATIONS,
			test_dispatchingTo20_init,
			test_dispatchingTo20_execute);
		processTests();
		
		_main.add(new MLabel().setText("EventDispatcher:"));
		
		_tests = [];
		addTest(
			"add and remove 3\nlisteners from\nEventDispatcher",
			DEFAULT_NUM_ITERATIONS,
			eventDispatcherAddAndRemove3_init,
			eventDispatcherAddAndRemove3_execute);
		addTest(
			"dispatch\nEventDispatcher\nto 3",
			DEFAULT_NUM_ITERATIONS,
			eventDispatcherDispatch3_init,
			eventDispatcherDispatch3_execute);
		processTests();
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
	
	function processTests()
	{
		var chart = new MBarChart();
		chart.showValueLabels = true;
		chart.includedValue = 0;
		chart.width = 800;
		chart.showBoundLabels = true;
		chart.autoScale = false;
		chart.maxValue = 400;
		chart.minValue = 0;
		
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
		_main.add(chart);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Signal
	//
	//----------------------------------------------------------------------------------------------
	
	var _signal:CSignal < Void->Void > ;
	
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
	//  Test signal
	//
	//----------------------------------------------------------------------------------------------
	
	var _testSignal:PerformanceTestSignal<Void->Void>;
	
	function test_addAndRemoveOneListener_init()
	{
		_testSignal = new PerformanceTestSignal();
	}
	
	function test_addAndRemoveOneListener_execute()
	{
		_testSignal.add(doNothing);
		_testSignal.remove(doNothing);
	}
	
	function test_instantination_execute()
	{
		new PerformanceTestSignal();
	}
	
	function test_dispatchingToOne_init()
	{
		_testSignal = new PerformanceTestSignal();
		_testSignal.add(doNothing);
	}
	
	function test_dispatchingToOne_execute()
	{
		_testSignal.dispatch();
	}
	
	function test_addAndRemove3Listeners_init()
	{
		_testSignal = new PerformanceTestSignal();
	}
	
	function test_addAndRemove3Listeners_execute()
	{
		_testSignal.add(listener1);
		_testSignal.add(listener2);
		_testSignal.add(listener3);
		_testSignal.remove(listener1);
		_testSignal.remove(listener2);
		_testSignal.remove(listener3);
	}
	
	function test_dispatchingTo3_init()
	{
		_testSignal = new PerformanceTestSignal();
		_testSignal.add(listener1);
		_testSignal.add(listener2);
		_testSignal.add(listener3);
	}
	
	function test_dispatchingTo3_execute()
	{
		_testSignal.dispatch();
	}
	
	function test_addAndRemove20Listeners_init()
	{
		_testSignal = new PerformanceTestSignal();
	}
	
	function test_addAndRemove20Listeners_execute()
	{
		_testSignal.add(listener1);
		_testSignal.add(listener2);
		_testSignal.add(listener3);
		_testSignal.add(listener4);
		_testSignal.add(listener5);
		_testSignal.add(listener6);
		_testSignal.add(listener7);
		_testSignal.add(listener8);
		_testSignal.add(listener9);
		_testSignal.add(listener10);
		_testSignal.add(listener11);
		_testSignal.add(listener12);
		_testSignal.add(listener13);
		_testSignal.add(listener14);
		_testSignal.add(listener15);
		_testSignal.add(listener16);
		_testSignal.add(listener17);
		_testSignal.add(listener18);
		_testSignal.add(listener19);
		_testSignal.add(listener20);
		
		_testSignal.remove(listener1);
		_testSignal.remove(listener2);
		_testSignal.remove(listener3);
		_testSignal.remove(listener4);
		_testSignal.remove(listener5);
		_testSignal.remove(listener6);
		_testSignal.remove(listener7);
		_testSignal.remove(listener8);
		_testSignal.remove(listener9);
		_testSignal.remove(listener10);
		_testSignal.remove(listener11);
		_testSignal.remove(listener12);
		_testSignal.remove(listener13);
		_testSignal.remove(listener14);
		_testSignal.remove(listener15);
		_testSignal.remove(listener16);
		_testSignal.remove(listener17);
		_testSignal.remove(listener18);
		_testSignal.remove(listener19);
		_testSignal.remove(listener20);
	}
	
	function test_dispatchingTo20_init()
	{
		_testSignal = new PerformanceTestSignal();
		_testSignal.add(listener1);
		_testSignal.add(listener2);
		_testSignal.add(listener3);
		_testSignal.add(listener4);
		_testSignal.add(listener5);
		_testSignal.add(listener6);
		_testSignal.add(listener7);
		_testSignal.add(listener8);
		_testSignal.add(listener9);
		_testSignal.add(listener10);
		_testSignal.add(listener11);
		_testSignal.add(listener12);
		_testSignal.add(listener13);
		_testSignal.add(listener14);
		_testSignal.add(listener15);
		_testSignal.add(listener16);
		_testSignal.add(listener17);
		_testSignal.add(listener18);
		_testSignal.add(listener19);
		_testSignal.add(listener20);
	}
	
	function test_dispatchingTo20_execute()
	{
		_testSignal.dispatch();
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  EventDispatcher
	//
	//----------------------------------------------------------------------------------------------
	
	var _dispatcher:EventDispatcher;
	
	function eventDispatcherAddAndRemove3_init()
	{
		_dispatcher = new EventDispatcher();
	}
	
	function eventDispatcherAddAndRemove3_execute()
	{
		_dispatcher.addEventListener(Event.CHANGE, onChange1);
		_dispatcher.addEventListener(Event.CHANGE, onChange2);
		_dispatcher.addEventListener(Event.CHANGE, onChange3);
		_dispatcher.removeEventListener(Event.CHANGE, onChange1);
		_dispatcher.removeEventListener(Event.CHANGE, onChange2);
		_dispatcher.removeEventListener(Event.CHANGE, onChange3);
	}
	
	var _event:Event;
	
	function eventDispatcherDispatch3_init()
	{
		_dispatcher = new EventDispatcher();
		_dispatcher.addEventListener(Event.CHANGE, onChange1);
		_dispatcher.addEventListener(Event.CHANGE, onChange2);
		_dispatcher.addEventListener(Event.CHANGE, onChange3);
		_event = new Event(Event.CHANGE);
	}
	
	function eventDispatcherDispatch3_execute()
	{
		_dispatcher.dispatchEvent(_event);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
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
	
	function onChange1(event:Event) { }
	function onChange2(event:Event) { }
	function onChange3(event:Event) { }
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