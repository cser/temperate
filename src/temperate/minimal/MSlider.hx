package temperate.minimal;
import temperate.components.CButtonState;
import temperate.components.CRasterFixedButton;
import temperate.components.CSlider;
import temperate.minimal.graphics.MScrollBarBdFactory;
import temperate.minimal.skins.MLineSkin;

class MSlider extends CSlider
{
	public function new(horizontal:Bool) 
	{
		var thumb = new CRasterFixedButton();
		thumb.getState(CButtonState.UP).setBitmapData(
			horizontal ?
				MScrollBarBdFactory.getSliderHThumbUp() :
				MScrollBarBdFactory.getSliderVThumbUp());
		thumb.getState(CButtonState.OVER).setBitmapData(
			horizontal ?
				MScrollBarBdFactory.getSliderHThumbOver() :
				MScrollBarBdFactory.getSliderVThumbOver());
		thumb.getState(CButtonState.DOWN).setBitmapData(
			horizontal ?
				MScrollBarBdFactory.getSliderHThumbDown() :
				MScrollBarBdFactory.getSliderVThumbDown());
		thumb.getState(CButtonState.DISABLED).setBitmapData(
			horizontal ?
				MScrollBarBdFactory.getSliderHThumbDisabled() :
				MScrollBarBdFactory.getSliderVThumbDisabled());
		thumb.selectState = CButtonState.selectStateThumb;
				
		var bgSkin = new MLineSkin(horizontal);
		
		super(horizontal, thumb, bgSkin);
	}	
}