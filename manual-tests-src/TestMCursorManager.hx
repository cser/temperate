package ;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.Vector;
import temperate.collections.ICValueSwitcher;
import temperate.components.ACButton;
import temperate.components.CButtonSelector;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.cursors.CCursor;
import temperate.cursors.ICCursor;
import temperate.minimal.cursors.MForbiddenCursor;
import temperate.minimal.cursors.MHandCursor;
import temperate.minimal.cursors.MResizeCursor;
import temperate.minimal.cursors.MWaitCursor;
import temperate.minimal.graphics.MCursorBdFactory;
import temperate.minimal.MButton;
import temperate.minimal.MCheckBox;
import temperate.minimal.MCursorManager;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MRadioButton;

class TestMCursorManager extends Sprite
{
	static var NATIVE_WAIT = "nativeWait";
	static var NATIVE_ANIMATED = "nativeAnimated";
	
	public function new() 
	{
		super();
	}
	
	var _defaultCursorSelector:CButtonSelector<ICCursor>;
	var _handCursorCheckBox:ACButton;
	var _handCursorSwitcher:ICValueSwitcher<ICCursor>;
	
	public function init()
	{
		var main = new CVBox().addTo(this, 10, 10);
		var line = new CHBox().addTo(main);
		
		{
			var box = new CVBox();
			line.add(box);
			
			box.add(MFormatFactory.LABEL
				.newAutoSized(false, "Default cursor\n(priority = int.MIN_VALUE)"));
			
			_defaultCursorSelector = new CButtonSelector(MCursorManager.defaultCursor, true);
			_defaultCursorSelector.addEventListener(Event.CHANGE, onDefaultCursorChange);
			
			var button = new MRadioButton().setText("null");
			_defaultCursorSelector.add(button, null);
			box.add(button);
			
			var button = new MRadioButton().setText("Star");
			_defaultCursorSelector.add(
				button, new CCursor().setView(getStar(), true).setHideSystem(true));
			box.add(button);
			
			var button = new MRadioButton().setText("Star with system cursor");
			_defaultCursorSelector.add(button, new CCursor().setView(getStar(), true, 20, 20));
			box.add(button);
			
			var button = new MRadioButton().setText("Torus with system cursor");
			_defaultCursorSelector.add(button, new CCursor().setView(newTorus(), true, 20, 28));
			box.add(button);
			
			var button = new MRadioButton().setText("Torus without update on move");
			_defaultCursorSelector.add(button, new CCursor().setView(newTorus(), false, 20, 28));
			box.add(button);
		}
		
		{
			var container = new Sprite();
			line.add(container);
			
			container.addChild(MFormatFactory.LABEL
				.newAutoSized(false, "Hover cursors\n(priority = 0)"));
			
			var button = new MButton();
			button.setTextIndents(5, 5, 10, 5);
			button.setTextAlign(0, 0);
			button.text = "Red torus";
			button.addTo(container, 0, 30);
			button.setSize(100, 100);
			button.validate();// For correct size calculating by native (_not_ temperate) Sprite
							  // It's unnecessary (and _bad_ for _performance_) to called validate()
							  // in normal cases!
			MCursorManager.newHover().setTarget(button)
				.setValue(new CCursor().setView(newTorus(0xff0000), true, 20, 28));
				
			var button = new MButton();
			button.text = "Crimson torus";
			button.addTo(container, 50, 60);
			button.setSize(100, 100);
			button.validate();
			MCursorManager.newHover().setTarget(button)
				.setValue(new CCursor().setView(newTorus(0xff00ff), true, 20, 28));
		}
		
		line.add(new PriorityBlock("Switcher\n(priority = 0)", 0));
		line.add(new PriorityBlock("Switcher\n(priority = <b>1</b>)", 1));
		
		var line = new CHBox().addTo(main);
		
		{	
			var box = new CVBox().addTo(line);
			var button = new MButton().setText("Hand cursor\nwith down state\nDOWN MOUSE HEAR");
			box.add(button);
			MCursorManager.newHover().setTarget(button).setValue(new MHandCursor(true));
			
			box.add(new Bitmap(MCursorBdFactory.getHandUp()));
			box.add(new Bitmap(MCursorBdFactory.getHandDown()));
			
			_handCursorCheckBox = new MCheckBox()
				.setText("Enable hand cursor\nwith system cusor visible").addTo(box);
			_handCursorCheckBox.addEventListener(Event.CHANGE, onHandCursorCheckBoxChange);
			_handCursorSwitcher = MCursorManager.newSwitcher()
				.setValue(new MHandCursor(true, false));
		}
		
		{	
			var box = new CVBox().addTo(line);
			
			box.add(new Bitmap(MCursorBdFactory.getForbidden()));
			box.add(new Bitmap(MCursorBdFactory.getResize()));
			
			var button = new MButton().setText("Forbidden cursor").addTo(box);
			MCursorManager.newHover().setTarget(button).setValue(new MForbiddenCursor(true));
			
			var button = new MButton().setText("Resize cursor").addTo(box);
			MCursorManager.newHover().setTarget(button).setValue(new MResizeCursor(true));
			
			box.add(new Bitmap(MCursorBdFactory.getWait()));
			
			var button = new MButton().setText("Wait cursor").addTo(box);
			button.setSize(100, 100);
			MCursorManager.newHover().setTarget(button).setValue(new MWaitCursor(true));
		}
		
		{
			#if flash10_2
			
			var box = new CVBox().addTo(line);
			
			{
				var data = new Vector();
				data[0] = MCursorBdFactory.getWait();
				MCursorManager.addNative(NATIVE_WAIT, data, 1, new Point(10, 10));
				
				var button = new MButton()
					.setText("Native flashplayer 10.2 cursor\nneed -swf-version 10.2 parameter")
					.addTo(box);
				MCursorManager.newHover()
					.setTarget(button)
					.setValue(new CCursor().setSystem(NATIVE_WAIT));
			}
			
			{
				var data = {
					var data = new Vector();
					var shape = new Shape();
					var g = shape.graphics;
					for (i in 0 ... 50)
					{
						var angle = i * 2 * Math.PI / 50;
						var sin = Math.sin(angle);
						g.clear();
						g.lineStyle(0, 0x000000);
						g.beginFill(0x808080);
						g.drawCircle(15, 15, 2 + 12 * sin);
						g.drawCircle(15, 15, 2 + 12 * sin - 4);
						g.endFill();
						
						var bitmapData = new BitmapData(30, 30, true, 0x00000000);
						bitmapData.draw(shape);
						data[i] = bitmapData;
					}
					data;
				}
				MCursorManager.addNative(NATIVE_ANIMATED, data, 30, new Point(10, 10));
				
				var button = new MButton()
					.setText("Native animated\nflashplayer 10.2 cursor")
					.addTo(box);
				MCursorManager.newHover()
					.setTarget(button)
					.setValue(new CCursor().setSystem(NATIVE_ANIMATED));
			}
			
			#end
		}
	}
	
	function onDefaultCursorChange(event:Event)
	{
		MCursorManager.defaultCursor = _defaultCursorSelector.value;
	}
	
	function onHandCursorCheckBoxChange(event:Event)
	{
		if (_handCursorCheckBox.selected)
		{
			_handCursorSwitcher.on();
		}
		else
		{
			_handCursorSwitcher.off();
		}
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Example cursor views
	//
	//----------------------------------------------------------------------------------------------
	
	function newTorus(color:UInt = 0x808080)
	{
		var torus = new Shape();
		var g = torus.graphics;
		g.lineStyle(0, 0x000000);
		g.beginFill(color);
		g.drawCircle(0, 0, 10);
		g.drawCircle(0, 0, 5);
		g.endFill();
		return torus;
	}
	
	var _star:Shape;
	
	function getStar()
	{
		if (_star == null)
		{
			_star = new Shape();
			var g = _star.graphics;
			g.lineStyle(0, 0x000000);
			
			var point = getStarPoint(0);
			g.moveTo(point.x, point.y);
			g.beginFill(0xffff00);
			for (i in 0 ... 10)
			{
				var point = getStarPoint(3 + i * 3);
				g.lineTo(point.x, point.y);
			}
			g.endFill();
		}
		return _star;
	}
	
	function getStarPoint(index:Int)
	{
		var angle = Math.PI * .5 + 2 * Math.PI * index / 10;
		return new Point(Math.cos(angle) * 10, Math.sin(angle) * 10);
	}
}

class PriorityBlock extends CVBox
{
	var _selector:CButtonSelector<ICCursor>;
	var _switcher:ICValueSwitcher<ICCursor>;
	var _isOnCheckBox:ACButton;
	
	public function new(title:String, priority:Int)
	{
		super();
		
		_switcher = MCursorManager.newSwitcher(priority);
		
		var tf = MFormatFactory.LABEL.newAutoSized();
		tf.htmlText = title;
		add(tf);
		
		_isOnCheckBox = new MCheckBox().setText("Is on");
		_isOnCheckBox.selected = false;
		_isOnCheckBox.addEventListener(Event.CHANGE, onIsOnChange);
		add(_isOnCheckBox);
		
		_selector = new CButtonSelector(null, true);
		_selector.addEventListener(Event.CHANGE, onSelectorChange);
			
		var button = new MRadioButton().setText("null");
		_selector.add(button, null);
		add(button);
			
		var button = new MRadioButton().setText("Circle");
		_selector.add(button, new CCursor().setView(newCircle(), true).setHideSystem(true));
		add(button);
		
		var button = new MRadioButton().setText("Red circle");
		_selector.add(button, new CCursor().setView(newCircle(0xff0000), true).setHideSystem(true));
		add(button);
	}
	
	function onSelectorChange(event:Event)
	{
		_switcher.value = _selector.value;
	}
	
	function onIsOnChange(event:Event)
	{
		if (_isOnCheckBox.selected)
		{
			_switcher.on();
		}
		else
		{
			_switcher.off();
		}
	}
	
	function newCircle(color:UInt = 0x808080)
	{
		var shape = new Shape();
		var g = shape.graphics;
		g.lineStyle(0, 0x000000);
		g.beginFill(color);
		g.drawCircle(0, 0, 10);
		g.endFill();
		return shape;
	}
}