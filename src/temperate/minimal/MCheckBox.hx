package temperate.minimal;
import temperate.components.CButtonState;
import temperate.components.CRasterFixedButton;
import temperate.minimal.graphics.MCommonBdFactory;

class MCheckBox extends CRasterFixedButton
{
	public function new() 
	{
		super();
			
		getState(CButtonState.UP)
			.setBitmapData(MCommonBdFactory.getCheckBoxBgUp())
			.setFormat(MFormatFactory.LABEL)
			;
		getState(CButtonState.OVER)
			.setBitmapData(MCommonBdFactory.getCheckBoxBgUp())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DOWN)
			.setBitmapData(MCommonBdFactory.getCheckBoxBgDown())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DISABLED)
			.setBitmapData(MCommonBdFactory.getCheckBoxBgUp())
			.setAlpha(.5)
			.setFormat(MFormatFactory.LABEL_DISABLED)
			;
		getState(CButtonState.UP_SELECTED)
			.setBitmapData(MCommonBdFactory.getCheckBoxBgUpSelected())
			;
		getState(CButtonState.OVER_SELECTED)
			.setBitmapData(MCommonBdFactory.getCheckBoxBgUpSelected())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DOWN_SELECTED)
			.setBitmapData(MCommonBdFactory.getCheckBoxBgDownSelected())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DISABLED_SELECTED)
			.setBitmapData(MCommonBdFactory.getCheckBoxBgUpSelected())
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setAlpha(.5)
			.setFormat(MFormatFactory.LABEL_DISABLED)
			;
		
		toggle = true;
	}
}