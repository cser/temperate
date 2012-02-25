package temperate.minimal.windows;
import temperate.components.CButtonState;
import temperate.components.CRasterToolButton;
import temperate.minimal.graphics.MWindowBdFactory;

class MCloseButton extends CRasterToolButton
{
	public function new() 
	{
		super();
		
		getState(CButtonState.UP)
			.setBitmapData(MWindowBdFactory.getImageClose(CButtonState.UP));
		getState(CButtonState.OVER)
			.setBitmapData(MWindowBdFactory.getImageClose(CButtonState.OVER));
		getState(CButtonState.DOWN)
			.setBitmapData(MWindowBdFactory.getImageClose(CButtonState.DOWN));
		getState(CButtonState.DISABLED)
			.setBitmapData(MWindowBdFactory.getImageClose(CButtonState.DISABLED));
	}	
}