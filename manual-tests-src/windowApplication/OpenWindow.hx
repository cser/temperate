package windowApplication;
import flash.events.MouseEvent;
import flash.text.TextField;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.MButton;
import temperate.minimal.MFlatButton;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MScrollPane;
import temperate.minimal.MSeparator;
import temperate.windows.ACWindow;
import temperate.windows.CPopUpManager;
import temperate.windows.CPopUpMover;

class OpenWindow extends ACWindow
{
	public function new(manager:CPopUpManager) 
	{
		super(manager);
		
		_main = new CVBox();
		_main.setIndents(10, 10, 10, 10);
		addChild(_main);
		
		_title = MFormatFactory.WINDOW_TITLE.newAutoSized();
		_title.text = "Open file";
		_main.add(_title);
		
		_main.add(new MSeparator(true)).setIndents( -8, -8).setPercents(100);
		
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
		
		_main.add(new MSeparator(true)).setIndents( -8, -8).setPercents(100);
		
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
		
		_size_valid = false;
		postponeSize();
		
		var mover = new CPopUpMover();
		mover.updateOnMove = true;
		mover.subscribe(this, this);
	}
	
	var _main:CVBox;
	var _buttonBox:CHBox;
	var _title:TextField;
	var _description:TextField;
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_main.width = getNeededWidth();
			_main.height = getNeededHeight();
			_width = _main.width;
			_height = _main.height;
			
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			var g = graphics;
			g.clear();
			g.lineStyle(2, 0x000000);
			g.beginFill(0xeeeeee);
			g.drawRoundRect(0, 0, _width, _height, 10);
			g.endFill();
		}
	}
	
	function onOpenClick(event:MouseEvent)
	{
		close();
	}
	
	function onCancelClick(event:MouseEvent)
	{
		close();
	}
}