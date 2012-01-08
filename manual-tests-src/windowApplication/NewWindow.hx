package windowApplication;
import flash.events.MouseEvent;
import flash.geom.Point;
import temperate.containers.CHBox;
import temperate.minimal.MButton;
import temperate.minimal.MLabel;
import temperate.minimal.MNumericStepper;
import temperate.minimal.MSeparator;
import temperate.minimal.windows.AMWindow;

class NewWindow extends AMWindow<Point>
{	
	var _widthNs:MNumericStepper;
	var _heightNs:MNumericStepper;
	
	public function new() 
	{
		super();
		
		title = "New";
		
		var box = new CHBox();
		box.add(new MLabel().setText("width:"));
		_widthNs = new MNumericStepper();
		box.add(_widthNs).setAlign(1);
		_main.add(box).setPercents(100);
		
		var box = new CHBox();
		box.add(new MLabel().setText("height:"));
		_heightNs = new MNumericStepper();
		box.add(_heightNs).setAlign(1);
		_main.add(box).setPercents(100);
		
		_skin.addHeadButton(_skin.closeButton).addEventListener(MouseEvent.CLICK, onCloseClick);
		
		_widthNs.setValues(1, 1000, 600);
		_heightNs.setValues(1, 1000, 400);
		
		_main.add(new MSeparator(true)).setIndents( -2, -2).setPercents(100);
		
		var buttonBox = new CHBox();
		_main.add(buttonBox).setAlign(.5);
		
		var button = new MButton();
		button.text = "OK";
		button.addEventListener(MouseEvent.CLICK, onOkClick);
		button.selected = true;
		buttonBox.add(button);
		
		var button = new MButton();
		button.text = "Cancel";
		button.addEventListener(MouseEvent.CLICK, onCancelClick);
		buttonBox.add(button);
	}
	
	function onCloseClick(event:MouseEvent)
	{
		close(null);
	}
	
	function onOkClick(event:MouseEvent)
	{
		close(new Point(_widthNs.value, _heightNs.value));
	}
	
	function onCancelClick(event:MouseEvent)
	{
		close(null);
	}
}