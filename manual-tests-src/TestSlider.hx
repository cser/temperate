package ;
import flash.display.Bitmap;
import flash.display.Sprite;
import temperate.components.CSlider;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.graphics.MLineBdFactory;
import temperate.minimal.graphics.MScrollBarBdFactory;
import temperate.minimal.MButton;
import temperate.minimal.MScrollBar;
import temperate.minimal.MSlider;
import temperate.minimal.MTooltipFactory;
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
		
		var thumb = new MButton().setText("::-::");
		var slider = new CSlider(true, thumb, new MFieldRectSkin());
		main.add(slider);
		
		var thumb = new MButton().setText("::-::");
		var slider = new CSlider(false, thumb, new MFieldRectSkin());
		main.add(slider);
		
		MTooltipFactory.newText(
			new MScrollBar(true).addTo(main), "It here just for skin comarision");
		
		{
			var line = new CHBox().addTo(main);
			line.add(new Bitmap(MLineBdFactory.getHBg()));
			line.add(new Bitmap(MLineBdFactory.getVBg()));
			
			var line = new CHBox().addTo(main);
			line.add(new Bitmap(MScrollBarBdFactory.getSliderHThumbUp()));
			line.add(new Bitmap(MScrollBarBdFactory.getSliderHThumbOver()));
			line.add(new Bitmap(MScrollBarBdFactory.getSliderHThumbDown()));
			line.add(new Bitmap(MScrollBarBdFactory.getSliderHThumbDisabled()));
			
			var line = new CHBox().addTo(main);
			line.add(new Bitmap(MScrollBarBdFactory.getSliderVThumbUp()));
			line.add(new Bitmap(MScrollBarBdFactory.getSliderVThumbOver()));
			line.add(new Bitmap(MScrollBarBdFactory.getSliderVThumbDown()));
			line.add(new Bitmap(MScrollBarBdFactory.getSliderVThumbDisabled()));
		}
		
		{
			var line = new CHBox().addTo(main);
			new MSlider(true).addTo(line);
			new MSlider(false).addTo(line);
		}
	}
}