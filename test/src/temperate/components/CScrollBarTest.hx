package temperate.components;

import massive.munit.Assert;
import temperate.skins.CNullScrollSkin;

class CScrollBarTest
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
	public function ifDeltaValueIsNotPositive_thumIsInvisible()
	{
		for (horizontal in [ true, false ])
		{
			var owner = new ScrollBarOwner(horizontal);
			var scrollBar = owner.scrollBar;
			
			if (horizontal)
			{
				scrollBar.width = 100;
			}
			else
			{
				scrollBar.height = 100;
			}
			
			scrollBar.minValue = 1;
			scrollBar.maxValue = 1;
			scrollBar.validate();
			Assert.areEqual(false, owner.thumb.visible);
			
			scrollBar.minValue = 1;
			scrollBar.maxValue = 100;
			scrollBar.validate();
			Assert.areEqual(true, owner.thumb.visible);
		}
	}
	
	@Test
	public function thumbSizeChaningOnParametersChangeCases()
	{
		var owner = new ScrollBarOwner(true);
		var scrollBar = owner.scrollBar;
		
		scrollBar.width = 100;
		scrollBar.minValue = 1;
		scrollBar.maxValue = 10;
		scrollBar.pageSize = 5;
		scrollBar.validate();
		Assert.areEqual(
			Std.int((scrollBar.width - ScrollBarOwner.ARROW_WIDTH * 2) * (5 / (9 + 5))),
			owner.thumb.width
		);
		scrollBar.maxValue = 9;
		scrollBar.validate();
		Assert.areEqual(
			Std.int((scrollBar.width - ScrollBarOwner.ARROW_WIDTH * 2) * (5 / (8 + 5))),
			owner.thumb.width
		);
	}
	
	@Test
	public function thumbPositionChaningOnParametersChangeCases()
	{
		var owner = new ScrollBarOwner(true);
		var scrollBar = owner.scrollBar;
		
		scrollBar.width = 1000;
		scrollBar.minValue = 1;
		scrollBar.pageSize = 5;
		
		scrollBar.maxValue = 50;
		scrollBar.value = 50;
		scrollBar.validate();
		var expectedThumbSize = Std.int(
			(scrollBar.width - ScrollBarOwner.ARROW_WIDTH * 2) * (5 / (49 + 5)));
		Assert.areEqual(expectedThumbSize, owner.thumb.width);
		Assert.areEqual(
			scrollBar.width - ScrollBarOwner.ARROW_WIDTH - expectedThumbSize, owner.thumb.x);
		
		scrollBar.maxValue = 10;
		scrollBar.validate();
		var expectedThumbSize = Std.int(
			(scrollBar.width - ScrollBarOwner.ARROW_WIDTH * 2) * (5 / (9 + 5)));
		Assert.areEqual(expectedThumbSize, owner.thumb.width);
		Assert.areEqual(
			scrollBar.width - ScrollBarOwner.ARROW_WIDTH - expectedThumbSize, owner.thumb.x);
	}
}
class ScrollBarOwner
{
	public static var ARROW_WIDTH:Int = 20;
	public static var ARROW_HEIGHT:Int = 15;
	public static var THUMB_MIN_SIZE:Int = 10;
	
	public function new(horizontal:Bool)
	{
		left = new FakeButton(ARROW_WIDTH, ARROW_HEIGHT);
		right = new FakeButton(ARROW_WIDTH, ARROW_HEIGHT);
		thumb = new FakeButton(
			horizontal ? THUMB_MIN_SIZE : ARROW_WIDTH,
			horizontal ? ARROW_WIDTH : THUMB_MIN_SIZE
		);
		scrollBar = new CScrollBar(horizontal, left, right, thumb, CNullScrollSkin.getInstance());
	}
	
	public var scrollBar(default, null):CScrollBar;
	public var thumb(default, null):ACButton;
	public var left(default, null):ACButton;
	public var right(default, null):ACButton;
}