package windows;
import flash.events.MouseEvent;
import flash.text.TextField;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.MFlatButton;
import temperate.minimal.MFormatFactory;
import temperate.windows.ACWindow;
import temperate.windows.skins.CWindowDefaultSkin;
import temperate.windows.skins.ICWindowSkin;

class TestWindow extends ACWindow
{
	public function new() 
	{
		super();
		
		_main = new CVBox();
		_skin.addChild(_main);
		_main.setIndents(10, 10, 10, 10);
		
		_title = MFormatFactory.WINDOW_TITLE.newAutoSized();
		_title.text = "Test window";
		_main.add(_title);
		
		_description = MFormatFactory.LABEL.newAutoSized();
		_description.wordWrap = true;
		_description.text = "Description text text text text text text text text text text text";
		_main.add(_description).setPercents(100).setContingencies(150, 300);
		
		_buttonBox = new CHBox();
		_main.add(_buttonBox).setPercents(100);
		
		var button = new MFlatButton();
		button.text = "OK";
		button.addEventListener(MouseEvent.CLICK, onOKClick);
		_buttonBox.add(button).setAlign(.5);
		
		var button = new MFlatButton();
		button.text = "Cancel";
		button.addEventListener(MouseEvent.CLICK, onCancelClick);
		_buttonBox.add(button).setAlign(.5);
		
		var width = _main.width;
		var height = _main.height;
		_skin.setSize(width, height);
		
		var g = _main.graphics;
		g.clear();
		g.lineStyle(2, 0x000000);
		g.beginFill(0xeeeeee);
		g.drawRoundRect(0, 0, width, height, 10);
		g.endFill();
	}
	
	var _main:CVBox;
	var _buttonBox:CHBox;
	var _title:TextField;
	var _description:TextField;
	var _skin:CWindowDefaultSkin;
	
	override function newSkin():ICWindowSkin
	{
		_skin = new CWindowDefaultSkin();
		return _skin;
	}
	
	function onOKClick(event:MouseEvent)
	{
		manager.remove(this);
	}
	
	function onCancelClick(event:MouseEvent)
	{
		manager.remove(this);
	}
}