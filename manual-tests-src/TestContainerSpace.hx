package ;
import flash.display.Sprite;
import flash.events.Event;
import temperate.containers.CVBox;
import temperate.debug.DebugMonitor;
import temperate.layouts.parametrization.CExcessSpaceMode;
import temperate.minimal.MButton;

class TestContainerSpace extends Sprite
{
	var _main:CVBox;
	
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		new DebugMonitor().addTo(this, 0, 200);
		
		_main = new CVBox();
		_main.excessSpaceMode = CExcessSpaceMode.UNIFORM;
		addChild(_main);
		
		_main.add(new MButton().setText("Button text"));
		_main.add(new MButton().setText("Button text"));
		_main.add(new MButton().setText("Button text")).setAlign(.5);
		_main.add(new MButton().setText("Button text")).setAlign(1, 1);
		
		stage.addEventListener(Event.RESIZE, onStageResize);
	}
	
	function onStageResize(event:Event)
	{
		_main.width = stage.stageWidth;
		_main.height = stage.stageHeight;
	}
}