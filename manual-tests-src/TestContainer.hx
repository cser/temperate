package ;
import flash.display.Sprite;
import flash.events.Event;
import temperate.containers.ACLineBox;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.debug.DebugMonitor;
import temperate.minimal.MButton;

class TestContainer extends Sprite
{
	var _hContainer:CHBox;
	var _vContainer:CVBox;
	
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var monitor = new DebugMonitor();
		monitor.move(0, 200);
		addChild(monitor);
		
		_hContainer = new CHBox();
		addChild(_hContainer);
		
		_vContainer = new CVBox();
		addChild(_vContainer);
		
		var array:Array<ACLineBox> = [];
		array[0] = _hContainer;
		array[1] = _vContainer;
		for (container in array)
		{		
			var button = new MButton();
			button.text = "Default button";
			button.setCompact(false, false);
			container.add(button).setPercents(100, -1);
			
			var button = new MButton();
			button.text = "Button text";
			button.setCompact(false, true);
			container.add(button).setFixedSize(100, 100).setChildAlign(1, 1);
			
			var button = new MButton();
			button.text = "Button Text";
			button.setCompact(false, false);
			container.add(button).setPercents(100, 100).setAlign(.5, .5);
			
			container.setCompact(false, false);
		}
		
		var g = _hContainer.graphics;
		g.lineStyle(0, 0xff0000);
		g.drawRect(0, 0, _hContainer.width, _hContainer.height);
		
		var g = _vContainer.graphics;
		g.lineStyle(0, 0xff0000);
		g.drawRect(0, 0, _vContainer.width, _vContainer.height);
		
		/*
		- Проверить indents
		- Сростить ChildWrapper c SizeInfo
		*/
		_angle = 0;
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		stage.addEventListener(Event.RESIZE, onStageResize);
	}
	
	var _angle:Float;	
	
	function onEnterFrame(event:Event)
	{
		_angle += .1;
		_hContainer.width = 300 + 200 * (1 + Math.sin(_angle));
	}
	
	function onStageResize(event:Event)
	{
		_hContainer.width = stage.stageWidth;
		_vContainer.height = stage.stageHeight;
		
		var g = graphics;
		g.clear();
		g.beginFill(0x00ff00);
		g.drawRect(100, 0, 20, stage.stageHeight);
		g.endFill();
	}
}