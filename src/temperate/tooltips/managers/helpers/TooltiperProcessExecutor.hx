package temperate.tooltips.managers.helpers;
import flash.events.TimerEvent;
import flash.utils.Timer;
import temperate.collections.CObjectHash;
import temperate.tooltips.tooltipers.ICTooltiper;

class TooltiperProcessExecutor
{
	var _processes:CObjectHash<ICTooltiper, TooltiperProcess>;
	var _secondShowTimer:Timer;
	var _newTimer:Void->Timer;
	var _fastDelayMode:Bool;
	
	public function new(newTimer:Void->Timer)
	{
		_newTimer = newTimer;
		
		showDelay = 300;
		secondShowDelay = 0;
		hideDelay = 50;
		secondShowTimeout = 200;
		
		_processes = new CObjectHash();
		_secondShowTimer = newTimer();
		_secondShowTimer.addEventListener(TimerEvent.TIMER, onSecondShowTimer);
		
		_fastDelayMode = false;
	}
	
	public var showDelay:Int;
	public var secondShowDelay:Int;
	public var hideDelay:Int;
	public var secondShowTimeout:Int;
	
	public function show(tooltiper:ICTooltiper)
	{
		var process = getProcess(tooltiper);
		switch (process.state)
		{
			case TooltiperProcessState.EMPTY:
				process.delayReset();
				var secondShowDelay = tooltiper.secondShowDelay != null ?
					tooltiper.secondShowDelay :
					this.secondShowDelay;
				var showDelay = tooltiper.showDelay != null ?
					tooltiper.showDelay :
					this.showDelay;
				var delay = _fastDelayMode ? secondShowDelay : showDelay;
				if (delay == 0)
				{
					onDelayedShow(process);
				}
				else
				{
					process.state = TooltiperProcessState.WAIT_SHOW;
					process.delayStart(delay, onDelayedShow);
				}
			case TooltiperProcessState.WAIT_SHOW:
			case TooltiperProcessState.SHOWED:
				process.delayReset();
			case TooltiperProcessState.WAIT_HIDE:
				process.delayReset();
				process.state = TooltiperProcessState.SHOWED;
				fastDelayOn();
		}
	}
	
	public function hide(tooltiper:ICTooltiper)
	{
		var process = getProcess(tooltiper);
		switch (process.state)
		{
			case TooltiperProcessState.EMPTY:
				process.delayReset();
			case TooltiperProcessState.WAIT_SHOW:
				process.delayReset();
				process.state = TooltiperProcessState.EMPTY;
				removeProcess(process);
			case TooltiperProcessState.SHOWED:
				var hideDelay = tooltiper.hideDelay != null ?
					tooltiper.hideDelay :
					this.hideDelay;
				process.delayReset();
				if (hideDelay == 0)
				{
					onDelayedHide(process);
				}
				else
				{
					process.state = TooltiperProcessState.WAIT_HIDE;
					process.delayStart(hideDelay, onDelayedHide);
				}
			case TooltiperProcessState.WAIT_HIDE:
		}
	}
	
	function onDelayedShow(process:TooltiperProcess)
	{
		var hashFastHide = false;
		for (key in _processes.keys())
		{
			var processI = _processes.get(key);
			if (processI != process)
			{
				if (processI.state == TooltiperProcessState.WAIT_HIDE)
				{
					processI.delayReset();
					processI.tooltiper.internalHide(true);
					removeProcess(processI);
					hashFastHide = true;
				}
			}
		}
		process.state = TooltiperProcessState.SHOWED;
		fastDelayOn();
		process.tooltiper.internalShow(hashFastHide);
	}
	
	function onDelayedHide(process:TooltiperProcess)
	{
		process.state = TooltiperProcessState.EMPTY;
		fastDelayOff(process.tooltiper);
		process.tooltiper.internalHide(false);
		removeProcess(process);
	}
	
	function getProcess(tooltiper:ICTooltiper)
	{
		var process = _processes.get(tooltiper);
		if (process == null)
		{
			process = new TooltiperProcess(tooltiper, _newTimer);
			_processes.set(tooltiper, process);
		}
		return process;
	}
	
	function removeProcess(process:TooltiperProcess)
	{
		_processes.delete(process.tooltiper);
	}
	
	function fastDelayOn()
	{
		_secondShowTimer.reset();
		_fastDelayMode = true;
	}
	
	function fastDelayOff(tooltiper:ICTooltiper)
	{
		for (key in _processes.keys())
		{
			var processI = _processes.get(key);
			if (processI.state != TooltiperProcessState.EMPTY)
			{
				return;
			}
		}
		var delay = tooltiper.secondShowTimeout != null ?
			tooltiper.secondShowTimeout :
			this.secondShowTimeout;
		_secondShowTimer.reset();
		if (delay == 0)
		{
			onSecondShowTimer();
		}
		else
		{
			_secondShowTimer.delay = delay;
			_secondShowTimer.start();
		}
	}
	
	function onSecondShowTimer(event:TimerEvent = null)
	{
		_fastDelayMode = false;
	}
}