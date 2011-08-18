package temperate.minimal;
import temperate.components.CButtonState;
import temperate.components.CRasterFixedButton;

class MCheckBox extends CRasterFixedButton
{
	public function new() 
	{
		super();
			
		getState(CButtonState.UP)
			.setBitmapData(MBitmapDataFactory.getCheckBoxBgUp())
			.setFormat(MFormatFactory.LABEL)
			;
		getState(CButtonState.OVER)
			.setBitmapData(MBitmapDataFactory.getCheckBoxBgUp())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DOWN)
			.setBitmapData(MBitmapDataFactory.getCheckBoxBgDown())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DISABLED)
			.setBitmapData(MBitmapDataFactory.getCheckBoxBgUp())
			.setAlpha(.5)
			.setFormat(MFormatFactory.LABEL_DISABLED)
			;
		getState(CButtonState.UP_SELECTED)
			.setBitmapData(MBitmapDataFactory.getCheckBoxBgUpSelected())
			;
		getState(CButtonState.OVER_SELECTED)
			.setBitmapData(MBitmapDataFactory.getCheckBoxBgUpSelected())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DOWN_SELECTED)
			.setBitmapData(MBitmapDataFactory.getCheckBoxBgDownSelected())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DISABLED_SELECTED)
			.setBitmapData(MBitmapDataFactory.getCheckBoxBgUpSelected())
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setAlpha(.5)
			.setFormat(MFormatFactory.LABEL_DISABLED)
			;
		
		toggle = true;
	}
}