package ;
import flash.display.Sprite;
import temperate.components.CSlider;
import temperate.minimal.MButton;
import temperate.minimal.skins.MFieldRectSkin;

class TestSlider extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var slider = new CSlider(true, new MButton().setText("::-::"), new MFieldRectSkin());
		slider.addTo(this, 10, 10);
	}
}