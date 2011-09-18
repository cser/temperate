package ;
import flash.display.Bitmap;
import flash.display.Sprite;
import temperate.components.CScrollBar;
import temperate.components.CSlider;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.graphics.MCommonBdFactory;
import temperate.minimal.graphics.MSliderBdFactory;
import temperate.minimal.MButton;
import temperate.minimal.MSlider;
import temperate.minimal.skins.MFieldRectSkin;
import temperate.raster.Scale9GridDrawer;
import temperate.skins.CRasterScrollDrawedSkin;
import temperate.skins.ICSliderSkin;

class TestSlider extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var main = new CVBox().addTo(this, 10, 10);
		
		var thumb = new MButton().setText("::-::");
		var slider = new CSlider(true, thumb, new MFieldRectSkin());
		main.add(slider);
		
		var thumb = new MButton().setText("::-::");
		var slider = new CSlider(false, thumb, new MFieldRectSkin());
		main.add(slider);
		
		{
			var line = new CHBox().addTo(main);
			line.add(new Bitmap(MSliderBdFactory.getHBg()));
			line.add(new Bitmap(MSliderBdFactory.getVBg()));
		}
		
		{
			var line = new CHBox().addTo(main);
			new MSlider(true).addTo(line);
			new MSlider(false).addTo(line);
		}
	}
}