package windowApplication.states;
import flash.events.MouseEvent;
import flash.text.TextField;
import temperate.containers.CVBox;
import temperate.minimal.MButton;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MInputField;
import temperate.minimal.MPopUpManager;
import temperate.minimal.MWindow;
import temperate.minimal.MWindowedContainer;

class TextDrawState extends ADrawState
{
	public function new() 
	{
		super();
	}
	
	var _x:Float;
	var _y:Float;
	
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
		_input = new MInputField();
		var container = new CVBox();
		container.setCompact(false, true);
		container.add(_input).setPercents(100);
		_window = new MWindowedContainer(container, "Text");
		_window.setSize(200, 0);
		_window.addCloseButton();
		_window.resizable = true;
		var button = new MButton();
		button.text = "OK";
		button.addEventListener(MouseEvent.CLICK, onOKClick);
		container.add(button).setAlign(1);
		MPopUpManager.add(_window, true);
	}
	
	var _input:MInputField;
	var _window:MWindowedContainer<CVBox>;
	
	function onOKClick(event:MouseEvent)
	{
		_topGraphics.clear();
		if (_input.text != null && _input.text != "")
		{
			var tf = MFormatFactory.LABEL.newFixed(false);
			tf.x = _x;
			tf.y = _y;
			tf.width = _image.mouseX - _x;
			tf.height = _image.mouseY - _y;
			tf.text = _input.text;
			tf.wordWrap = true;
			_image.addChild(tf);
			_input = null;
		}
		_window.close();
	}
}