package temperate.minimal.skins;
import temperate.minimal.graphics.MSliderBdFactory;
import temperate.skins.CRaster3GridRectSkin;
import temperate.skins.CSkinState;

class MLineSkin extends CRaster3GridRectSkin
{
	public function new(horizontal:Bool)
	{
		super(horizontal);
		
		var bd = horizontal ? MSliderBdFactory.getHBg() : MSliderBdFactory.getVBg();
		getState(CSkinState.NORMAL).setBitmapData(bd);
		getState(CSkinState.INACTIVE).setBitmapData(bd);
		getState(CSkinState.DISABLED).setBitmapData(bd)
			.setAlpha(.35);
	}	
}