package minimal;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import temperate.components.ACButton;
import temperate.components.CButtonSelector;
import temperate.components.CButtonState;
import temperate.containers.CVBox;
import temperate.minimal.graphics.MCommonBdFactory;
import temperate.minimal.MButton;
import temperate.minimal.MCheckBox;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MLabel;
import temperate.minimal.MRadioButton;
import temperate.text.CLabel;

class TestMCheckBox extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _selectedButton:ACButton;
	var _switcher:CButtonSelector<String>;
	var _valueTF:TextField;
	
	public function init()
	{
		new MCheckBox().setText("Button").addTo(this, 100, 50);
		new MCheckBox().setText("Disabled").addTo(this, 100, 90).enabled = false;
		
		_selectedButton = new MCheckBox().setText("Selected").addTo(this, 200, 50);
		_selectedButton.selected = true;
		
		var button = new MCheckBox().setText("Selected disabled").addTo(this, 200, 90);
		button.selected = true;
		button.enabled = false;
		
		var button = new MCheckBox().setText("Some text\nwith thwo lines").addTo(this, 200, 150);
		button.setCompact(false, false);
		button.width = 100;
		button.height = 100;
		
		var button = new MCheckBox().setText("Some text\nwith thwo lines").addTo(this, 200, 250);
		button.setCompact(false, true);
		button.width = 100;
		
		new MButton().setText("Button text").addTo(this, 100, 10);
		new MButton().setText("Button text").addTo(this, 200, 10).selected = true;
		new MButton().addTo(this, 300, 10).addClickHandler(onEmptyButtonClick);
		
		_radioButton = new MRadioButton().setText("Some text").addClickHandler(onRadioButtonClick);
		_radioButton.addTo(this, 100, 300);
		
		new MRadioButton().setText("Some text").addTo(this, 200, 300).selected = true;
		
		{
			var box = new CVBox();
			box.x = 100;
			box.y = 350;
			addChild(box);
			
			_switcher = new CButtonSelector("Nothing selected", false);
			
			var button = new MRadioButton().setText("Some value 1");
			box.add(button);
			_switcher.add(button, "Value 1");
			
			var button = new MRadioButton().setText("Some value 2");
			box.add(button);
			_switcher.add(button, "Value 2");
			
			var button = new MRadioButton().setText("Some value 3");
			box.add(button);
			_switcher.add(button, "Value 3");
			
			_valueTF = MFormatFactory.LABEL.newAutoSized(false, _switcher.value);
			box.add(_valueTF);
			
			_switcher.addEventListener(Event.CHANGE, onValueChange);
			onValueChange();
		}
		
		{
			var box = new CVBox();
			box.x = 200;
			box.y = 350;
			addChild(box);
			
			var switcher = new CButtonSelector(1, true);
			
			var button = new MRadioButton().setText("Some value 1");
			box.add(button);
			switcher.add(button, 1);
			
			var button = new MRadioButton().setText("Some value 2");
			box.add(button);
			switcher.add(button, 2);
			
			var button = new MRadioButton().setText("Some value 3");
			box.add(button);
			switcher.add(button, 3);
		}
		
		new MLabel().setText("Label text").addTo(this, 0, 0);
		new CLabel().setText("Label text").addTo(this, 0, 20);
	}
	
	var _radioButton:ACButton;
	
	function onValueChange(event:Event = null)
	{
		_valueTF.text = _switcher.value;
	}
	
	function onRadioButtonClick(event:MouseEvent)
	{
		_radioButton.selected = !_radioButton.selected;
	}
	
	function onEmptyButtonClick(event:MouseEvent)
	{
		cast(_selectedButton, MCheckBox).getState(CButtonState.UP_SELECTED).bitmapData =
			MCommonBdFactory.getButtonBgUp();
	}
}