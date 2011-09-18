package ;
import flash.display.Sprite;
import temperate.components.CSlider;
import temperate.containers.CVBox;
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
		var main = new CVBox().addTo(this, 10, 10);
		
		var slider = new CSlider(true, new MButton().setText("::-::"), new MFieldRectSkin());
		main.add(slider);
		
		var slider = new CSlider(false, new MButton().setText("::-::"), new MFieldRectSkin());
		main.add(slider);
	}
}