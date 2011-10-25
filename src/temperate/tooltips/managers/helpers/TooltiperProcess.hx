package temperate.tooltips.managers.helpers;
import flash.events.TimerEvent;
import flash.utils.Timer;
import temperate.tooltips.tooltipers.ICTooltiper;

class TooltiperProcess
{
	var _timer:Timer;
	
	public function new(tooltiper:ICTooltiper, newTimer:Void->Timer)
	{	
		this.tooltiper = tooltiper;
		
		_timer = newTimer();
		_timer.addEventListener(TimerEvent.TIMER, onTimer);
		state = TooltiperProcessState.EMPTY;
	}
	
	public var tooltiper(default, null):ICTooltiper;
	
	public var state:TooltiperProcessState;
	
	var _onDelay:TooltiperProcess->Void;
	
	public function delayStart(delay:Int, onDelay:TooltiperProcess->Void)
	{
		_onDelay = onDelay;
		_timer.reset;
		_timer.delay = delay;
		_timer.start();
	}
	
	public function delayReset()
	{
		_timer.reset();
		_onDelay = null;
	}
	
	function onTimer(event:TimerEvent)
	{
		var onDelay = _onDelay;
		_onDelay = null;
		onDelay(this);
	}
}