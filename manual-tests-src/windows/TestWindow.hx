package windows;
import flash.text.TextField;
import temperate.containers.CVBox;
import temperate.core.CSprite;
import temperate.minimal.MFormatFactory;

class TestWindow extends CSprite
{
	public function new() 
	{
		super();
		_main = new CVBox();
		addChild(_main);
		
		_title = MFormatFactory.WINDOW_TITLE.newAutoSized();
		_title.text = "Test window";
		_main.add(_title);
	}
	
	var _main:CVBox;
	var _title:TextField;
}