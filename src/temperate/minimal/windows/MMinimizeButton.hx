package temperate.minimal.windows;
import temperate.components.CButtonState;
import temperate.components.CRasterToolButton;
import temperate.minimal.graphics.MWindowBdFactory;

class MMinimizeButton extends CRasterToolButton
{
	public function new() 
	{
		super();
		
		getState(CButtonState.UP)
			.setBitmapData(MWindowBdFactory.getImageMinimize(CButtonState.UP));
		getState(CButtonState.OVER)
			.setBitmapData(MWindowBdFactory.getImageMinimize(CButtonState.OVER));
		getState(CButtonState.DOWN)
			.setBitmapData(MWindowBdFactory.getImageMinimize(CButtonState.DOWN));
		getState(CButtonState.DISABLED)
			.setBitmapData(MWindowBdFactory.getImageMinimize(CButtonState.DISABLED));
	}	
}