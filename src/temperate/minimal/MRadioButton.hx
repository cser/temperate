package temperate.minimal;
import temperate.components.CButtonState;
import temperate.components.CRasterFixedButton;
import temperate.minimal.graphics.MCommonBdFactory;

class MRadioButton extends CRasterFixedButton
{
	public function new() 
	{
		super();
		
		getState(CButtonState.UP)
			.setBitmapData(MCommonBdFactory.getRadioButtonBgUp())
			.setFormat(MFormatFactory.LABEL)
			;
		getState(CButtonState.OVER)
			.setBitmapData(MCommonBdFactory.getRadioButtonBgUp())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DOWN)
			.setBitmapData(MCommonBdFactory.getRadioButtonBgDown())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DISABLED)
			.setBitmapData(MCommonBdFactory.getRadioButtonBgUp())
			.setAlpha(.5)
			.setFormat(MFormatFactory.LABEL_DISABLED)
			;
		getState(CButtonState.UP_SELECTED)
			.setBitmapData(MCommonBdFactory.getRadioButtonBgUpSelected())
			;
		getState(CButtonState.OVER_SELECTED)
			.setBitmapData(MCommonBdFactory.getRadioButtonBgUpSelected())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DOWN_SELECTED)
			.setBitmapData(MCommonBdFactory.getRadioButtonBgDownSelected())
			.setFilters(MFilterFactory.LIGHT)
			;
		getState(CButtonState.DISABLED_SELECTED)
			.setBitmapData(MCommonBdFactory.getRadioButtonBgUpSelected())
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setAlpha(.5)
			.setFormat(MFormatFactory.LABEL_DISABLED)
			;
	}	
}