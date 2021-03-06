package ;

import massive.munit.TestSuite;

class MainTestSuite extends TestSuite
{
	public function new()
	{
		super();
		add(ArrayAssertTest);
		add(FakeTimerFactoryTest);
		add(temperate.collections.CHashTest);
		add(temperate.collections.CObjectHashStringTest);
		add(temperate.collections.CObjectHashTest);
		add(temperate.collections.CObjectSetTest);
		add(temperate.collections.CPriorityListTest);
		add(temperate.collections.CValueStackTest);
		add(temperate.components.CButtonSelectorTest);
		add(temperate.components.CNumericStepperTest);
		add(temperate.components.CRasterScaledButtonTest);
		add(temperate.components.CScrollBarScrollParamsTest);
		add(temperate.components.CScrollBarTest);
		add(temperate.components.CSliderTest);
		add(temperate.containers.CHContainerChildManagmentTest);
		add(temperate.containers.CVContainerChangeLayoutByChildManagmentTest);
		add(temperate.containers.CVContainerTest);
		add(temperate.core.ArrayUtilTest);
		add(temperate.core.CGeomUtilTest);
		add(temperate.core.CMathTest);
		add(temperate.core.CMouseWheelUtilTest);
		add(temperate.core.CValidatorTest);
		add(temperate.docks.RightDockTest);
		add(temperate.extra.CEventDispatcherUtilTest);
		add(temperate.extra.CSignalActionInListenerTest);
		add(temperate.extra.CSignalActionInVoidListenerTest);
		add(temperate.extra.CSignalTest);
		add(temperate.extra.CSignalVoidListenersTest);
		add(temperate.layouts.CScrollLayoutTest);
		add(temperate.minimal.charts.MChartTest);
		add(temperate.text.CInputFieldTest);
		add(temperate.text.CLabelTest);
		add(temperate.text.CTextFormatTest);
		add(temperate.tooltips.docks.CHTooltipDockTest);
		add(temperate.tooltips.docks.CVTooltipDockTest);
		add(temperate.tooltips.managers.CTooltipManagerTest);
		add(temperate.windows.CWindowManagerTest);
	}
}