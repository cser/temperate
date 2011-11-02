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
			ArrayAssert.equalToArray([], _log);
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
	
	@Test
	public function valueMastBeDiscreteToStep()
	{
		for (horizontal in [ true, false ])
		{
			var slider = new TestSlider(horizontal);
			slider.step = .5;
			slider.setValues(0, 10);
			
			slider.value = .7;
			Assert.areEqual(.5, slider.value);
			
			slider.value = .5;
			Assert.areEqual(.5, slider.value);
			
			slider.value = 1;
			Assert.areEqual(1, slider.value);
			
			slider.step = .5;
			slider.setValues(.2, 10);
			
			slider.value = .7;
			Assert.areEqual(.5, slider.value);
			
			slider.value = .8;
			Assert.areEqual(1, slider.value);
			
			slider.value = .5;
			Assert.areEqual(.5, slider.value);
			
			slider.value = 1;
			Assert.areEqual(1, slider.value);
			
			slider.value = 9.8;
			Assert.areEqual(10, slider.value);
		}
	}
	
	@Test
	public function ifStepIsZeroOrNotFinite_itsIgnored()
	{
		for (horizontal in [ true, false ])
		{
			var slider = new TestSlider(horizontal);
			
			slider.step = 0;
			slider.setValues(0, 10);
			
			slider.value = .7;
			Assert.areEqual(.7, slider.value);
			
			slider.value = .758;
			Assert.areEqual(.758, slider.value);
			
			slider.step = Math.NaN;
			slider.value = 1.358;
			Assert.areEqual(1.358, slider.value);
			
			slider.step = Math.POSITIVE_INFINITY;
			slider.value = 1.358;
			Assert.areEqual(1.358, slider.value);
		}
	}
	
	@Test
	public function maxAndMinValuesMastSettedForAnyStep()
	{
		for (horizontal in [ true, false ])
		{
			var slider = new TestSlider(horizontal);
			
			slider.step = .5;
			slider.setValues(.1, 1.85);
			
			slider.value = .1;
			Assert.areEqual(.1, slider.value);
			
			slider.value = 0;
			Assert.areEqual(.1, slider.value);
			
			slider.value = 1.85;
			Assert.areEqual(1.85, slider.value);
			
			slider.value = 1.86;
			Assert.areEqual(1.85, slider.value);
			
			slider.value = 1.1;
			Assert.areEqual(1, slider.value);
			
			slider.value = 1.6;
			Assert.areEqual(1.5, slider.value);
		}
	}
}
class TestSlider extends CSlider
{
	public function new(horizontal:Bool)
	{
		thumb = new FakeEmptyButton();
		thumb.setSize(10, 20);
		super(horizontal, thumb, CNullRectSkin.getInstance());
	}
	
	public var thumb(default, null):ACButton;
}