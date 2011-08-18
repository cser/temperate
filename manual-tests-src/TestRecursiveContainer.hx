package ;
import flash.display.Sprite;
import flash.events.Event;
import temperate.components.CSpacer;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.debug.FPSMonitor;
import temperate.minimal.MButton;

class TestRecursiveContainer extends Sprite
{
	var _main:CVBox;
	
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		_main = new CVBox();
		_main.setIndents(20, 10, 5, 5);
		addChild(_main);
		
		_main.add(new MButton().setText("Very long button text\nwith two lines")).setPercents(100);
		
		var box = new CHBox();
		_main.add(box).setPercents(100, 30);
		
		box.add(new MButton().setText("Short")).setPercents(100, 100);
		box.add(new MButton().setText("Short")).setPercents(100, 100);
		box.add(new MButton().setText("Short")).setPercents(100, 100);
		box.add(new MButton().setText("Short")).setPercents(100, 100);
		box.add(new MButton().setText("Short")).setPercents(100, 100);
		box.add(new MButton().setText("Short")).setPercents(100, 100);
		box.add(new MButton().setText("Short")).setPercents(100, 100);
		box.add(new MButton().setText("Short")).setPercents(100, 100);
		box.add(new MButton().setText("Short")).setPercents(100, 100);
		box.add(new MButton().setText("Some text")).setPercents(100, 100).setContingencies(100);
		box.add(new CSpacer()).setPercents(50);
		box.add(new MButton().setText("Some text")).setPercents(100, 100).setContingencies(100);
		
		var box = new CHBox();
		_main.add(box).setPercents(100, 70);
		
		box.add(new MButton().setText("Button text")).setPercents(100, 100);
		box.add(new MButton().setText("Button text")).setPercents(80, 60);
		box.add(new MButton().setText("Button text")).setPercents(100, 100);
		
		var subBox = new CHBox();
		box.add(subBox).setPercents(50, 100);
		
		var button = new MButton().setText("Button text");
		button.setCompact(false, true);
		subBox.add(button).setPercents(100, 100).setAlign(0, 1);
		
		subBox.add(new MButton().setText("Button text")).setPercents(100, 100)
			.setIndents(10, 10, 5, 5);
		subBox.add(new MButton().setText("Button text")).setPercents(100, 100);
		
		var button = new MButton().setText("Button text");
		button.setCompact(false, true);
		subBox.add(button).setPercents(100, 100).setAlign(0, 1);
		
		stage.addEventListener(Event.RESIZE, onStageResize);
		
		new FPSMonitor().addTo(this, 0, 200);
	}
	
	function onStageResize(event:Event)
	{
		_main.width = stage.stageWidth;
		_main.height = stage.stageHeight;
	}
}