package minimal;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.utils.Timer;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.MBitmapDataFactory;
import temperate.minimal.MButton;
import temperate.minimal.MTooltipFactory;
import temperate.minimal.renderers.MTextTooltip;
import temperate.minimal.renderers.MTooltipBg;
import temperate.tooltips.tooltipers.CTargetTooltiper;
import temperate.tooltips.renderers.ACTooltip;

class TestMTooltips extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _targetTooltiper:CTargetTooltiper<String>;
	var _timer:Timer;
	
	public function init()
	{
		var vBox = new CVBox();
		vBox.y = 80;
		addChild(vBox);
		
		{
			var hBox = new CHBox();
			vBox.addChild(hBox);
			
			var button = new MButton().setText("Target tooltip 1");
			hBox.add(button).setPercents(100, 100);
			MTooltipFactory.newText(button, "Target tooltip 0");
				
			var button = new MButton().setText("Target tooltip 0");
			hBox.add(button).setPercents(100, 100);
			MTooltipFactory.newText(button, "Target tooltip 1");
			
			var button = new MButton().setText("Target tooltip\nwith horizontal dock");
			hBox.add(button).setPercents(100, 100);
			MTooltipFactory.newText(button, "Target tooltip\nwith horizontal dock")
				.setDock(MTooltipFactory.DOCK_HORIZONTAL_RIGHT);
			
			var button = new MButton().setText("Mouse-moved text");
			hBox.add(button).setPercents(100, 100);
			MTooltipFactory.newTextMoused(button, "Mouse-moved text");
			
			var button = new MButton().setText("Mouse-moved text\nwith left dock");
			hBox.add(button).setPercents(100, 100);
			MTooltipFactory.newTextMoused(button, "Mouse-moved text\nwith left dock")
				.setDock(MTooltipFactory.DOCK_HORIZONTAL_LEFT);
				
			_focedTooltipButton = new MButton();
			_focedTooltipButton.setText("Forced target\ntoolitp");
			hBox.add(_focedTooltipButton).setPercents(100, 100);
				
			_focedTooltipButton.addEventListener(MouseEvent.ROLL_OVER, focedTooltipButton_onRollOver);
			_focedTooltipButton.addEventListener(MouseEvent.ROLL_OUT, focedTooltipButton_onRollOut);
		}
		
		var button = new MButton().setText("Moused tooltiper");
		button.width = 100;
		button.height = 100;
		button.addEventListener(MouseEvent.ROLL_OVER, onMousedButtonRollOver);
		button.addEventListener(MouseEvent.ROLL_OUT, onMousedButtonRollOut);
		vBox.add(button);
	}
	
	function onMousedButtonRollOver(event:MouseEvent)
	{
		MTooltipFactory.showMoused(MTextTooltip, "Moused tooltip");
	}
	
	function onMousedButtonRollOut(event:MouseEvent)
	{
		MTooltipFactory.hideMoused();
	}
	
	var _focedTooltipButton:MButton;
	
	function focedTooltipButton_onRollOver(event:MouseEvent)
	{
		MTooltipFactory.showForced(
			_focedTooltipButton, TestTooltip, MBitmapDataFactory.getButtonBgUp());
	}
	
	function focedTooltipButton_onRollOut(event:MouseEvent)
	{
		MTooltipFactory.hideForced();
	}
}
class TestTooltip extends ACTooltip<BitmapData>
{
	public function new()
	{
		super();
		
		_bg = new MTooltipBg();
		addChild(_bg);
		
		_bitmap = new Bitmap();
		addChild(_bitmap);
	}
	
	var _bg:MTooltipBg;
	var _bitmap:Bitmap;
	
	override public function initData(data:BitmapData)
	{
		_bitmap.bitmapData = data;
		_bitmap.x = 10;
		_bitmap.y = 10;
		_width = _bitmap.width + 20;
		_height = _bitmap.height + 20;
		onResize(Std.int(_width), Std.int(_height));
	}
	
	override public function setTailTarget(target:Rectangle)
	{
		_bg.redraw(_width, _height, target);
	}
}