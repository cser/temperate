package temperate.minimal;
import temperate.components.CButtonState;
import temperate.components.CRasterImageButton;
import temperate.minimal.graphics.MCommonBdFactory;

class MImageButton extends CRasterImageButton
{
	public function new() 
	{
		super();
		
		getState(CButtonState.UP)
			.setBitmapData(MCommonBdFactory.getButtonBgUp())
			.setFormat(MFormatFactory.BUTTON_UP)
			;
		getState(CButtonState.OVER)
			.setBitmapData(MCommonBdFactory.getButtonBgUp())
			.setFilters(MFilterFactory.LIGHT)
			.setFormat(MFormatFactory.BUTTON_OVER)
			;
		getState(CButtonState.DOWN)
			.setBitmapData(MCommonBdFactory.getButtonBgDown())
			.setFilters(MFilterFactory.LIGHT)
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setTextOffset(1, 1)
			.setBgOffset(1, 1, 1, 1)
			;
		getState(CButtonState.DISABLED)
			.setBitmapData(MCommonBdFactory.getButtonBgDown())
			.setAlpha(.5)
			.setFormat(MFormatFactory.BUTTON_DISABLED)
			;
		getState(CButtonState.UP_SELECTED)
			.setBitmapData(MCommonBdFactory.getButtonBgUpSelected())
			;
		getState(CButtonState.OVER_SELECTED)
			.setBitmapData(MCommonBdFactory.getButtonBgUpSelected())
			.setFilters(MFilterFactory.LIGHT)
			.setFormat(MFormatFactory.BUTTON_OVER)
			;
		getState(CButtonState.DOWN_SELECTED)
			.setBitmapData(MCommonBdFactory.getButtonBgDownSelected())
			.setFilters(MFilterFactory.LIGHT)
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setTextOffset(1, 1)
			.setBgOffset(1, 1, 1, 1)
			;
		getState(CButtonState.DISABLED_SELECTED)
			.setBitmapData(MCommonBdFactory.getButtonBgDownSelected())
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setAlpha(.5)
			.setFormat(MFormatFactory.BUTTON_DISABLED)
			;
		getImage(CButtonState.OVER).setFilters(MFilterFactory.LIGHT);
		getImage(CButtonState.DOWN).setFilters(MFilterFactory.LIGHT);
		getImage(CButtonState.DISABLED).setAlpha(.5);
		getImage(CButtonState.OVER_SELECTED).setFilters(MFilterFactory.LIGHT);
		getImage(CButtonState.DOWN_SELECTED).setFilters(MFilterFactory.LIGHT);
		getImage(CButtonState.DISABLED_SELECTED).setAlpha(.5);
	}	
}