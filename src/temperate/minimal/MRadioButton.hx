package temperate.minimal;
import temperate.components.CButtonState;
import temperate.components.CRasterFixedButton;

class MRadioButton extends CRasterFixedButton
{
	public function new() 
	{
		super();
		
		getState(CButtonState.UP)
			.setBitmapData(MBitmapDataFactory.getRadioButtonBgUp())
			.setFormat(MFormatFactory.LABEL)
			;
		getState(CButtonState.OVER)
			.setBitmapData(MBitmapDataFactory.getRadioButtonBgUp())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DOWN)
			.setBitmapData(MBitmapDataFactory.getRadioButtonBgDown())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DISABLED)
			.setBitmapData(MBitmapDataFactory.getRadioButtonBgUp())
			.setAlpha(.5)
			.setFormat(MFormatFactory.LABEL_DISABLED)
			;
		getState(CButtonState.UP_SELECTED)
			.setBitmapData(MBitmapDataFactory.getRadioButtonBgUpSelected())
			;
		getState(CButtonState.OVER_SELECTED)
			.setBitmapData(MBitmapDataFactory.getRadioButtonBgUpSelected())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DOWN_SELECTED)
			.setBitmapData(MBitmapDataFactory.getRadioButtonBgDownSelected())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DISABLED_SELECTED)
			.setBitmapData(MBitmapDataFactory.getRadioButtonBgUpSelected())
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setAlpha(.5)
			.setFormat(MFormatFactory.LABEL_DISABLED)
			;
	}	
}