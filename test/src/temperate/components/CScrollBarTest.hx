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
		var owner = new ScrollBarOwner(true);
		var scrollBar = owner.scrollBar;
		
		scrollBar.width = 100;
		
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
class ScrollBarOwner
{
	public static var ARROW_WIDTH:Int;
	public static var ARROW_HEIGHT:Int;
	public static var THUMB_MIN_SIZE:Int;
	
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