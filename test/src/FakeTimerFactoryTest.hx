package ;

import flash.events.Event;
import flash.events.TimerEvent;
import massive.munit.Assert;

class FakeTimerFactoryTest
{
	public function new()
	{
	}
	
	var _log:Array<Dynamic>;
	var _factory:FakeTimerFactory;
	
	@Before
	public function setUp():Void
	{
		_log = [];
		_factory = new FakeTimerFactory();
	}
	
	@Test
	public function oneTimerEventDispatching()
	{
		var timer = _factory.newTimer(10, 1);
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		timer.start();
		
		ArrayAssert.areEqual([], _log);
		_factory.currentTime = 9;
		ArrayAssert.areEqual([], _log);
		_factory.currentTime = 10;
		ArrayAssert.areEqual([timer], _log);
		
		_log = [];
		
		_factory.currentTime = 11;
		ArrayAssert.areEqual([], _log);
		
		_factory.currentTime = 21;
		ArrayAssert.areEqual([], _log);
	}
	
	@Test
	public function severalTimesDispatching()
	{
		var timer = _factory.newTimer(10, 3);
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		timer.start();
		
		ArrayAssert.areEqual([], _log);
		_factory.currentTime = 9;
		ArrayAssert.areEqual([], _log);
		_factory.currentTime = 10;
		ArrayAssert.areEqual([timer], _log);
		_factory.currentTime = 19;
		ArrayAssert.areEqual([timer], _log);
		_factory.currentTime = 20;
		ArrayAssert.areEqual([timer, timer], _log);
		_factory.currentTime = 21;
		ArrayAssert.areEqual([timer, timer], _log);
		_factory.currentTime = 30;
		ArrayAssert.areEqual([timer, timer, timer], _log);
		_factory.currentTime = 35;
		ArrayAssert.areEqual([timer, timer, timer], _log);
		_factory.currentTime = 40;
		ArrayAssert.areEqual([timer, timer, timer], _log);
		_factory.currentTime = 41;
		ArrayAssert.areEqual([timer, timer, timer], _log);
		_factory.currentTime = 50;
		ArrayAssert.areEqual([timer, timer, timer], _log);
	}
	
	@Test
	public function infinityRepeatCount()
	{
		var timer = _factory.newTimer(10, 0);
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		timer.start();
		
		ArrayAssert.areEqual([], _log);
		_factory.currentTime = 9;
		ArrayAssert.areEqual([], _log);
		_factory.currentTime = 10;
		ArrayAssert.areEqual([timer], _log);
		_factory.currentTime = 19;
		ArrayAssert.areEqual([timer], _log);
		_factory.currentTime = 20;
		ArrayAssert.areEqual([timer, timer], _log);
		_factory.currentTime = 21;
		ArrayAssert.areEqual([timer, timer], _log);
		_factory.currentTime = 30;
		ArrayAssert.areEqual([timer, timer, timer], _log);
		_factory.currentTime = 35;
		ArrayAssert.areEqual([timer, timer, timer], _log);
		_factory.currentTime = 40;
		ArrayAssert.areEqual([timer, timer, timer, timer], _log);
		_factory.currentTime = 41;
		ArrayAssert.areEqual([timer, timer, timer, timer], _log);
		_factory.currentTime = 50;
		ArrayAssert.areEqual([timer, timer, timer, timer, timer], _log);
	}
	
	@Test
	public function stop()
	{
		var timer = _factory.newTimer(10, 3);
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		timer.start();
		
		ArrayAssert.areEqual([], _log);
		_factory.currentTime = 9;
		ArrayAssert.areEqual([], _log);
		_factory.currentTime = 10;
		ArrayAssert.areEqual([timer], _log);
		
		timer.stop();
		_factory.currentTime = 19;
		ArrayAssert.areEqual([timer], _log);
		_factory.currentTime = 20;
		ArrayAssert.areEqual([timer], _log);
		_factory.currentTime = 21;
		ArrayAssert.areEqual([timer], _log);
		_factory.currentTime = 30;
		ArrayAssert.areEqual([timer], _log);
		
		timer.start();
		_factory.currentTime = 30 + 9;
		ArrayAssert.areEqual([timer], _log);
		_factory.currentTime = 30 + 10;
		ArrayAssert.areEqual([timer, timer], _log);
		_factory.currentTime = 30 + 20;
		ArrayAssert.areEqual([timer, timer, timer], _log);
		
		_factory.currentTime = 30 + 31;
		ArrayAssert.areEqual([timer, timer, timer], _log);
	}
	
	@Test
	public function reset()
	{
		var timer = _factory.newTimer(10, 3);
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		timer.start();
		
		ArrayAssert.areEqual([], _log);
		_factory.currentTime = 9;
		ArrayAssert.areEqual([], _log);
		_factory.currentTime = 10;
		ArrayAssert.areEqual([timer], _log);
		
		timer.reset();
		_factory.currentTime = 19;
		ArrayAssert.areEqual([timer], _log);
		_factory.currentTime = 20;
		ArrayAssert.areEqual([timer], _log);
		_factory.currentTime = 21;
		ArrayAssert.areEqual([timer], _log);
		_factory.currentTime = 30;
		ArrayAssert.areEqual([timer], _log);
		
		
		timer.start();
		_factory.currentTime = 30 + 9;
		ArrayAssert.areEqual([timer], _log);
		_factory.currentTime = 30 + 10;
		ArrayAssert.areEqual([timer, timer], _log);
		_factory.currentTime = 30 + 20;
		ArrayAssert.areEqual([timer, timer, timer], _log);
		_factory.currentTime = 30 + 31;
		ArrayAssert.areEqual([timer, timer, timer, timer], _log);
		
		_factory.currentTime = 30 + 41;
		ArrayAssert.areEqual([timer, timer, timer, timer], _log);
	}
	
	function onTimer(event:Event)
	{
		_log.push(event.target);
	}
}