package temperate.minimal;
import temperate.components.CSlider;
import temperate.minimal.skins.MLineSkin;

class MSlider extends CSlider
{
	public function new(horizontal:Bool) 
	{
		var thumb = new MButton().setText("::-::");
		var bgSkin = new MLineSkin(horizontal);
		
		super(horizontal, thumb, bgSkin);
	}	
}