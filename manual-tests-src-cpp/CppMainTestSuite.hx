package ;
import massive.munit.TestSuite;

class CppMainTestSuite extends TestSuite
{
	public function new() 
	{
		super();
		add(temperate.core.CMathTest);
		add(temperate.core.ArrayUtilTest);
		add(temperate.collections.CHashTest);
		add(temperate.collections.CObjectHashTest);
		add(temperate.collections.CObjectSetTest);
		add(temperate.collections.CPriorityListTest);
		add(temperate.collections.CValueStackTest);
		add(temperate.containers.CVContainerTest);
		add(temperate.containers.CVContainerChangeLayoutByChildManagmentTest);
		add(temperate.containers.CHContainerChildManagmentTest);
		add(temperate.extra.CSignalTest);
		add(ArrayAssertTest);
		add(FakeTimerFactoryTest);
		add(temperate.components.CButtonSelectorTest);
		add(temperate.components.CRasterScaledButtonTest);
		add(temperate.components.CScrollBarTest);
		add(temperate.core.CMouseWheelUtilTest);
		add(temperate.core.CValidatorTest);
		add(temperate.core.CGeomUtilTest);
		add(temperate.extra.CSignalActionInListenerTest);
		add(temperate.extra.CSignalActionInVoidListenerTest);
		add(temperate.extra.CSignalVoidListenersTest);
		add(temperate.extra.EventDispatcherUtilTest);
		add(temperate.docks.RightDockTest);
		add(temperate.text.CTextFormatTest);
		add(temperate.minimal.charts.MChartTest);
		add(temperate.tooltips.docks.CHTooltipDockTest);
		add(temperate.tooltips.docks.CVTooltipDockTest);
		add(temperate.tooltips.managers.CTooltipManagerTest);
		//add(temperate.windows.CWindowManagerTest);
		//add(temperate.components.CNumericStepperTest);
		//add(temperate.components.CSliderTest);
		//add(temperate.components.CScrollBarScrollParamsTest);// Выключается
		//add(temperate.layouts.CScrollLayoutTest);
		//add(temperate.text.CInputFieldTest);// Minor errors
		//add(temperate.text.CLabelTest);// Minor errors
	}
}