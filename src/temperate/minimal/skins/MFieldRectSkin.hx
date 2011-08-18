package temperate.minimal.skins;
import temperate.minimal.MBitmapDataFactory;
import temperate.skins.CRasterRectSkin;
import temperate.skins.CSkinState;

class MFieldRectSkin extends CRasterRectSkin
{
	public function new() 
	{
		super();
		
		getState(CSkinState.NORMAL).setBitmapData(MBitmapDataFactory.getTextBg());
		getState(CSkinState.INACTIVE).setBitmapData(MBitmapDataFactory.getTextBgInactive());
		getState(CSkinState.DISABLED).setBitmapData(MBitmapDataFactory.getTextBgInactive())
			.setAlpha(.35);
	}
}