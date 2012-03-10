package ;
import flash.events.TimerEvent;
import flash.utils.Timer;

class FakeTimer extends Timer
{
	public function new(delay:Int, repeat:Int = 0) 
	{
		super(delay, repeat);
		
		#if nme
		repeatCount = repeat;
		running = false;
		#else
		_repeatCount = repeat;
		_running = false;
		#end
		_remainsRepeats = repeatCount;
	}
	
	#if !nme
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
	#end
	
	var _remainsRepeats:Int;
	var _timeToNextDispatch:Int;
	
	override public function start()
	{
		_timeToNextDispatch = Std.int(delay);
		#if nme
		running = true;
		#else
		_running = true;
		#end
	}
	
	override public function reset()
	{
		#if nme
		_remainsRepeats = repeatCount;
		running = false;
		#else
		_remainsRepeats = _repeatCount;
		_running = false;
		#end
	}
	
	override public function stop()
	{
		#if nme
		running = false;
		#else
		_running = false;
		#end
	}
	
	public function tick()
	{
		if (!(#if nme running #else _running #end))
		{
			return;
		}
		if (delay <= 0)
		{
			_remainsRepeats--;
			dispatchEvent(new TimerEvent(TimerEvent.TIMER));
			if (_remainsRepeats <= 0)
			{
				#if nme
				running = false;
				#else
				_running = false;
				#end
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
					#if nme
					running = false;
					#else
					_running = false;
					#end
				}
			}
		}
	}
}