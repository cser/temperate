package ;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Lib;
import flash.utils.Timer;
import temperate.components.ACButton;
import temperate.containers.CHBox;
import temperate.minimal.MButton;
import temperate.minimal.renderers.MTextTooltip;
import temperate.tooltips.CTooltipOwner;
import temperate.tooltips.managers.CTooltipManager;
import temperate.tooltips.docks.CHTooltipDock;
import temperate.tooltips.docks.ICTooltipDock;
import temperate.tooltips.tooltipers.CForcedTargetTooltiper;
import temperate.tooltips.tooltipers.CMouseTooltiper;
import temperate.tooltips.tooltipers.CTargetMouseTooltiper;
import temperate.tooltips.tooltipers.CTargetTooltiper;
import temperate.tooltips.tooltipers.ICTooltiper;

class TestTooltipsOld extends Sprite
{
	public function new() 
	{
		super();
	}
	
	var _targetTooltiper:CTargetTooltiper<String>;
	var _manager:CTooltipManager;
	var _owner:CTooltipOwner;
	var _timer:Timer;
	
	public function init()
	{
		// For check by compiller
		[ 
			ICTooltipDock, ICTooltiper, CForcedTargetTooltiper, CMouseTooltiper,
			CTargetMouseTooltiper, CTargetTooltiper, CTooltipManager
		];
		
		_owner = new CTooltipOwner(new Sprite());
		_manager = new CTooltipManager();
		
		{
			var hBox = new CHBox();
			hBox.y = 80;
			addChild(hBox);
			
			var button = new MButton().setText("Target tooltip");
			hBox.add(button).setPercents(100, 100);
			new CTargetTooltiper(_owner, _manager).setTarget(button)
				.setTooltipClass(MTextTooltip)
				.setData("Target tooltip 0");
				
			var button = new MButton().setText("Target tooltip");
			hBox.add(button).setPercents(100, 100);
			new CTargetTooltiper(_owner, _manager).setTarget(button)
				.setTooltipClass(MTextTooltip)
				.setData("Target tooltip 1");
			
			var button = new MButton().setText("Target tooltip\nwith horizontal dock");
			hBox.add(button).setPercents(100, 100);
			var tooltiper = new CTargetTooltiper(_owner, _manager).setTarget(button);
			tooltiper.setTooltipClass(MTextTooltip);
			tooltiper.setData("Target tooltip\nwith horizontal dock");
			tooltiper.setDock(new CHTooltipDock());
			
			var button = new MButton().setText("Target tooltip\nthat data changed");
			hBox.add(button).setPercents(100, 100);
			_targetTooltiper = new CTargetTooltiper(_owner, _manager);
			_targetTooltiper.setTarget(button)
				.setTooltipClass(MTextTooltip)
				.setData("Target tooltip\nthat data changed");
			_timer = new Timer(100);
			_timer.addEventListener(TimerEvent.TIMER, targetTooltiper_onTimer);
			_timer.start();
			
			hBox.add(new MButton().setText("Button without tooltip")).setPercents(100, 100);
		}
		
		{
			var button = new MButton().setText("Mouse tooltip\nbutton").addTo(this, 600, 0);
			button.setSize(100, 100);
			button.addEventListener(MouseEvent.ROLL_OVER, mouseTooltipButton_onRollOver);
			button.addEventListener(MouseEvent.ROLL_OUT, mouseTooltipButton_onRollOut);
			
			_mouseTooltiper = new CMouseTooltiper(_owner, _manager);
		}
		
		{
			var button = new MButton().setText("Target mouse\nbutton").addTo(this, 600, 200);
			var tooltiper = new CTargetMouseTooltiper(_owner, _manager)
				.setTarget(button)
				.setTooltipClass(MTextTooltip)
				.setData("Target mouse\n button tooltip");
			tooltiper.showDelay = 0;
			tooltiper.hideDelay = 1000;
			tooltiper.secondShowTimeout = 10;
		}
		
		{
			_forsedTargetTooltipButton = new MButton()
				.setText("Forsed target\ntooltip button")
				.addTo(this, 600, 300);
			_forsedTargetTooltipButton.addEventListener(
				MouseEvent.MOUSE_OVER, manualTarget_onMouseOver
			);
			_forsedTargetTooltipButton.addEventListener(
				MouseEvent.MOUSE_OUT, manualTarget_onMouseOut
			);
			_forcedTargetTooltiper = new CForcedTargetTooltiper(_owner, _manager);
		}
		
		_owner.setArea(0, 0, stage.stageWidth, stage.stageHeight);
		addChild(_owner.container);
		
		drawMTooltipRenderers();
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
	
	function targetTooltiper_onTimer(event:TimerEvent)
	{
		_targetTooltiper.setData(Std.string(Std.int(Math.exp((Lib.getTimer() * .01) % 20))));
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
	
	function drawMTooltipRenderers()
	{
		drawMTooltipRenderersByCoords(
			200, 410,
			[
				new Point( -100, -100),	new Point(0, -100),	new Point(100, -100),
				new Point( -100, 0),	new Point(0, 0),	new Point(100, 0),	
				new Point( -100, 100),	new Point(0, 100),	new Point(100, 100)
			]
		);
		drawMTooltipRenderersByCoords(
			500, 410,
			[
				new Point( -50, -100),	new Point(50, -100),
				new Point( -50, 100),	new Point(50, 100),
				new Point( -100, -50),	new Point(100, -50),
				new Point( -100, 50),	new Point(100, 50)
			]
		);
		drawMTooltipRenderersByCoords(
			200, 250,
			[
				new Point( -40, -100), new Point( -30, -100), new Point( -20, -100),
				new Point( -10, -100), new Point(0, -100), new Point(10, -100),
				new Point(20, -100), new Point(30, -100), new Point(40, -100),
				
				new Point( -40, 100), new Point( -30, 100), new Point( -20, 100),
				new Point( -10, 100), new Point(0, 100), new Point(10, 100),
				new Point(20, 100), new Point(30, 100), new Point(40, 100),
				
				new Point( -100, -40), new Point( -100, -30), new Point( -100, -20),
				new Point( -100, -10), new Point( -100, 0), new Point( -100, 10),
				new Point( -100, 20), new Point( -100, 30), new Point( -100, 40),
				
				new Point(100, -40), new Point(100, -30), new Point(100, -20),
				new Point(100, -10), new Point(100, 0), new Point(100, 10),
				new Point(100, 20), new Point(100, 30), new Point(100, 40)
			]
		);
	}
	
	function drawMTooltipRenderersByCoords(centerX:Int, centerY:Int, coords:Array<Point>)
	{
		var sprite:Sprite = new Sprite();
		sprite.x = centerX;
		sprite.y = centerY;
		addChild(sprite);
		
		var button = new MButton().addTo(sprite, -25, -25);
		button.width = 50;
		button.height = 50;
		
		for (point in coords)
		{
			var renderer = new MTextTooltip();
			renderer.fillColor = 0x80ffffff;
			renderer.borderColor = 0xff508000;
			renderer.initData("Some text");
			renderer.x = point.x - renderer.width * .5;
			renderer.y = point.y * .5 - renderer.height * .5;
			renderer.setTailTarget(new Rectangle(
				button.x - renderer.x,
				button.y - renderer.y,
				button.width,
				button.height
			));
			sprite.addChild(renderer);
		}
	}
}