package temperate.components;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import massive.munit.Assert;
import temperate.skins.CNullRectSkin;

class CSliderTest
{
	public function new()
	{
	}
	
	var _log:Array<String>;
	
	@Before
	public function setUp():Void
	{
		_log = [];
	}
	
	@After
	public function tearDown():Void
	{
		
	}
	
	@Test
	public function thumbPositionChange_onValueSetted()
	{
		for (horizontal in [ true, false ])
		{
			var slider = new TestSlider(horizontal);
			
			if (horizontal)
			{
				slider.setSize(100 + slider.thumb.width, 0);
			}
			else
			{
				slider.setSize(0, 100 + slider.thumb.height);
			}
			slider.setValues(0, 100, 50);
			slider.validate();
			Assert.areEqual(50, horizontal ? slider.thumb.x : slider.thumb.y);
		}
	}
	
	@Test
	public function thumbPositionChange_onSizeChange()
	{
		for (horizontal in [ true, false ])
		{
			var slider = new TestSlider(horizontal);
			
			if (horizontal)
			{
				slider.setSize(100 + slider.thumb.width, 0);
			}
			else
			{
				slider.setSize(0, 100 + slider.thumb.height);
			}
			slider.setValues(0, 100, 50);
			slider.validate();
			Assert.areEqual(50, horizontal ? slider.thumb.x : slider.thumb.y);
			
			if (horizontal)
			{
				slider.width = 200 + slider.thumb.width;
			}
			else
			{
				slider.height = 200 + slider.thumb.height;
			}
			slider.validate();
			Assert.areEqual(100, horizontal ? slider.thumb.x : slider.thumb.y);
		}
	}
	
	@Test
	public function noEventDispatchedOnValueChange()
	{
		for (horizontal in [ true, false ])
		{
			var slider = new TestSlider(horizontal);
			slider.setValues(0, 100, 50);
			slider.validate();// Just for certainty
			slider.addEventListener(Event.CHANGE, onChange);
			slider.addEventListener(Event.COMPLETE, onComplete);
			slider.value = 50;
			ArrayAssert.areEqual([], _log);
		}
	}
	
	@Test
	public function onThumbMoveEventDispatched()
	{
		for (horizontal in [ true, false ])
		{
			var slider = new TestSlider(horizontal);
			Lib.current.addChild(slider);
			
			_log = [];
			
			slider.setValues(0, 100, 50);
			slider.setSize(100, 100);
			slider.validate();
			slider.addEventListener(Event.CHANGE, onChange);
			slider.addEventListener(Event.COMPLETE, onComplete);
			slider.thumb.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, true));
			if (horizontal)
			{
				slider.thumb.x = 10;
			}
			else
			{
				slider.thumb.y = 10;
			}
			slider.thumb.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE, true));
			ArrayAssert.areEqual(["change"], _log);
			
			slider.thumb.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true));
			ArrayAssert.areEqual(["change", "complete"], _log);
			
			Lib.current.removeChild(slider);
		}
	}
	
	function onChange(event:Event)
	{
		_log.push("change");
	}
	
	function onComplete(event:Event)
	{
		_log.push("complete");
	}
}
class TestSlider extends CSlider
{
	public function new(horizontal:Bool)
	{
		thumb = new ACButton();
		thumb.setSize(10, 20);
		super(horizontal, thumb, CNullRectSkin.getInstance());
	}
	
	public var thumb(default, null):ACButton;
}