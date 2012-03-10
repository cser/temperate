package ;

import flash.events.Event;
import flash.events.TimerEvent;
import massive.munit.Assert;

class FakeTimerFactoryTest
{
	public function new()
	{
	}
	
	var _log:Array<FakeTimer>;
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
		
		ArrayAssert.equalToArray([], _log);
		_factory.currentTime = 9;
		ArrayAssert.equalToArray([], _log);
		_factory.currentTime = 10;
		ArrayAssert.equalToArray([timer], _log);
		
		_log = [];
		
		_factory.currentTime = 11;
		ArrayAssert.equalToArray([], _log);
		
		_factory.currentTime = 21;
		ArrayAssert.equalToArray([], _log);
	}
	
	@Test
	public function severalTimesDispatching()
	{
		var timer = _factory.newTimer(10, 3);
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		timer.start();
		
		ArrayAssert.equalToArray([], _log);
		_factory.currentTime = 9;
		ArrayAssert.equalToArray([], _log);
		_factory.currentTime = 10;
		ArrayAssert.equalToArray([timer], _log);
		_factory.currentTime = 19;
		ArrayAssert.equalToArray([timer], _log);
		_factory.currentTime = 20;
		ArrayAssert.equalToArray([timer, timer], _log);
		_factory.currentTime = 21;
		ArrayAssert.equalToArray([timer, timer], _log);
		_factory.currentTime = 30;
		ArrayAssert.equalToArray([timer, timer, timer], _log);
		_factory.currentTime = 35;
		ArrayAssert.equalToArray([timer, timer, timer], _log);
		_factory.currentTime = 40;
		ArrayAssert.equalToArray([timer, timer, timer], _log);
		_factory.currentTime = 41;
		ArrayAssert.equalToArray([timer, timer, timer], _log);
		_factory.currentTime = 50;
		ArrayAssert.equalToArray([timer, timer, timer], _log);
	}
	
	@Test
	public function infinityRepeatCount()
	{
		var timer = _factory.newTimer(10, 0);
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		timer.start();
		
		ArrayAssert.equalToArray([], _log);
		_factory.currentTime = 9;
		ArrayAssert.equalToArray([], _log);
		_factory.currentTime = 10;
		ArrayAssert.equalToArray([timer], _log);
		_factory.currentTime = 19;
		ArrayAssert.equalToArray([timer], _log);
		_factory.currentTime = 20;
		ArrayAssert.equalToArray([timer, timer], _log);
		_factory.currentTime = 21;
		ArrayAssert.equalToArray([timer, timer], _log);
		_factory.currentTime = 30;
		ArrayAssert.equalToArray([timer, timer, timer], _log);
		_factory.currentTime = 35;
		ArrayAssert.equalToArray([timer, timer, timer], _log);
		_factory.currentTime = 40;
		ArrayAssert.equalToArray([timer, timer, timer, timer], _log);
		_factory.currentTime = 41;
		ArrayAssert.equalToArray([timer, timer, timer, timer], _log);
		_factory.currentTime = 50;
		ArrayAssert.equalToArray([timer, timer, timer, timer, timer], _log);
	}
	
	@Test
	public function stop()
	{
		var timer = _factory.newTimer(10, 3);
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		timer.start();
		
		ArrayAssert.equalToArray([], _log);
		_factory.currentTime = 9;
		ArrayAssert.equalToArray([], _log);
		_factory.currentTime = 10;
		ArrayAssert.equalToArray([timer], _log);
		
		timer.stop();
		_factory.currentTime = 19;
		ArrayAssert.equalToArray([timer], _log);
		_factory.currentTime = 20;
		ArrayAssert.equalToArray([timer], _log);
		_factory.currentTime = 21;
		ArrayAssert.equalToArray([timer], _log);
		_factory.currentTime = 30;
		ArrayAssert.equalToArray([timer], _log);
		
		timer.start();
		_factory.currentTime = 30 + 9;
		ArrayAssert.equalToArray([timer], _log);
		_factory.currentTime = 30 + 10;
		ArrayAssert.equalToArray([timer, timer], _log);
		_factory.currentTime = 30 + 20;
		ArrayAssert.equalToArray([timer, timer, timer], _log);
		
		_factory.currentTime = 30 + 31;
		ArrayAssert.equalToArray([timer, timer, timer], _log);
	}
	
	@Test
	public function reset()
	{
		var timer = _factory.newTimer(10, 3);
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		timer.start();
		
		ArrayAssert.equalToArray([], _log);
		_factory.currentTime = 9;
		ArrayAssert.equalToArray([], _log);
		_factory.currentTime = 10;
		ArrayAssert.equalToArray([timer], _log);
		
		timer.reset();
		_factory.currentTime = 19;
		ArrayAssert.equalToArray([timer], _log);
		_factory.currentTime = 20;
		ArrayAssert.equalToArray([timer], _log);
		_factory.currentTime = 21;
		ArrayAssert.equalToArray([timer], _log);
		_factory.currentTime = 30;
		ArrayAssert.equalToArray([timer], _log);
		
		
		timer.start();
		_factory.currentTime = 30 + 9;
		ArrayAssert.equalToArray([timer], _log);
		_factory.currentTime = 30 + 10;
		ArrayAssert.equalToArray([timer, timer], _log);
		_factory.currentTime = 30 + 20;
		ArrayAssert.equalToArray([timer, timer, timer], _log);
		_factory.currentTime = 30 + 31;
		ArrayAssert.equalToArray([timer, timer, timer, timer], _log);
		
		_factory.currentTime = 30 + 41;
		ArrayAssert.equalToArray([timer, timer, timer, timer], _log);
	}
	
	function onTimer(event:Event)
	{
		_log.push(event.target);
	}
}