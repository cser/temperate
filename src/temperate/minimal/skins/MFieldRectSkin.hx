package temperate.minimal.skins;
import temperate.minimal.graphics.MCommonBdFactory;
import temperate.skins.CRasterRectSkin;
import temperate.skins.CSkinState;

class MFieldRectSkin extends CRasterRectSkin
{
	public function new() 
	{
		super();
		
		getState(CSkinState.NORMAL).setBitmapData(MCommonBdFactory.getTextBg());
		getState(CSkinState.INACTIVE).setBitmapData(MCommonBdFactory.getTextBgInactive());
		getState(CSkinState.DISABLED).setBitmapData(MCommonBdFactory.getTextBgInactive())
			.setAlpha(.35);
	}
}