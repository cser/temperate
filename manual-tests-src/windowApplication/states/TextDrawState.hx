package windowApplication.states;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
import temperate.containers.CVBox;
import temperate.minimal.MButton;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MInputField;
import temperate.minimal.MWindowedContainer;
import temperate.minimal.MWindowManager;
import temperate.windows.events.CWindowEvent;
import windowApplication.assets.Text;

class TextDrawState extends ADrawState
{
	public function new() 
	{
		super();
		
		icon = Text;
	}
	
	var _x:Float;
	var _y:Float;
	var _width:Float;
	var _height:Float;
	
	override function doStart()
	{
		_x = _image.mouseX;
		_y = _image.mouseY;
	}
	
	override function doMove()
	{
		_topGraphics.clear();
		_topGraphics.lineStyle(0x000000);
		_topGraphics.drawRect(_x, _y, _image.mouseX - _x, _image.mouseY - _y);
	}
	
	override function doComplete()
	{
		_width = _image.mouseX - _x;
		_height = _image.mouseY - _y;
		_input = new MInputField();
		var container = new CVBox();
		container.setCompact(false, true);
		container.add(_input).setPercents(100);
		_window = new MWindowedContainer(container, "Text");
		_window.addTypedListener(CWindowEvent.CLOSE, onWindowClose);
		_window.setSize(200, 0);
		_window.addCloseButton();
		_window.resizable = true;
		_window.innerDispatcher.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		var button = new MButton();
		button.text = "OK";
		button.addEventListener(MouseEvent.CLICK, onOKClick);
		container.add(button).setAlign(1);
		MWindowManager.add(_window, true);
	}
	
	var _input:MInputField;
	var _window:MWindowedContainer<String>;
	
	function onOKClick(event:MouseEvent)
	{
		_topGraphics.clear();
		_window.close(_input.text);
	}
	
	function onKeyDown(event:KeyboardEvent)
	{
		if (event.keyCode == Keyboard.ESCAPE)
		{
			_window.close(null);
		}
		else if (event.keyCode == Keyboard.ENTER)
		{
			_window.close(_input.text);
		}
	}
	
	function onWindowClose(event:CWindowEvent<String>)
	{
		_input = null;
		_window = null;
		_topGraphics.clear();
		
		var data = event.data;
		if (data == null || data == "")
		{
			return;
		}
		
		var tf = MFormatFactory.LABEL.newFixed(false);
		tf.x = _x;
		tf.y = _y;
		tf.width = _width;
		tf.height = _height;
		tf.text = data;
		tf.wordWrap = true;
		_image.addChild(tf);
	}
}