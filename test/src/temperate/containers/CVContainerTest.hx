package temperate.containers;

import flash.display.DisplayObject;
import massive.munit.Assert;
import temperate.core.CSprite;
import temperate.layouts.parametrization.CExcessSpaceMode;

class CVContainerTest
{
	public function new()
	{
	}
	
	var _container:CVBox;
	
	@Before
	public function setUp():Void
	{
		_container = new CVBox();
		_container.setCompact(true, true);
	}
	
	@After
	public function tearDown():Void
	{
		_container = null;
	}
	
	@Test
	public function emptyContainerSizeIsZero()
	{
		Assert.areEqual(_container.width, 0);
		Assert.areEqual(_container.height, 0);
	}
	
	@Test
	public function sizeIsNotIncreaseFromZeroInCompactMode()
	{
		_container.width = 10;
		Assert.areEqual(_container.width, 0);
		
		_container.height = 10;
		Assert.areEqual(_container.height, 0);
	}
	
	@Test
	public function sizeOfContainerWithOneChildEqualsThisChildSize()
	{
		var child = new CSprite();
		child.width = 100;
		child.height = 50;
		_container.addChild(child);
		Assert.areEqual(100, _container.width);
		Assert.areEqual(50, _container.height);
	}
	
	@Test
	public function sizeOfContainerWidthIndentsIsCorrect()
	{
		_container.setIndents(5, 6, 7, 8);
		Assert.areEqual(5 + 6, _container.width);
		Assert.areEqual(7 + 8, _container.height);
		
		_container.add(newSprite(100, 50));
		Assert.areEqual(5 + 100 + 6, _container.width);
		Assert.areEqual(7 + 50 + 8, _container.height);
		
		_container.gapY = 11;
		
		_container.add(newSprite(100, 60));
		Assert.areEqual(5 + 100 + 6, _container.width);
		Assert.areEqual(7 + 50 + 11 + 60 + 8, _container.height);
	}
	
	@Test
	public function sizeOfContainerWithIndentsIsCorrect_notCompactWidth()
	{
		_container.excessSpaceMode = CExcessSpaceMode.UNIFORM;
		_container.setCompact(false, true);
		_container.setIndents(5, 6, 7, 8);
		
		_container.width = 100;
		_container.height = 200;
		
		Assert.areEqual(100, _container.width);
		Assert.areEqual(7 + 8, _container.height);
		
		_container.width = 100;
		_container.height = 200;
		
		_container.add(newSprite(80, 50));
		Assert.areEqual(100, _container.width);
		Assert.areEqual(7 + 50 + 8, _container.height);
	}
	
	@Test
	public function sizeOfContainerWithIndentsIsCorrect_notCompactHeight()
	{
		var nonCompactModes:Array<CExcessSpaceMode> = [
			CExcessSpaceMode.UNIFORM, CExcessSpaceMode.INCREASE_GAPS,
			CExcessSpaceMode.MOVE_TO_EDGES(.5) ];
		for (excessSpaceMode in nonCompactModes)
		{
			_container = new CVBox();
			_container.excessSpaceMode = excessSpaceMode;
			_container.setCompact(true, false);
			_container.setIndents(5, 6, 7, 8);
			
			_container.width = 100;
			_container.height = 200;
			
			Assert.areEqual(5 + 6, _container.width);
			Assert.areEqual(200, _container.height);
			
			_container.width = 100;
			_container.height = 200;
			
			_container.add(newSprite(80, 50));
			Assert.areEqual(5 + 80 + 6, _container.width);
			Assert.areEqual(200, _container.height);
			
			_container.width = 100;
			_container.height = 200;
			_container.gapY = 11;
			
			_container.add(newSprite(80, 60));
			Assert.areEqual(5 + 80 + 6, _container.width);
			Assert.areEqual(200, _container.height);
		}
	}
	
	@Test
	public function isSizeLessThanGapY_and_notCompactHeight_sizeAreEqualToSetted()
	{
		var nonCompactModes:Array<CExcessSpaceMode> = [
			CExcessSpaceMode.UNIFORM, CExcessSpaceMode.INCREASE_GAPS,
			CExcessSpaceMode.MOVE_TO_EDGES(.5) ];
		for (excessSpaceMode in nonCompactModes)
		{
			_container = new CVBox();
			_container.excessSpaceMode = excessSpaceMode;
			_container.setCompact(true, false);
			_container.gapX = 20;
			
			_container.width = 100;
			_container.height = 19;
			
			Assert.areEqual(0, _container.width);
			Assert.areEqual(19, _container.height);
			
			_container.width = 100;
			_container.height = 1;
			
			Assert.areEqual(0, _container.width);
			Assert.areEqual(1, _container.height);
			
			_container.add(newSprite(100, 2));
			_container.width = 100;
			_container.height = 3;
			
			Assert.areEqual(100, _container.width);
			Assert.areEqual(3, _container.height);
		}
	}
	
	@Test
	public function settedSizeIsRestoreIfItPossible()
	{
		_container.setCompact(false, false);
		_container.setIndents(0, 0, 0, 0);
		_container.gapX = 0;
		_container.gapY = 0;
		_container.excessSpaceMode = CExcessSpaceMode.UNIFORM;
		
		var child = newSprite(200, 300);
		
		_container.add(child);
		Assert.areEqual(200, _container.width);
		Assert.areEqual(300, _container.height);
		
		_container.width = 100;
		_container.height = 200;
		Assert.areEqual(200, _container.width);
		Assert.areEqual(300, _container.height);
		
		_container.removeChild(child);
		Assert.areEqual(100, _container.width);
		Assert.areEqual(200, _container.height);
	}
	
	private function newSprite(width:Float, height:Float):DisplayObject
	{
		var sprite = new CSprite();
		sprite.width = width;
		sprite.height = height;
		return sprite;
	}
}