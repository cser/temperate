package ;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.Lib;
import flash.utils.Timer;
import temperate.debug.DebugMonitor;
import temperate.debug.PlotBitmap;

class TestDebugMonitor extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _timer:Timer;
	var _monitor:DebugMonitor;
	var _plotter:PlotBitmap;
	
	public function init()
	{
		_monitor = new DebugMonitor();
		addChild(_monitor);
		
		_plotter = _monitor.addPlotBitmap();
		_plotter.setMax(2);
		
		_timer = new Timer(50);
		_timer.addEventListener(TimerEvent.TIMER, onTimer);
		_timer.start();
	}
	
	function onTimer(event:TimerEvent)
	{
		var value = 1 + Math.sin(Lib.getTimer() * .002);
		_plotter.plot(value, 0xffffff00);
	}
}