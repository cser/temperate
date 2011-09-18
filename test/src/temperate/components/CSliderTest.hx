package temperate.components;

import massive.munit.Assert;
import temperate.skins.CNullRectSkin;

class CSliderTest
{
	public function new()
	{
	}
	
	@Before
	public function setUp():Void
	{
		
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