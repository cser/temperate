package ;
import flash.display.Bitmap;
import flash.display.Sprite;
import temperate.components.CSlider;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.graphics.MLineBdFactory;
import temperate.minimal.graphics.MScrollBarBdFactory;
import temperate.minimal.MButton;
import temperate.minimal.MLabel;
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
		
		var thumb = new MButton().setText("::\n|\n::");
		var slider = new CSlider(false, thumb, new MFieldRectSkin());
		main.add(slider);
		
		var scrollBar = new MScrollBar(true).addTo(main);
		scrollBar.value = 20;
		MTooltipFactory.newText(scrollBar, "It here just for skin comarision");
		
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
			var column = new CVBox().addTo(line);
			new MSlider(true).addTo(column);
			new MSlider(true).addTo(column).value = 10;
			new MSlider(true).addTo(column).value = 20;
			new MSlider(true).addTo(column).value = 50;
			new MSlider(true).addTo(column).value = 100;
			new MSlider(false).addTo(line);
			new MSlider(false).addTo(line).value = 10;
			new MSlider(false).addTo(line).value = 20;
			new MSlider(false).addTo(line).value = 50;
			new MSlider(false).addTo(line).value = 100;
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("value = 50").addTo(column);
			new MSlider(true).addTo(column).value = 50;
			new MSlider(false).addTo(column).value = 50;
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("updateOnMove = true").addTo(column);
			new MSlider(true).addTo(column).updateOnMove = true;
			new MSlider(false).addTo(column).updateOnMove = true;
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("useHandCursor = true").addTo(column);
			new MSlider(true).addTo(column).useHandCursor = true;
			new MSlider(false).addTo(column).useHandCursor = true;
		}
	}
}