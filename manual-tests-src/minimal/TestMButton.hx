package minimal;
import flash.display.Sprite;
import flash.events.MouseEvent;
import temperate.components.ACButton;
import temperate.containers.CVBox;
import temperate.core.CValidator;
import temperate.minimal.MButton;
import temperate.minimal.MFlatButton;

class TestMButton extends Sprite
{
	public function new() 
	{
		super();
	}
	
	private var _selectedButton:ACButton;
	
	public function init()
	{
		new MButton().setText("Button").addTo(this, 100, 50);
		new MButton().setText("Disabled").addTo(this, 100, 90).isEnabled = false;
		new MButton().setText("Toggle").addTo(this, 100, 120).toggle = true;
		
		_selectedButton = new MButton().setText("Selected manual toggled").addTo(this, 200, 50);
		_selectedButton.selected = true;
		_selectedButton.addEventListener(MouseEvent.CLICK, onSelectedButtonClick);
		
		var button = new MButton().setText("Selected disabled").addTo(this, 200, 90);
		button.selected = true;
		button.isEnabled = false;
		
		var button = new MButton().setText("Some text\nwith thwo lines").addTo(this, 200, 150);
		button.setCompact(false, false);
		button.width = 100;
		button.height = 100;
		
		var button = new MButton().setText("Some text\nwith thwo lines").addTo(this, 200, 250);
		button.setCompact(false, true);
		button.width = 100;
		
		var g = graphics;
		g.beginFill(0x00ff00);
		g.drawRect(0, 50, 100, 100);
		g.endFill();
		
		{
			var box = new CVBox().addTo(this, 350, 200);
			var button = new MFlatButton().setText("MFlatButton normal");
			box.add(button).setPercents(100);
			var button = new MFlatButton().setText("MFlatButton selected");
			button.selected = true;
			box.add(button).setPercents(100);
			var button = new MFlatButton().setText("MFlatButton disabled");
			button.isEnabled = false;
			box.add(button).setPercents(100);
			var button = new MFlatButton().setText("MFlatButton selected disabled");
			button.selected = true;
			button.isEnabled = false;
			box.add(button).setPercents(100);
		}
	}
	
	function onSelectedButtonClick(event:MouseEvent)
	{
		_selectedButton.selected = !_selectedButton.selected;
	}
}