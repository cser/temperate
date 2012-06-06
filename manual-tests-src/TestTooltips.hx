package ;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.components.ACButton;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.animators.MAlphaAnimator;
import temperate.minimal.animators.MScaleAnimator;
import temperate.minimal.MButton;
import temperate.minimal.MLabel;
import temperate.minimal.renderers.MTextTooltip;
import temperate.tooltips.CTooltipOwner;
import temperate.tooltips.managers.CSimpleTooltipManager;
import temperate.tooltips.managers.CTooltipManager;
import temperate.tooltips.tooltipers.CForcedTargetTooltiper;
import temperate.tooltips.tooltipers.CMouseTooltiper;
import temperate.tooltips.tooltipers.CTargetMouseTooltiper;
import temperate.tooltips.tooltipers.CTargetTooltiper;
import testTooltips.TestTooltip;

class TestTooltips extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _owner:CTooltipOwner;
	
	public function init()
	{
		var main = new CVBox().addTo(this, 10, 100);
		
		var line = new CHBox().addTo(main);
		
		_owner = new CTooltipOwner(this);
		stage.addEventListener(Event.RESIZE, onStageResize);
		onStageResize();
		
		var manager = new CSimpleTooltipManager();
		
		{
			var button = new MButton();
			button.text = "Null animator";
			button.setSize(100, 100);
			line.add(button);
			
			new CTargetTooltiper(_owner, manager)
				.setTooltipClass(TestTooltip)
				.setData("Tooltip text text text text text")
				.setTarget(button);
		}
		
		{
			var button = new MButton();
			button.text = "Alpha animator";
			button.setSize(100, 100);
			line.add(button);
			
			new CTargetTooltiper(_owner, manager)
				.setTooltipClass(TestTooltip)
				.setAnimator(new MAlphaAnimator())
				.setData("Tooltip text")
				.setTarget(button);
		}
		
		{
			var button = new MButton();
			button.text = "Scale animator\n(custom tooltip)";
			button.setSize(100, 100);
			line.add(button);
			
			new CTargetTooltiper(_owner, manager)
				.setTooltipMethod(newCustomTooltip)
				.setAnimator(new MScaleAnimator())
				.setData("Tooltip text")
				.setTarget(button);
		}
		
		var button = newScaleAnimatorButton(TestTooltip);
		line.add(button);
		
		var button = newScaleAnimatorButton(TestTooltip);
		button.addTo(this, 150, 0);
		
		var button = newScaleAnimatorButton(MTextTooltip);
		button.addTo(this, 350, 0);
		
		{
			var outer = newBlock(500, 0, 100, 100, 0x0000ff);
			addChild(outer);
			
			var inner = newBlock(20, 15, 50, 20, 0x0080ff);
			outer.addChild(inner);
			
			var manager = new CTooltipManager();
			
			new CTargetTooltiper(_owner, manager)
				.setTooltipClass(MTextTooltip)
				.setAnimator(new MScaleAnimator())
				.setData("Outer tooltip")
				.setTarget(outer);
			
			new CTargetTooltiper(_owner, manager)
				.setTooltipClass(MTextTooltip)
				.setAnimator(new MScaleAnimator())
				.setData("Inner tooltip")
				.setTarget(inner);
		}
		
		var column = new CVBox().addTo(line);
		column.add(new MLabel().setText("secondShowDelay = 0"));
		column.add(newDelayedBlock(0, false));
		column.add(new MLabel().setText("secondShowDelay = 50"));
		column.add(newDelayedBlock(50, false));
		column.add(new MLabel().setText("Custom delays"));
		column.add(newDelayedBlock(0, true));
		
		var line = new CHBox().addTo(main);
		
		{
			var button = new MButton();
			button.text = "Mouse target\ntooltiper\n(scale)";
			button.setSize(100, 100);
			line.add(button);
			
			new CTargetMouseTooltiper(_owner, manager)
				.setTooltipMethod(newCustomTooltip)
				.setAnimator(new MScaleAnimator())
				.setData("Tooltip text")
				.setTarget(button);
		}
		
		{
			var button = new MButton();
			button.text = "Mouse target\ntooltiper\n(alpha)";
			button.setSize(100, 100);
			line.add(button);
			
			new CTargetMouseTooltiper(_owner, manager)
				.setTooltipMethod(newCustomTooltip)
				.setAnimator(new MAlphaAnimator())
				.setData("Tooltip text")
				.setTarget(button);
		}
		
		var manager = new CTooltipManager();
		
		{
			_forsedTargetTooltipButton = new MButton()
				.setText("Forsed target\ntooltip button")
				.addTo(line);
			_forsedTargetTooltipButton.addEventListener(
				MouseEvent.MOUSE_OVER, manualTarget_onMouseOver
			);
			_forsedTargetTooltipButton.addEventListener(
				MouseEvent.MOUSE_OUT, manualTarget_onMouseOut
			);
			_forcedTargetTooltiper = new CForcedTargetTooltiper(_owner, manager);
		}
		
		{
			var button = new MButton().setText("Mouse\ntooltip button").addTo(line);
			button.setSize(100, 100);
			button.addEventListener(MouseEvent.ROLL_OVER, mouseTooltipButton_onRollOver);
			button.addEventListener(MouseEvent.ROLL_OUT, mouseTooltipButton_onRollOut);
			
			_mouseTooltiper = new CMouseTooltiper(_owner, manager);
		}
	}
	
	function onStageResize(event:Event = null)
	{
		_owner.setArea(10, 20, stage.stageWidth - 20, stage.stageHeight - 40);
	}
	
	function newCustomTooltip()
	{
		var tooltip = new MTextTooltip();
		tooltip.borderColor = 0xff0000ff;
		tooltip.fillColor = 0x80eeeeff;
		return tooltip;
	}
	
	function newDelayedBlock(secondShowDelay:Int, useCustomDelays:Bool)
	{
		var block = new CHBox();
		
		var manager = new CTooltipManager();
		manager.showDelay = 300;
		manager.hideDelay = 100;
		manager.secondShowDelay = secondShowDelay;
		manager.secondShowTimeout = 200;
		
		var button = new MButton().setText("Delayed");
		block.add(button);
		var tooltiper = new CTargetTooltiper(_owner, manager)
			.setTooltipClass(MTextTooltip)
			.setAnimator(new MScaleAnimator())
			.setData("Hint text")
			.setTarget(button);
		if (useCustomDelays)
		{
			tooltiper.setDelays(0, 0, 0, null);
		}
		
		var button = new MButton().setText("Delayed");
		block.add(button);
		var tooltiper = new CTargetTooltiper(_owner, manager)
			.setTooltipClass(MTextTooltip)
			.setAnimator(new MScaleAnimator())
			.setData("Hint text")
			.setTarget(button);
		if (useCustomDelays)
		{
			tooltiper.setDelays(500, 50, 0, 0);
		}
		
		var button = new MButton().setText("Delayed");
		block.add(button);
		var tooltiper = new CTargetTooltiper(_owner, manager)
			.setTooltipClass(MTextTooltip)
			.setAnimator(new MScaleAnimator())
			.setData("Hint text")
			.setTarget(button);
		if (useCustomDelays)
		{
			tooltiper.setDelays(500, 100, 0, null);
		}
		
		return block;
	}
	
	function newBlock(x:Int, y:Int, width:Int, height:Int, color:Int):Sprite
	{
		var block = new Sprite();
		block.x = x;
		block.y = y;
		
		var g = block.graphics;
		g.beginFill(color);
		g.drawRect(0, 0, width, height);
		g.endFill();
		
		return block;
	}
	
	function newScaleAnimatorButton(tooltipClass)
	{
		var button = new MButton();
		button.text = "Scale animator";
		button.setSize(100, 100);
		
		new CTargetTooltiper(_owner, new CSimpleTooltipManager())
			.setTooltipClass(tooltipClass)
			.setAnimator(new MScaleAnimator())
			.setData("Tooltip text")
			.setTarget(button);
		
		return button;
	}
	
	var _forsedTargetTooltipButton:ACButton;
	var _forcedTargetTooltiper:CForcedTargetTooltiper;
	
	function manualTarget_onMouseOver(event:MouseEvent)
	{
		_forcedTargetTooltiper.showClass(_forsedTargetTooltipButton, MTextTooltip, "Tooltip");
	}
	
	function manualTarget_onMouseOut(event:MouseEvent)
	{
		_forcedTargetTooltiper.hide();
	}
	
	var _mouseTooltiper:CMouseTooltiper;
	
	function mouseTooltipButton_onRollOver(event:Event)
	{
		_mouseTooltiper.showClass(MTextTooltip, "Tooltip");
	}
	
	function mouseTooltipButton_onRollOut(event:Event)
	{
		_mouseTooltiper.hide();
	}
}