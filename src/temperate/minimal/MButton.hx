package temperate.minimal;
import temperate.components.CButtonState;
import temperate.components.CRasterScaledButton;

class MButton extends CRasterScaledButton
{
	public function new() 
	{
		super();
		
		getState(CButtonState.UP)
			.setBitmapData(MBitmapDataFactory.getButtonBgUp())
			.setFormat(MFormatFactory.BUTTON_UP)
			;
		getState(CButtonState.OVER)
			.setBitmapData(MBitmapDataFactory.getButtonBgUp())
			.setFilters(MFilterFactory.LIGHT)
			.setFormat(MFormatFactory.BUTTON_OVER)
			;
		getState(CButtonState.DOWN)
			.setBitmapData(MBitmapDataFactory.getButtonBgDown())
			.setFilters(MFilterFactory.LIGHT)
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setTextOffset(1, 1)
			.setBgOffset(1, 1, 1, 1)
			;
		getState(CButtonState.DISABLED)
			.setBitmapData(MBitmapDataFactory.getButtonBgDown())
			.setAlpha(.5)
			.setFormat(MFormatFactory.BUTTON_DISABLED)
			;
		getState(CButtonState.UP_SELECTED)
			.setBitmapData(MBitmapDataFactory.getButtonBgUpSelected())
			;
		getState(CButtonState.OVER_SELECTED)
			.setBitmapData(MBitmapDataFactory.getButtonBgUpSelected())
			.setFilters(MFilterFactory.LIGHT)
			.setFormat(MFormatFactory.BUTTON_OVER)
			;
		getState(CButtonState.DOWN_SELECTED)
			.setBitmapData(MBitmapDataFactory.getButtonBgDownSelected())
			.setFilters(MFilterFactory.LIGHT)
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setTextOffset(1, 1)
			.setBgOffset(1, 1, 1, 1)
			;
		getState(CButtonState.DISABLED_SELECTED)
			.setBitmapData(MBitmapDataFactory.getButtonBgDownSelected())
			.setFormat(MFormatFactory.BUTTON_OVER)
			.setAlpha(.5)
			.setFormat(MFormatFactory.BUTTON_DISABLED)
			;
	}	
}