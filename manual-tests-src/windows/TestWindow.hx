package windows;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.MFlatButton;
import temperate.minimal.MFormatFactory;
import temperate.windows.ACWindow;
import temperate.windows.CPopUpManager;

class TestWindow extends ACWindow
{
	public function new(manager:CPopUpManager) 
	{
		super(manager);
		_main = new CVBox();
		_main.setIndents(10, 10, 10, 10);
		addChild(_main);
		
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
		_buttonBox.add(button).setAlign(.5);
		
		var button = new MFlatButton();
		button.text = "Cancel";
		_buttonBox.add(button).setAlign(.5);
		
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
	
	/*var _owner:ICWindowOwner;
	
	override public function subscribe(owner:ICWindowOwner):Void 
	{
		super.subscribe(owner);
		_owner = owner;
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	override public function unsubscribe(owner:ICWindowOwner):Void 
	{
		super.unsubscribe(owner);
		_owner = null;
		removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
	}
	
	function onMouseDown(event:Event)
	{
		_owner.windowStartDrag(this, true);
	}
	*/
}