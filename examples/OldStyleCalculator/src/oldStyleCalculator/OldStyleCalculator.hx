package oldStyleCalculator;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.Lib;
import flash.text.TextFormatAlign;
import temperate.components.ACButton;
import temperate.components.CSpacer;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.MButton;
import temperate.minimal.MFlatButton;
import temperate.minimal.MInputField;
import temperate.minimal.MTooltipFactory;
import temperate.minimal.renderers.MTextTooltip;
import temperate.text.CTextFormat;

class OldStyleCalculator extends Sprite
{
	static function main() 
	{
		var sprite = new OldStyleCalculator();
		Lib.current.addChild(sprite);
		sprite.init();
	}
	
	function new()
	{
		super();
	}
	
	var _mainContainer:CVBox;
	var _screen:MInputField;
	var _controller:Controller;
	
	function init()
	{
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		_mainContainer = new CVBox();
		_mainContainer.setIndents(5, 5, 5, 5);
		addChild(_mainContainer);
		
		{
			var format = new CTextFormat("Verdana", 20, 0x505050, true, true);
			format.align = TextFormatAlign.RIGHT;
			
			_screen = new MInputField();
			_screen.editable = false;
			_screen.format = format;
			_mainContainer.add(_screen).setPercents(100);
		}
		
		var line = new CHBox();
		_mainContainer.add(line).setPercents(100);
		
		var button = new MButton();
		button.text = "Backspace";
		button.addEventListener(MouseEvent.CLICK, onBackspaceClick);
		MTooltipFactory.newText(button, "Delete last symbol").setTooltipMethod(newTextTooltip);
		line.add(button).setPercents(100);
		
		var button = new MButton();
		button.text = "CE";
		button.selected = true;
		button.addEventListener(MouseEvent.CLICK, onCEClick);
		MTooltipFactory.newText(button, "Clear current number\nwithout clear other operations")
			.setTooltipMethod(newTextTooltip);
		line.add(button).setPercents(100);
		
		var button = new MButton();
		button.text = "C";
		button.selected = true;
		button.addEventListener(MouseEvent.CLICK, onCClick);
		MTooltipFactory.newText(button, "Reset calculator").setTooltipMethod(newTextTooltip);
		line.add(button).setPercents(100);
		
		{
			var line = new CHBox();
			_mainContainer.add(line).setPercents(100);
			
			line.add(newSymbolButton("1")).setPercents(100);
			line.add(newSymbolButton("2")).setPercents(100);
			line.add(newSymbolButton("3")).setPercents(100);
			line.add(newOperationButton(Operation.PLUS)).setPercents(100);
		}
		
		{
			var line = new CHBox();
			_mainContainer.add(line).setPercents(100);
			
			line.add(newSymbolButton("4")).setPercents(100);
			line.add(newSymbolButton("5")).setPercents(100);
			line.add(newSymbolButton("6")).setPercents(100);
			line.add(newOperationButton(Operation.MINUS)).setPercents(100);
		}
		
		{
			var line = new CHBox();
			_mainContainer.add(line).setPercents(100);
			
			line.add(newSymbolButton("7")).setPercents(100);
			line.add(newSymbolButton("8")).setPercents(100);
			line.add(newSymbolButton("9")).setPercents(100);
			line.add(newOperationButton(Operation.MULTIPLY)).setPercents(100);
		}
		
		{
			var line = new CHBox();
			_mainContainer.add(line).setPercents(100);
			
			line.add(newSymbolButton(".")).setPercents(100);
			line.add(newSymbolButton("0")).setPercents(100);
			
			var button = new MFlatButton();
			button.text = "=";
			button.selected = true;
			button.addEventListener(MouseEvent.CLICK, onCalculateClick);
			line.add(button).setPercents(100);
			
			line.add(newOperationButton(Operation.DIVIDE)).setPercents(100);
		}
		
		_mainContainer.add(new CSpacer()).setPercents( -1, 100);
		
		_controller = new Controller();
		_controller.screenChanged.add(onScreenChanged);
		onScreenChanged();
		
		stage.addEventListener(Event.RESIZE, onResize);
		onResize();
	}
	
	function newTextTooltip()
	{
		var tooltip = new MTextTooltip();
		tooltip.filters = [ new DropShadowFilter(4, 45, 0x000000, .5) ];
		return tooltip;
	}
	
	function onResize(event:Event = null)
	{
		_mainContainer.width = stage.stageWidth;
		_mainContainer.height = stage.stageHeight;
	}
	
	function newSymbolButton(symbol:String):ACButton
	{
		var button = new MFlatButton();
		button.text = symbol;
		button.addEventListener(MouseEvent.CLICK, callback(onSymbolClick, symbol));
		return button;
	}
	
	function newOperationButton(operation:Operation):ACButton
	{
		var button = new MFlatButton();
		button.text = operation.sign;
		button.selected = true;
		button.addEventListener(MouseEvent.CLICK, callback(onOperationClick, operation));
		return button;
	}
	
	function onScreenChanged()
	{
		_screen.text = _controller.screen;
	}
	
	function onSymbolClick(symbol:String, event:Event)
	{
		_controller.addSymbol(symbol);
	}
	
	function onOperationClick(operation:Operation, event:Event)
	{
		_controller.addOperation(operation);
	}
	
	function onCalculateClick(event:Event)
	{
		_controller.calculate();
	}
	
	function onBackspaceClick(event:Event)
	{
		_controller.backspace();
	}
	
	function onCEClick(event:Event)
	{
		_controller.clearCurrent();
	}
	
	function onCClick(event:Event)
	{
		_controller.resetAll();
	}
}