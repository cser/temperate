package ;

import massive.munit.TestSuite;

class MainTestSuite extends TestSuite
{
	public function new()
	{
		super();
		add(FakeTimerFactoryTest);
		add(temperate.collections.CLinkedStackTest);
		add(temperate.components.CButtonSelectorTest);
		add(temperate.components.CNumericStepperTest);
		add(temperate.components.CRasterScaledButtonTest);
		add(temperate.containers.CHContainerChildManagmentTest);
		add(temperate.containers.CVContainerChangeLayoutByChildManagmentTest);
		add(temperate.containers.CVContainerTest);
		add(temperate.core.CMathTest);
		add(temperate.docks.RightDockTest);
		add(temperate.minimal.charts.MChartTest);
		add(temperate.text.CInputFieldTest);
		add(temperate.text.CLabelTest);
		add(temperate.text.CTextFormatTest);
		add(temperate.tooltips.docks.CHTooltipDockTest);
		add(temperate.tooltips.docks.CVTooltipDockTest);
		add(temperate.tooltips.managers.CTooltipManagerTest);
	}
}