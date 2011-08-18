package temperate.docks;

import haxe.PosInfos;
import massive.munit.Assert;

class RightDockTest
{
	public function new()
	{
	}
	
	@Test
	public function commonSizeAreBigerThanMinimalCase()
	{
		var dock = new CRightDock(2, 0);
		dock.arrange(1000, 1001, 10, 20, 100, 50);
		Assert.areEqual(1000, dock.width);
		Assert.areEqual(1001, dock.height);
		Assert.areEqual(0, dock.mainX);
		Assert.areEqual(0, dock.mainY);
		Assert.areEqual(12, dock.targetX);
		Assert.areEqual(0, dock.targetY);
		
		var dock = new CRightDock(2, .5);
		
		dock.arrange(1000, 1010, 10, 20, 100, 50);
		Assert.areEqual(1000, dock.width);
		Assert.areEqual(1010, dock.height);
		Assert.areEqual(0, dock.mainX);
		Assert.areEqual((1010 - 20) / 2, dock.mainY);
		Assert.areEqual(12, dock.targetX);
		Assert.areEqual((1010 - 50) / 2, dock.targetY);
		
		dock.arrange(1000, 1010, 10, 50, 100, 20);
		Assert.areEqual(1000, dock.width);
		Assert.areEqual(1010, dock.height);
		Assert.areEqual(0, dock.mainX);
		Assert.areEqual((1010 - 50) / 2, dock.mainY);
		Assert.areEqual(12, dock.targetX);
		Assert.areEqual((1010 - 20) / 2, dock.targetY);
	}
	
	@Test
	public function commonSizeIsSmallerThanMin_mastBeCorrected()
	{
		var dock = new CRightDock(2, 0);
		
		dock.arrange(112, 1001, 10, 20, 100, 50);
		assertSize(112, 1001, dock);
		assertMainXY(0, 0, dock);
		assertTargetXY(12, 0, dock);
		
		dock.arrange(111, 1001, 10, 20, 100, 50);
		assertSize(112, 1001, dock);
		assertMainXY(0, 0, dock);
		assertTargetXY(12, 0, dock);
		
		dock.arrange(113, 1001, 10, 20, 100, 50);
		assertSize(113, 1001, dock);
		
		dock.arrange(0, 0, 10, 20, 100, 50);
		assertSize(112, 50, dock);
		
		dock.arrange(1001, 50, 10, 20, 100, 50);
		assertSize(1001, 50, dock);
		
		dock.arrange(1001, 50, 10, 20, 100, 50);
		assertSize(1001, 50, dock);
		
		dock.arrange(1001, 49, 10, 20, 100, 50);
		assertSize(1001, 50, dock);
		
		dock.arrange(1001, 51, 10, 20, 100, 50);
		assertSize(1001, 51, dock);
		
		var dock = new CRightDock(2, .5);
		
		dock.arrange(111, 1010, 10, 20, 100, 50);
		assertSize(112, 1010, dock);
		assertMainXY(0, (1010 - 20) >> 1, dock);
		assertTargetXY(12, (1010 - 50) >> 1, dock);
		
		dock.arrange(112, 1010, 10, 20, 100, 50);
		assertSize(112, 1010, dock);
		assertMainXY(0, (1010 - 20) >> 1, dock);
		assertTargetXY(12, (1010 - 50) >> 1, dock);
		
		dock.arrange(113, 1001, 10, 20, 100, 50);
		assertSize(113, 1001, dock);
		
		dock.arrange(1000, 49, 10, 50, 100, 20);
		assertSize(1000, 50, dock);
		assertMainXY(0, 0, dock);
		assertTargetXY(12, 15, dock);
		
		dock.arrange(1000, 50, 10, 50, 100, 20);
		assertSize(1000, 50, dock);
		assertMainXY(0, 0, dock);
		assertTargetXY(12, 15, dock);
		
		dock.arrange(1000, 51, 10, 50, 100, 20);
		assertSize(1000, 51, dock);
	}
	
	@Test
	public function ifHeightMoreThanMinHeight_mainAndTargetAreAlignedByCommonHeight()
	{
		var dock = new CRightDock(2, .5);
		
		dock.arrange(0, 40, 30, 20, 20, 10);
		Assert.areEqual(40, dock.height);
		Assert.areEqual(10, dock.mainY);
		Assert.areEqual(15, dock.targetY);
	}
	
	@Test
	public function noTargetMode_compactCases()
	{
		var dock = new CRightDock(2, 0);
		dock.noTargetMode = true;
		
		dock.arrange(0, 0, 100, 50, 200, 300);
		assertSize(100, 50, dock);
		assertMainXY(0, 0, dock);
		assertTargetXY(0, 0, dock);
	}
	
	@Test
	public function noTargetMode_expandCases()
	{
		var dock = new CRightDock(2, 0);
		dock.noTargetMode = true;
		
		dock.arrange(99, 49, 100, 50, 200, 300);
		assertSize(100, 50, dock);
		
		dock.arrange(100, 50, 100, 50, 200, 300);
		assertSize(100, 50, dock);
		
		dock.arrange(101, 49, 100, 50, 200, 300);
		assertSize(101, 50, dock);
		
		dock.arrange(99, 51, 100, 50, 200, 300);
		assertSize(100, 51, dock);
		
		dock.arrange(101, 51, 100, 50, 200, 300);
		assertSize(101, 51, dock);
	}
	
	@Test
	public function noTargetMode_alignYTakedInToAccountInThisModeToo()
	{
		var dock = new CRightDock(2, .5);
		dock.noTargetMode = true;
		
		dock.arrange(100, 60, 100, 50, 200, 300);
		assertSize(100, 60, dock);
		assertMainXY(0, 5, dock);
		assertTargetXY(0, 0, dock);
		
		dock.arrange(100, 70, 100, 50, 200, 300);
		assertSize(100, 70, dock);
		assertMainXY(0, 10, dock);
		assertTargetXY(0, 0, dock);
	}
	
	@Test
	public function noTargetMode_mainNotMovedByX()
	{
		var dock = new CRightDock(2, .5);
		dock.noTargetMode = true;
		
		dock.arrange(150, 50, 100, 50, 200, 300);
		Assert.areEqual(0, dock.mainX);
	}
	
	@Test
	public function noTargetMode_switchCases()
	{
		var dock = new CRightDock(2, .5);
		
		dock.arrange(0, 0, 100, 50, 200, 300);
		assertSize(100 + 2 + 200, 300, dock);
		assertMainXY(0, 125, dock);
		assertTargetXY(100 + 2, 0, dock);
		
		dock.noTargetMode = true;
		
		dock.arrange(0, 0, 100, 50, 200, 300);
		assertSize(100, 50, dock);
		assertMainXY(0, 0, dock);
		assertTargetXY(0, 0, dock);
		
		dock.noTargetMode = false;
		
		dock.arrange(0, 0, 100, 300, 200, 50);
		assertSize(100 + 2 + 200, 300, dock);
		assertMainXY(0, 0, dock);
		assertTargetXY(100 + 2, 125, dock);
		
		dock.noTargetMode = true;
		
		dock.arrange(0, 0, 100, 50, 200, 300);
		assertSize(100, 50, dock);
		assertMainXY(0, 0, dock);
		assertTargetXY(0, 0, dock);
	}
	
	function assertSize(expectedWidth:Int, expectedHeight:Int, dock:ICDock, ?info:PosInfos)
	{
		Assert.areEqual(expectedWidth, dock.width, info);
		Assert.areEqual(expectedHeight, dock.height, info);
	}
	
	function assertMainXY(expectedX:Int, expectedY:Int, dock:ICDock, ?info:PosInfos)
	{
		Assert.areEqual(expectedX, dock.mainX, info);
		Assert.areEqual(expectedY, dock.mainY, info);
	}
	
	function assertTargetXY(expectedX:Int, expectedY:Int, dock:ICDock, ?info:PosInfos)
	{
		Assert.areEqual(expectedX, dock.targetX, info);
		Assert.areEqual(expectedY, dock.targetY, info);
	}
}