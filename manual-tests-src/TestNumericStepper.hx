package ;
import flash.display.Sprite;
import flash.events.Event;
import temperate.components.CNumericStepper;
import temperate.components.helpers.CSmoothTimerChanger;
import temperate.components.helpers.CTimerChanger;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.graphics.MCommonBdFactory;
import temperate.minimal.MButton;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MLabel;
import temperate.minimal.MNumericStepper;
import temperate.minimal.MTooltipFactory;
import temperate.skins.CRaster9GridRectSkin;
import temperate.skins.CSkinState;
import temperate.text.CLabel;

class TestNumericStepper extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var main = new CVBox();
		main.y = 50;
		addChild(main);
		
		{
			var box = new CHBox();
			main.addChild(box);
			
			var stepper = newNumericStepper().setValues( -10, 100);
			MTooltipFactory.newText(stepper, "CNumericStepper\n(clumsy skinned)")
				.setHideOnMouseDown(false);
			box.add(stepper);
			
			_stepper = new MNumericStepper().setValues( -10, 100);
			_stepper.addEventListener(Event.CHANGE, onStepperChange);
			MTooltipFactory.newText(_stepper, "MNumericStepper")
				.setHideOnMouseDown(false);
			box.add(_stepper);
			_label = new MLabel();
			MTooltipFactory.newText(_label, "\"Binded\" to MNumericStepper label")
				.setHideOnMouseDown(false);
			box.add(_label).setContingencies(100).setPercents(100);
			onStepperChange();
			
			var stepper = new MNumericStepper().setValues( -10, 100);
			stepper.setCompact(true, true);
			MTooltipFactory.newText(stepper, "MNumericStepper compact").setHideOnMouseDown(false);
			box.add(stepper);
			
			var stepper = new MNumericStepper().setValues( -10, 100);
			stepper.width = 200;
			stepper.height = 100;
			MTooltipFactory.newText(stepper, "MNumericStepper resized").setHideOnMouseDown(false);
			box.add(stepper);
			
			var stepper = new MNumericStepper().setValues( -10, 100);
			stepper.setCompact(true, true);
			stepper.editable = false;
			MTooltipFactory.newText(stepper, "MNumericStepper not editable")
				.setHideOnMouseDown(false);
			box.add(stepper);
			
			var stepper = new MNumericStepper().setValues( -10, 100);
			stepper.setCompact(true, true);
			stepper.isEnabled = false;
			MTooltipFactory.newText(stepper, "MNumericStepper disabled").setHideOnMouseDown(false);
			box.add(stepper);
			
			var stepper = new MNumericStepper().setValues( -10, 100);
			stepper.setCompact(true, true);
			stepper.isEnabled = false;
			stepper.selectable = false;
			MTooltipFactory.newText(stepper, "MNumericStepper disabled\n unselectable")
				.setHideOnMouseDown(false);
			box.add(stepper);
		}
		
		{
			var box = new CHBox();
			main.addChild(box);
			
			var stepper = new MNumericStepper();
			stepper.setValueTranslators(cmTranslator, smParser, smIsCorrect);
			MTooltipFactory.newText(stepper, "MNumericStepper with sm");
			box.add(stepper);
			
			var stepper = new MNumericStepper();
			stepper.timerChanger = new CSmoothTimerChanger().setDelays(1000, 500, 10, .5);
			stepper.setValueTranslators(cmTranslator, smParser, smIsCorrect);
			MTooltipFactory.newText(stepper, "MNumericStepper with firstDelay = 1000");
			box.add(stepper);
			
			var stepper = new MNumericStepper();
			stepper.timerChanger = new CTimerChanger().setDelays(300, 10);
			stepper.setValueTranslators(cmTranslator, smParser, smIsCorrect);
			MTooltipFactory.newText(stepper, "MNumericStepper with simple timer changer");
			box.add(stepper);
			
			var stepper = new MNumericStepper();
			stepper.timerChanger = new CSmoothTimerChanger().setDelays(500, 200, 100, .5);
			stepper.setValueTranslators(cmTranslator, smParser, smIsCorrect);
			MTooltipFactory.newText(stepper, "MNumericStepper with minDelay=100");
			box.add(stepper);
		}
		
		{
			var box = new CHBox();
			main.addChild(box);
			
			var stepper = new MNumericStepper();
			stepper.useHandCursor = true;
			MTooltipFactory.newText(stepper, "MNumericStepper with useHandCursor=true");
			box.add(stepper);
		}
	}
	
	var _stepper:CNumericStepper;
	var _label:CLabel;
	
	function onStepperChange(event:Event = null)
	{
		_label.text = Std.string(_stepper.value);
	}
	
	function newNumericStepper()
	{
		var bg = new CRaster9GridRectSkin();
		bg.getState(CSkinState.NORMAL).setBitmapData(MCommonBdFactory.getTextBg());
		
		var up = new MButton();
		up.setText("+").setSize(30, 10);
		up.setTextIndents(0, 0, -1, -1);
		
		var down = new MButton();
		down.setText("–").setSize(30, 10);
		down.setTextIndents(0, 0, -1, -1);
		
		var stepper = new CNumericStepper(up, down, bg);
		stepper.formatError = MFormatFactory.LABEL.clone().setColor(0xff0000);
		return stepper;
	}
	
	function cmTranslator(value:Int)
	{
		return value + "cm";
	}
	
	function smParser(text:String)
	{
		return Std.parseInt(text);
	}
	
	function smIsCorrect(text:String)
	{
		return ~/^\-?\d*(cm)?$/.match(text);
	}
}