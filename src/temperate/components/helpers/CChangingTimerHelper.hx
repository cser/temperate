package temperate.components.helpers;
import flash.events.TimerEvent;
import flash.utils.Timer;

class CChangingTimerHelper
{
	public function new()
	{
		firstDelay = 200;
		secondDelay = 50;
		
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
		_timer.delay = useSecondDelay ? secondDelay : firstDelay;
		_timer.start();
	}
	
	function increaseValueHandler(event:TimerEvent)
	{
		onIncrease();
		_timer.delay = secondDelay;
	}
	
	function decreaseValueHandler(event:TimerEvent)
	{
		onDecrease();
		_timer.delay = secondDelay;
	}
	
	public var firstDelay:Int;
	public var secondDelay:Int;
	
	public var onIncrease:Void->Void;
	public var onDecrease:Void->Void;
}