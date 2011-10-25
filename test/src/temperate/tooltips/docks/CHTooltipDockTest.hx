package temperate.tooltips.docks;

import massive.munit.Assert;

class CHTooltipDockTest extends CVTooltipDockTest
{
	public function new()
	{
		super();
	}
	
	override function getVertical():Bool
	{
		return false;
	}
	
	override function newDock():ACLineTooltipDock
	{
		return new CHTooltipDock();
	}
	
	override function newDefaultBottomDock():ACLineTooltipDock
	{
		return new CHTooltipDock().setDefaultLeft(false);
	}
	
	@Test
	override public function positionWithoutConstraintsIsTop()
	{
		super.positionWithoutConstraintsIsTop();
	}
	
	@Test
	override public function cases()
	{
		super.cases();
	}
	
	@Test
	override public function ifTopAndBottomSpaceIsNotAnough_tooltipMovesToLargestSpace()
	{
		super.ifTopAndBottomSpaceIsNotAnough_tooltipMovesToLargestSpace();
	}
	
	@Test
	override public function defaultBottomCases()
	{
		super.defaultBottomCases();
	}
}