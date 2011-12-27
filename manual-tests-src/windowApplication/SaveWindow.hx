package windowApplication;
import flash.events.MouseEvent;
import flash.text.TextField;
import temperate.containers.CHBox;
import temperate.minimal.MButton;
import temperate.minimal.MInputField;
import temperate.minimal.MLabel;
import temperate.minimal.MSeparator;
import temperate.minimal.MWindow;
import temperate.windows.CPopUpManager;

class SaveWindow extends MWindow 
{
	public function new(manager:CPopUpManager) 
	{
		super(manager);
		
		_baseSkin.title = "Save file";
		
		var line = new CHBox();
		_main.add(line);
		
		line.add(new MLabel().setText("Name"));
		
		_input = new MInputField();
		line.add(_input);
		
		_main.add(new MSeparator(true)).setIndents( -2, -2).setPercents(100);
		
		var buttonBox = new CHBox();
		_main.add(buttonBox).setAlign(.5);
		
		var button = new MButton();
		button.text = "Save";
		button.addEventListener(MouseEvent.CLICK, onSaveClick);
		buttonBox.add(button);
		
		var button = new MButton();
		button.text = "Cancel";
		button.addEventListener(MouseEvent.CLICK, onCancelClick);
		buttonBox.add(button);
		
		_skin.addCloseButton().addEventListener(MouseEvent.CLICK, onCancelClick);
	}
	
	var _title:TextField;
	var _input:MInputField;
	
	function onSaveClick(event:MouseEvent)
	{
		close();
	}
	
	function onCancelClick(event:MouseEvent)
	{
		close();
	}
}