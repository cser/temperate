package temperate.tooltips.docks;

import flash.geom.Rectangle;
import haxe.PosInfos;
import massive.munit.Assert;

class CVTooltipDockTest
{
	public function new()
	{
	}
	
	function getVertical():Bool
	{
		return true;
	}
	
	function assertDock(expectedA:Int, expectedB:Int, dock:ICTooltipDock, ?info:PosInfos)
	{
		if (getVertical())
		{
			Assert.areEqual(expectedA, dock.rendererX, info);
			Assert.areEqual(expectedB, dock.rendererY, info);
		}
		else
		{
			Assert.areEqual(expectedB, dock.rendererX, info);
			Assert.areEqual(expectedA, dock.rendererY, info);
		}
	}
	
	function arrange(
		dock:ICTooltipDock, targetA:Int, targetB:Int, targetSizeA:Int, targetSizeB:Int,
		ownerSizeA:Int, ownerSizeB:Int, rendererSizeA:Int, rendererSizeB:Int
	)
	{
		var vertical = getVertical();
		dock.arrange(
			vertical ? 
				new Rectangle(targetA, targetB, targetSizeA, targetSizeB) :
				new Rectangle(targetB, targetA, targetSizeB, targetSizeA),
			vertical ? ownerSizeA : ownerSizeB,
			vertical ? ownerSizeB : ownerSizeA,
			vertical ? rendererSizeA : rendererSizeB,
			vertical ? rendererSizeB : rendererSizeA
		);
	}
	
	function newDock():ACLineTooltipDock
	{
		return new CVTooltipDock();
	}
	
	function newDefaultBottomDock():ACLineTooltipDock
	{
		return new CVTooltipDock().setDefaultTop(false);
	}
	
	@Test
	public function positionWithoutConstraintsIsTop()
	{
		var dock = newDock().setIndent(20);
		arrange(dock, 500 - 50, 400 - 25, 100, 50, 1000, 800, 120, 80);
		assertDock(500 - 60, 400 - 25 - 20 - 80, dock);
	}
	
	@Test
	public function cases()
	{
		var dock = newDock().setIndent(10);
		
		{
			arrange(dock, 0, 30, 20, 10, 60, 80, 40, 10);
			assertDock(0, 10, dock);
			
			arrange(dock, 40, 30, 20, 10, 60, 80, 40, 10);
			assertDock(20, 10, dock);
			
			arrange(dock, 0, 20, 20, 10, 60, 80, 40, 10);
			assertDock(0, 0, dock);
			
			arrange(dock, 40, 20, 20, 10, 60, 80, 40, 10);
			assertDock(20, 0, dock);
		}
		
		{
			arrange(dock, 0, 19, 20, 10, 60, 80, 40, 10);
			assertDock(0, 39, dock);
			
			arrange(dock, 10, 19, 20, 10, 60, 80, 40, 10);
			assertDock(0, 39, dock);
			
			arrange(dock, 11, 19, 20, 10, 60, 80, 40, 10);
			assertDock(1, 39, dock);
			
			arrange(dock, 29, 19, 20, 10, 60, 80, 40, 10);
			assertDock(19, 39, dock);
			
			arrange(dock, 30, 19, 20, 10, 60, 80, 40, 10);
			assertDock(20, 39, dock);
			
			arrange(dock, 40, 19, 20, 10, 60, 80, 40, 10);
			assertDock(20, 39, dock);
		}
	}
	
	@Test
	public function ifTopAndBottomSpaceIsNotAnough_tooltipMovesToLargestSpace()
	{
		var dock = newDock().setIndent(10);
		
		arrange(dock, 20, 29, 10, 10, 50, 69, 30, 20);
		assertDock(10, 49, dock);
		
		arrange(dock, 20, 29, 10, 10, 50, 68, 30, 20);
		assertDock(10, 0, dock);
		
		arrange(dock, 20, 28, 10, 10, 50, 68, 30, 20);
		assertDock(10, 48, dock);
		
		{
			arrange(dock, 20, 24, 10, 10, 50, 60, 30, 20);
			assertDock(10, 40, dock);
			
			arrange(dock, 20, 25, 10, 10, 50, 60, 30, 20);
			assertDock(10, 0, dock);
			
			arrange(dock, 20, 26, 10, 10, 50, 60, 30, 20);
			assertDock(10, 0, dock);
		}
	}
	
	@Test
	public function defaultBottomCases()
	{
		var dock = newDefaultBottomDock().setIndent(10);
		
		arrange(dock, 500 - 50, 400 - 25, 100, 50, 1000, 800, 120, 80);
		assertDock(500 - 60, 400 + 25 + 10, dock);
		
		arrange(dock, 500 - 50, 400 - 25, 100, 50, 1000, 400 + 25 + 10 + 80, 120, 80);
		assertDock(500 - 60, 400 + 25 + 10, dock);
		
		arrange(dock, 500 - 50, 400 - 25, 100, 50, 1000, 400 + 25 + 10 + 79, 120, 80);
		assertDock(500 - 60, 400 - 25 - 10 - 80, dock);
		
		{
			arrange(dock, 20, 24, 10, 10, 50, 60, 30, 20);
			assertDock(10, 40, dock);
			
			arrange(dock, 20, 25, 10, 10, 50, 60, 30, 20);
			assertDock(10, 40, dock);
			
			arrange(dock, 20, 26, 10, 10, 50, 60, 30, 20);
			assertDock(10, 0, dock);
		}
	}
}