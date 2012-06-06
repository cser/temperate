package temperate.debug;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.system.System;
import flash.text.TextField;
import flash.text.TextFormat;

class FPSMonitor extends Sprite
{
	static var TEXT_SIZE = 10;
	static var TEXT_HEIGHT = 18;
	static var UPDATE_DELAY = 100;
	static var MEMORY_MULTIPLIER = 1 / (1024 * 1024);
	static var MAX_MEMORY_STOCK:Int = 100 * 1024;
	
	var _width:Int;
	var _height:Int;
	
	public function new(width:Int = 200, height:Int = 100)
	{
		super();
		
		_width = width;
		_height = height;
		
		_bgColor = 0xe0000000;
		_fpsColor = 0xff00ff00;
		_settedFpsColor = 0x8000ff00;
		_memoryColor = 0xff00ffff;
		_framePlotTimes = [];
		_frameDigitTimes = [];
		_ininialized = false;
		setFpsBase();
		
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	
	function onAddedToStage(event:Event)
	{
		init();
		_isPlaying = true;
		updatePlaying();
	}
	
	function onRemovedFromStage(event:Event)
	{
		_isPlaying = false;
		updatePlaying();
	}
	
	var _ininialized:Bool;
	var _tfMemory:TextField;
	var _tfFps:TextField;
	var _memoryPlot:PlotBitmap;
	var _fpsPlot:PlotBitmap;
	var _bgColor:Int;
	var _memoryColor:Int;
	var _fpsColor:Int;
	
	public function setColors(bgColor:Int, memoryColor:Int, fpsColor:Int)
	{
		_bgColor = bgColor;
		_memoryColor = memoryColor;
		_fpsColor = fpsColor;
		return this;
	}
	
	var _settedFpsColor:Int;
	
	public function setSettedFpsColor(settedFpsColor:Int)
	{
		_settedFpsColor = settedFpsColor;
		return this;
	}
	
	var _fpsPlotBase:Int;
	var _fpsDigitBase:Int;
	
	public function setFpsBase(numPlotFrames:Int = 2, numDigitFrames:Int = 8)
	{
		_fpsPlotBase = numPlotFrames;
		if (_fpsPlotBase < 1)
		{
			_fpsPlotBase = 1;
		}
		_fpsDigitBase = numDigitFrames;
		if (_fpsDigitBase < 1)
		{
			_fpsDigitBase = 1;
		}
		return this;
	}
	
	function init()
	{
		if (_ininialized)
		{
			return;
		}
		_ininialized = true;
		
		var g = graphics;
		g.beginFill(_bgColor, (_bgColor >>> 24) / 255);
		g.drawRect(0, 0, _width, _height);
		g.endFill();
		
		_tfFps = new TextField();
		_tfFps.width = _width;
		_tfFps.height = TEXT_HEIGHT;
		_tfFps.defaultTextFormat = new TextFormat("Arial", TEXT_SIZE, _fpsColor);
		_tfFps.mouseEnabled = false;
		_tfFps.selectable = false;
		addChild(_tfFps);
		
		_tfMemory = new TextField();
		_tfMemory.width = _width;
		_tfMemory.height = TEXT_HEIGHT;
		_tfMemory.defaultTextFormat = new TextFormat("Arial", TEXT_SIZE, _memoryColor);
		_tfMemory.y = _height - TEXT_HEIGHT;
		_tfMemory.mouseEnabled = false;
		_tfMemory.selectable = false;
		addChild(_tfMemory);
		
		_fpsPlot = new PlotBitmap(_width, _height - TEXT_HEIGHT * 2, stage.frameRate * 2);
		_fpsPlot.y = TEXT_HEIGHT;
		addChild(_fpsPlot);
		
		_memoryPlot = new PlotBitmap(
			_width, _height - TEXT_HEIGHT * 2, System.totalMemory + MAX_MEMORY_STOCK
		);
		_memoryPlot.y = TEXT_HEIGHT;
		addChild(_memoryPlot);
		
		addEventListener(MouseEvent.CLICK, onClick);
	}
	
	var _isPlaying:Bool;
	
	function updatePlaying()
	{
		if (_isPlaying)
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		else
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
	
	function onClick(event:MouseEvent)
	{
		_isPlaying = !_isPlaying;
		updatePlaying();
	}
	
	var _framePlotTimes:Array<Int>;
	var _frameDigitTimes:Array<Int>;
	var _maxMemory:Int;
	
	function calculateFps(time:Int, times:Array<Int>, framesBase:Int)
	{
		var fps;
		var timesLength = times.length;
		if (timesLength == 0)
		{
			fps = 0;
		}
		else
		{
			fps = Math.round(1000 * timesLength / (time - times[0]));
		}
		
		times[timesLength] = time;
		if (timesLength + 1 > framesBase)
		{
			times.shift();
		}
		return fps;
	}
	
	function onEnterFrame(event:Event)
	{
		var time = Lib.getTimer();
		var plotFps = calculateFps(time, _framePlotTimes, _fpsPlotBase);
		var digitFps = calculateFps(time, _frameDigitTimes, _fpsDigitBase);
		
		var memory = Std.int(System.totalMemory);
		if (memory > _maxMemory + MAX_MEMORY_STOCK)
		{
			_maxMemory = memory + MAX_MEMORY_STOCK;
			_memoryPlot.setMax(_maxMemory + MAX_MEMORY_STOCK);
		}
		
		var frameRate = stage.frameRate;
		
		if ((_settedFpsColor & 0xff000000) != 0)
		{
			_fpsPlot.plot(frameRate, _settedFpsColor);
		}
		_fpsPlot.plot(plotFps, _fpsColor);
		_fpsPlot.scroll();
		
		_memoryPlot.plot(memory, _memoryColor);
		_memoryPlot.scroll();
		
		_tfFps.text = "FPS: " + digitFps + " / " + frameRate;
		_tfMemory.text = toFixed3(memory * MEMORY_MULTIPLIER) + " Mb / " +
			toFixed3(_maxMemory * MEMORY_MULTIPLIER) + " Mb";
	}
	
	private function toFixed3(value:Float):String
	{
		return Std.string(Std.int(value * 1000) * .001);
	}
	
	public function move(x:Float, y:Float)
	{
		this.x = x;
		this.y = y;
		return this;
	}
	
	public function addTo(parent:DisplayObjectContainer, x:Float = 0, y:Float = 0)
	{
		this.x = x;
		this.y = y;
		parent.addChild(this);
		return this;
	}
}