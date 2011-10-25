package ;
import flash.events.TimerEvent;
import flash.utils.Timer;

class FakeTimer extends Timer
{	
	public function new(delay:Int, repeat:Int = 0) 
	{
		super(delay, repeat);
		
		_repeatCount = repeat;
		_remainsRepeats = repeatCount;
		_running = false;
	}
	
	var _running:Bool;
	
	@:getter(running)
	function get_running():Bool
	{
		return _running;
	}
	
	var _repeatCount:Int;
	
	@:getter(repeatCount)
	function get_repeatCount()
	{
		return _repeatCount;
	}
	
	@:setter(repeatCount)
	function set_repeatCount(value)
	{
		_repeatCount = value;
		_remainsRepeats = repeatCount;
	}
	
	var _remainsRepeats:Int;
	var _timeToNextDispatch:Int;
	
	override public function start()
	{
		_timeToNextDispatch = Std.int(delay);
		_running = true;
	}
	
	override public function reset()
	{
		_remainsRepeats = _repeatCount;
		_running = false;
	}
	
	override public function stop()
	{
		_running = false;
	}
	
	public function tick()
	{
		if (!_running)
		{
			return;
		}
		if (delay <= 0)
		{
			_remainsRepeats--;
			dispatchEvent(new TimerEvent(TimerEvent.TIMER));
			if (_remainsRepeats <= 0)
			{
				_running = false;
			}
		}
		else
		{
			_timeToNextDispatch--;
			if (_timeToNextDispatch <= 0)
			{
				dispatchEvent(new TimerEvent(TimerEvent.TIMER));
				_remainsRepeats--;
				_timeToNextDispatch = Std.int(delay);
				if (repeatCount != 0 && _remainsRepeats <= 0)
				{
					_running = false;
				}
			}
		}
	}
}