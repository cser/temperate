package temperate.core;

import massive.munit.Assert;

/**
 * So difficult to take a mistake here.
 * This test was made just for documentation
 */
class CMouseWheelUtilTest
{
	public function new()
	{
	}
	
	@Test
	public function deltaIsDecreasedByRatio()
	{
		Assert.areEqual(3, CMouseWheelUtil.getDimDelta(3, 1));
		Assert.areEqual(1, CMouseWheelUtil.getDimDelta(3, 3));
		Assert.areEqual(1, CMouseWheelUtil.getDimDelta(1, 1));
		Assert.areEqual(2, CMouseWheelUtil.getDimDelta(4, 2));
		
		Assert.areEqual( -3, CMouseWheelUtil.getDimDelta( -3, 1));
		Assert.areEqual( -1, CMouseWheelUtil.getDimDelta( -3, 3));
		
		Assert.areEqual(2, CMouseWheelUtil.getDimDelta(3, 2));
		Assert.areEqual( -2, CMouseWheelUtil.getDimDelta( -3, 2));
	}
	
	@Test
	public function absoluteValueOfDecreasedDeltaCantBeLessThan1()
	{
		Assert.areEqual(1, CMouseWheelUtil.getDimDelta(1, 2));
		Assert.areEqual(1, CMouseWheelUtil.getDimDelta(1, 3));
		
		Assert.areEqual(1, CMouseWheelUtil.getDimDelta(3, 4));
		Assert.areEqual(1, CMouseWheelUtil.getDimDelta(3, 5));
		Assert.areEqual(1, CMouseWheelUtil.getDimDelta(3, 10));
		
		Assert.areEqual( -1, CMouseWheelUtil.getDimDelta( -1, 3));
		Assert.areEqual( -1, CMouseWheelUtil.getDimDelta( -3, 10));
	}
	
	@Test
	public function zeroOrNegativeDimRationParameterIsWrong_itsReplacedBy1()
	{
		Assert.areEqual(10, CMouseWheelUtil.getDimDelta(10, 0));
		Assert.areEqual(5, CMouseWheelUtil.getDimDelta(5, -1));
		Assert.areEqual(-10, CMouseWheelUtil.getDimDelta(-10, 0));
		Assert.areEqual(-5, CMouseWheelUtil.getDimDelta(-5, -1));
	}
}