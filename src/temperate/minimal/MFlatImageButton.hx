package temperate.minimal;
import temperate.components.CButtonState;
import temperate.components.CRasterImageButton;
import temperate.minimal.graphics.MFlatBdFactory;

class MFlatImageButton extends CRasterImageButton
{
	public function new() 
	{
		super();
		getState(CButtonState.UP)
			.setBitmapData(MFlatBdFactory.getBgUp())
			.setFormat(MFormatFactory.FLAT_BUTTON_UP);
		getState(CButtonState.OVER)
			.setBitmapData(MFlatBdFactory.getBgOver())
			.setFormat(MFormatFactory.FLAT_BUTTON_OVER);
		getState(CButtonState.DOWN)
			.setBitmapData(MFlatBdFactory.getBgDown())
			.setFormat(MFormatFactory.FLAT_BUTTON_OVER)
			.setTextOffset(0, 1);
		getState(CButtonState.DISABLED)
			.setBitmapData(MFlatBdFactory.getBgDisabled())
			.setFormat(MFormatFactory.FLAT_BUTTON_DISABLED);
		getState(CButtonState.UP_SELECTED)
			.setBitmapData(MFlatBdFactory.getBgUpSelected())
			.setFormat(MFormatFactory.FLAT_BUTTON_UP);
		getState(CButtonState.OVER_SELECTED)
			.setBitmapData(MFlatBdFactory.getBgOverSelected())
			.setFormat(MFormatFactory.FLAT_BUTTON_OVER);
		getState(CButtonState.DOWN_SELECTED)
			.setBitmapData(MFlatBdFactory.getBgDownSelected())
			.setFormat(MFormatFactory.FLAT_BUTTON_OVER)
			.setTextOffset(0, 1);
		getState(CButtonState.DISABLED_SELECTED)
			.setBitmapData(MFlatBdFactory.getBgDisabledSelected())
			.setFormat(MFormatFactory.FLAT_BUTTON_DISABLED);
		getImage(CButtonState.OVER).setFilters(MFilterFactory.LIGHT_AMPLIFIED);
		getImage(CButtonState.DOWN).setFilters(MFilterFactory.LIGHT_AMPLIFIED);
		getImage(CButtonState.DISABLED).setAlpha(.5);
		getImage(CButtonState.OVER_SELECTED).setFilters(MFilterFactory.LIGHT_AMPLIFIED);
		getImage(CButtonState.DOWN_SELECTED).setFilters(MFilterFactory.LIGHT_AMPLIFIED);
		getImage(CButtonState.DISABLED_SELECTED).setAlpha(.5);
	}	
}