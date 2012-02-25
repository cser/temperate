package temperate.minimal;
import temperate.components.CButtonState;
import temperate.components.CRasterToolButton;
import temperate.minimal.graphics.MToolBdFactory;

class MToolButton extends CRasterToolButton
{
	public function new() 
	{
		super();
		
		getState(CButtonState.UP).setBitmapData(MToolBdFactory.getBgUp());
		getState(CButtonState.OVER).setBitmapData(MToolBdFactory.getBgOver());
		getState(CButtonState.DOWN).setBitmapData(MToolBdFactory.getBgDown());
		getState(CButtonState.DISABLED).setBitmapData(MToolBdFactory.getBgDisabled());
		getState(CButtonState.UP_SELECTED).setBitmapData(MToolBdFactory.getBgUpSelected());
		getState(CButtonState.OVER_SELECTED).setBitmapData(MToolBdFactory.getBgOverSelected());
		getState(CButtonState.DOWN_SELECTED).setBitmapData(MToolBdFactory.getBgDownSelected());
		getState(CButtonState.DISABLED_SELECTED)
			.setBitmapData(MToolBdFactory.getBgDisabledSelected());
		getImage(CButtonState.OVER).setFilters(MFilterFactory.LIGHT);
		getImage(CButtonState.DOWN).setFilters(MFilterFactory.LIGHT).setOffset(0, 1);
		getImage(CButtonState.DISABLED).setAlpha(.5);
		getImage(CButtonState.UP_SELECTED).setFilters(MFilterFactory.LIGHT).setOffset(0, 1);
		getImage(CButtonState.OVER_SELECTED)
			.setFilters(MFilterFactory.LIGHT_AMPLIFIED).setOffset(0, 1);
		getImage(CButtonState.DOWN_SELECTED).setFilters(MFilterFactory.LIGHT).setOffset(0, 1);
		getImage(CButtonState.DISABLED_SELECTED).setAlpha(.5).setOffset(0, 1);
		setImageIndents(4, 5, 4, 5);
	}	
}