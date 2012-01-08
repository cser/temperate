package temperate.minimal.windows;
import temperate.components.CButtonState;
import temperate.components.CRasterToolButton;
import temperate.minimal.graphics.MWindowBdFactory;

class MMaximizeButton extends CRasterToolButton
{
	public function new() 
	{
		super();
		
		getState(CButtonState.UP)
			.setBitmapData(MWindowBdFactory.getImageMaximize(CButtonState.UP));
		getState(CButtonState.OVER)
			.setBitmapData(MWindowBdFactory.getImageMaximize(CButtonState.OVER));
		getState(CButtonState.DOWN)
			.setBitmapData(MWindowBdFactory.getImageMaximize(CButtonState.DOWN));
		getState(CButtonState.DISABLED)
			.setBitmapData(MWindowBdFactory.getImageMaximize(CButtonState.DISABLED));
		
		getState(CButtonState.UP_SELECTED)
			.setBitmapData(MWindowBdFactory.getImageCollapse(CButtonState.UP));
		getState(CButtonState.OVER_SELECTED)
			.setBitmapData(MWindowBdFactory.getImageCollapse(CButtonState.OVER));
		getState(CButtonState.DOWN_SELECTED)
			.setBitmapData(MWindowBdFactory.getImageCollapse(CButtonState.DOWN));
		getState(CButtonState.DISABLED_SELECTED)
			.setBitmapData(MWindowBdFactory.getImageCollapse(CButtonState.DISABLED));
	}	
}