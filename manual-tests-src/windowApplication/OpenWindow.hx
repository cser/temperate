package windowApplication;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.ui.Keyboard;
import temperate.components.CButtonSelector;
import temperate.components.ICButton;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.MButton;
import temperate.minimal.MFlatButton;
import temperate.minimal.MScrollPane;
import temperate.minimal.MSeparator;
import temperate.minimal.windows.AMWindow;

class OpenWindow extends AMWindow<OpenWindowData>
{
	public function new(names:Array<String>)
	{
		super();
		
		_baseSkin.title = "Open file";
		
		_names = new CButtonSelector(null, true);
		
		var list = new CVBox();
		list.gapY = 0;
		for (name in names)
		{
			var button = new MFlatButton();
			button.text = name;
			list.add(button).setPercents(100);
			_names.add(button, name);
		}
		if (names.length > 0)
		{
			_names.value = names[0];
		}
		
		var scrollPane = new MScrollPane();
		scrollPane.set(list).setPercents(100);
		_main.add(scrollPane).setPercents(100, 100);
		
		_main.add(new MSeparator(true)).setIndents( -2, -2).setPercents(100);
		
		var buttonBox = new CHBox();
		_main.add(buttonBox).setAlign(.5);
		
		var button = new MButton();
		button.text = "Open";
		button.addEventListener(MouseEvent.CLICK, onOpenClick);
		button.selected = true;
		buttonBox.add(button);
		_openButton = button;
		
		var button = new MButton();
		button.text = "Remove";
		button.addEventListener(MouseEvent.CLICK, onRemoveClick);
		button.isEnabled = names.length > 0;
		buttonBox.add(button);
		
		var button = new MButton();
		button.text = "Cancel";
		button.addEventListener(MouseEvent.CLICK, onCancelClick);
		buttonBox.add(button);
		
		_skin.addHeadButton(_skin.getMaximizeButton())
			.addEventListener(Event.CHANGE, onMaximizeChange);
		_skin.addHeadButton(_skin.getCloseButton())
			.addEventListener(MouseEvent.CLICK, onCancelClick);
		innerDispatcher.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		
		resizable = true;
		
		_names.addEventListener(Event.CHANGE, onNamesChange);
		onNamesChange();
	}
	
	var _names:CButtonSelector<String>;
	var _buttonBox:CHBox;
	var _title:TextField;
	var _description:TextField;
	var _openButton:ICButton;
	
	function onNamesChange(event:Event = null)
	{
		_openButton.isEnabled = _names.value != null;
	}
	
	function onOpenClick(event:MouseEvent)
	{
		close(OpenWindowData.OPEN(_names.value));
	}
	
	function onRemoveClick(event:MouseEvent)
	{
		close(OpenWindowData.REMOVE(_names.value));
	}
	
	function onCancelClick(event:MouseEvent)
	{
		close(null);
	}
	
	function onMaximizeChange(event:Event)
	{
		maximized = _skin.getMaximizeButton().selected;
	}
	
	function onKeyDown(event:KeyboardEvent)
	{
		if (event.keyCode == Keyboard.ESCAPE)
		{
			close(null);
		}
		if (event.keyCode == Keyboard.ENTER)
		{
			close(OpenWindowData.OPEN(_names.value));
		}
	}
}