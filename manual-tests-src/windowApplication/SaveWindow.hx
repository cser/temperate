package windowApplication;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.ui.Keyboard;
import temperate.containers.CHBox;
import temperate.minimal.MButton;
import temperate.minimal.MInputField;
import temperate.minimal.MLabel;
import temperate.minimal.MSeparator;
import temperate.minimal.windows.AMWindow;

class SaveWindow extends AMWindow<String>
{
	public function new(name:String) 
	{
		super();
		
		_baseSkin.title = "Save file";
		
		var line = new CHBox();
		_main.add(line);
		
		line.add(new MLabel().setText("Name"));
		
		_input = new MInputField();
		_input.text = name;
		line.add(_input);
		
		_main.add(new MSeparator(true)).setIndents( -2, -2).setPercents(100);
		
		var buttonBox = new CHBox();
		_main.add(buttonBox).setAlign(.5);
		
		var button = new MButton();
		button.text = "Save";
		button.addEventListener(MouseEvent.CLICK, onSaveClick);
		button.selected = true;
		buttonBox.add(button);
		
		var button = new MButton();
		button.text = "Cancel";
		button.addEventListener(MouseEvent.CLICK, onCancelClick);
		buttonBox.add(button);
		
		_skin.addHeadButton(_skin.getCloseButton()).addEventListener(MouseEvent.CLICK, onCancelClick);
		innerDispatcher.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	var _title:TextField;
	var _input:MInputField;
	
	function onSaveClick(event:MouseEvent)
	{
		close(_input.text);
	}
	
	function onCancelClick(event:MouseEvent)
	{
		close(null);
	}
	
	function onKeyDown(event:KeyboardEvent)
	{
		if (event.keyCode == Keyboard.ESCAPE)
		{
			close(null);
		}
		else if (event.keyCode == Keyboard.ENTER)
		{
			close(_input.text);
		}
	}
}