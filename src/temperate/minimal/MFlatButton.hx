package temperate.minimal;
import temperate.components.CButtonState;
import temperate.components.CRasterScaledButton;
import temperate.minimal.graphics.MFlatBdFactory;
import temperate.minimal.graphics.MScrollBarBdFactory;

class MFlatButton extends CRasterScaledButton
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
	}	
}