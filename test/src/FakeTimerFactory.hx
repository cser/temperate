package ;
import flash.errors.Error;

class FakeTimerFactory 
{
	var _timers:Array<FakeTimer>;
	
	public function new() 
	{
		_timers = [];
		_currentTime = 0;
	}
	
	public function newTimer(delay:Int, repeat:Int = 0)
	{
		var timer = new FakeTimer(delay, repeat);
		_timers.push(timer);
		return timer;
	}
	
	public var currentTime(get_currentTime, set_currentTime):Int;
	var _currentTime:Int;
	function get_currentTime()
	{
		return _currentTime;
	}
	function set_currentTime(value)
	{
		var oldTime = _currentTime;
		var newTime = value;
		if (newTime < oldTime)
		{
			throw new Error("Only increase time allowed");
		}
		_currentTime = newTime;
		for (time in oldTime ... newTime)
		{
			for (timer in _timers)
			{
				timer.tick();
			}
		}
		return _currentTime;
	}
}