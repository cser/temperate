package windowApplication;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.MButton;
import temperate.minimal.MFlatButton;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MScrollPane;
import temperate.minimal.MSeparator;
import temperate.minimal.skins.MWindowSkin;
import temperate.skins.ICWindowSkin;
import temperate.windows.ACWindow;
import temperate.windows.CPopUpManager;
import temperate.windows.CPopUpMover;

class OpenWindow extends ACWindow
{
	public function new(manager:CPopUpManager) 
	{
		super(manager);
		
		_baseSkin.title = "Open file";
		
		var list = new CVBox();
		list.gapY = 0;
		for (file in ["File 01", "File 02", "File 03", "File 04", "File 05", "File 06", "File 07"])
		{
			var button = new MFlatButton();
			button.text = file;
			list.add(button).setPercents(100);
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
		buttonBox.add(button);
		
		var button = new MButton();
		button.text = "Cancel";
		button.addEventListener(MouseEvent.CLICK, onCancelClick);
		buttonBox.add(button);
		
		new CPopUpMover().subscribe(getManager, this, view, get_dock);
	}
	
	var _main:CVBox;
	var _buttonBox:CHBox;
	var _title:TextField;
	var _description:TextField;
	
	function onOpenClick(event:MouseEvent)
	{
		close();
	}
	
	function onCancelClick(event:MouseEvent)
	{
		close();
	}
	
	override function newSkin():ICWindowSkin
	{
		return new MWindowSkin();
	}
	
	override function newContainer():Sprite
	{
		_main = new CVBox();
		return _main;
	}
}