package windowApplication;
import flash.text.TextField;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.MFlatButton;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MSeparator;
import temperate.windows.ACWindow;

class ToolsWindow extends ACWindow
{
	public function new() 
	{
		super();
		
		_main = new CVBox();
		_main.setIndents(10, 10, 10, 10);
		addChild(_main);
		
		_title = MFormatFactory.WINDOW_TITLE.newAutoSized();
		_title.text = "Tools";
		_main.add(_title);
		
		_main.add(new MSeparator(true)).setIndents( -8, -8).setPercents(100);
		
		_main.add(new MSeparator(true)).setIndents( -8, -8).setPercents(100);
		
		var button = new MFlatButton();
		button.text = "Open";
		_main.add(button).setPercents(100);
		
		var button = new MFlatButton();
		button.text = "Save";
		_main.add(button).setPercents(100);
		
		_size_valid = false;
		postponeSize();
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
}