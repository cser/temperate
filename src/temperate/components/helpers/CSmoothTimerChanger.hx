package temperate.components.helpers;
import flash.events.TimerEvent;
import flash.utils.Timer;
import temperate.core.CMath;

class CSmoothTimerChanger implements ICTimerChanger
{
	public function new()
	{
		firstDelay = 300;
		secondDelay = 100;
		minDelay = 10;
		nextDelayRatio = .5;
		
		_timer = new Timer(1000);
	}
	
	var _timer:Timer;
	
	public function increaseDown(useSecondDelay:Bool)
	{
		onIncrease();
		_timer.addEventListener(TimerEvent.TIMER, increaseValueHandler);
		startTimer(useSecondDelay);
	}
	
	public function decreaseDown(useSecondDelay:Bool)
	{
		onDecrease();
		_timer.addEventListener(TimerEvent.TIMER, decreaseValueHandler);
		startTimer(useSecondDelay);
	}
	
	public function up()
	{
		_timer.stop();
		_timer.removeEventListener(TimerEvent.TIMER, increaseValueHandler);
		_timer.removeEventListener(TimerEvent.TIMER, decreaseValueHandler);
	}
	
	function startTimer(useSecondDelay:Bool)
	{
		_timer.delay = useSecondDelay ? getNextDelay(_timer.delay) : firstDelay;
		_timer.start();
	}
	
	function increaseValueHandler(event:TimerEvent)
	{
		onIncrease();
		_timer.delay = getNextDelay(_timer.delay);
	}
	
	function decreaseValueHandler(event:TimerEvent)
	{
		onDecrease();
		_timer.delay = getNextDelay(_timer.delay);
	}
	
	public var minDelay(default, null):Int;
	public var firstDelay(default, null):Int;
	public var secondDelay(default, null):Int;
	public var nextDelayRatio(default, null):Float;
	
	public function setDelays(firstDelay:Int, secondDelay:Int, minDelay:Int, nextDelayRatio:Float)
	{
		this.firstDelay = firstDelay;
		this.secondDelay = secondDelay;
		this.minDelay = minDelay;
		this.nextDelayRatio = nextDelayRatio;
		return this;
	}
	
	public var onIncrease:Void->Void;
	public var onDecrease:Void->Void;
	
	function getNextDelay(current:Float):Float
	{
		if (current > secondDelay)
		{
			return secondDelay;
		}
		return CMath.max(current * nextDelayRatio, minDelay);
	}
}