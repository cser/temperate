package ;
import flash.display.Bitmap;
import flash.display.SimpleButton;
import flash.display.Sprite;
import temperate.components.CNumericStepper;
import temperate.components.CScrollBar;
import temperate.components.CSimpleButton;
import temperate.components.CSimpleButtonWrapper;
import temperate.components.CSlider;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.graphics.MCommonBdFactory;
import temperate.minimal.graphics.MScrollBarBdFactory;
import temperate.minimal.MLabel;
import temperate.minimal.skins.MFieldRectSkin;
import temperate.raster.Scale9GridDrawer;
import temperate.skins.CRasterScrollDrawedSkin;

class TestSimpleButtonWrapper extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var main = new CVBox().addTo(this, 10, 10);
		
		{
			var line = new CHBox().addTo(main);
			
			var column = new CVBox().addTo(line);
			column.add(new MLabel().setText("Simple buttons"));
			column.add(newUpSimpleButton());
			column.add(newDownSimpleButton());
			
			var column = new CVBox().addTo(line);
			column.add(new MLabel().setText("Wrapped buttons"));
			column.add(new CSimpleButtonWrapper(newUpSimpleButton()).view);
			column.add(new CSimpleButtonWrapper(newDownSimpleButton()).view);
			
			var column = new CVBox().addTo(line);
			column.add(new MLabel().setText("Numeric stepper with\nwrapped simple buttons"));
			column.add(
				new CNumericStepper(
					new CSimpleButtonWrapper(newUpSimpleButton()),
					new CSimpleButtonWrapper(newDownSimpleButton()),
					new MFieldRectSkin()));
			
			var column = new CVBox().addTo(line);
			column.add(new MLabel().setText("CSimpleButton"));
			column.add(
				new CSimpleButton(
					new Bitmap(MScrollBarBdFactory.getTopUp()),
					new Bitmap(MScrollBarBdFactory.getTopOver()),
					new Bitmap(MScrollBarBdFactory.getTopDown()),
					new Bitmap(MScrollBarBdFactory.getTopUp())));
			
			var column = new CVBox().addTo(line);
			column.add(new MLabel().setText("Numeric stepper with\nCSimpleButton arrows"));
			column.add(
				new CNumericStepper(
					new CSimpleButton(
						new Bitmap(MScrollBarBdFactory.getTopUp()),
						new Bitmap(MScrollBarBdFactory.getTopOver()),
						new Bitmap(MScrollBarBdFactory.getTopDown()),
						new Bitmap(MScrollBarBdFactory.getTopUp())),
					new CSimpleButton(
						new Bitmap(MScrollBarBdFactory.getBottomUp()),
						new Bitmap(MScrollBarBdFactory.getBottomOver()),
						new Bitmap(MScrollBarBdFactory.getBottomDown()),
						new Bitmap(MScrollBarBdFactory.getBottomUp())),
					new MFieldRectSkin()));
		}
		
		{
			var line = new CHBox().addTo(main);
			
			var column = new CVBox().addTo(line);
			column.add(new MLabel().setText("Slider"));
			newWrappedSlider(true).addTo(column);
			newWrappedSlider(false).addTo(column);
			
			var column = new CVBox().addTo(line);
			column.add(new MLabel().setText("Slider\n(useHandCurosr = true, updateOnMove = true)"));
			var slider = newWrappedSlider(true).addTo(column);
			slider.useHandCursor = true;
			slider.updateOnMove = true;
			var slider = newWrappedSlider(false).addTo(column);
			slider.useHandCursor = true;
			slider.updateOnMove = true;
			
			var column = new CVBox().addTo(line);
			column.add(new MLabel().setText("Scroll bar"));
			newWrappedScrollBar(true).addTo(column);
			newWrappedScrollBar(false).addTo(column);
			
			var column = new CVBox().addTo(line);
			column.add(
				new MLabel().setText("Scroll bar\n(useHandCursor = true, updateOnMove = true)"));
			var scrollBar = newWrappedScrollBar(true).addTo(column);
			scrollBar.useHandCursor = true;
			scrollBar.updateOnMove = true;
			var scrollBar = newWrappedScrollBar(false).addTo(column);
			scrollBar.useHandCursor = true;
			scrollBar.updateOnMove = true;
		}
	}
	
	function newUpSimpleButton()
	{
		return new SimpleButton(
			new Bitmap(MScrollBarBdFactory.getTopUp()),
			new Bitmap(MScrollBarBdFactory.getTopOver()),
			new Bitmap(MScrollBarBdFactory.getTopDown()),
			new Bitmap(MScrollBarBdFactory.getTopUp()));
	}
	
	function newDownSimpleButton()
	{
		return new SimpleButton(
			new Bitmap(MScrollBarBdFactory.getBottomUp()),
			new Bitmap(MScrollBarBdFactory.getBottomOver()),
			new Bitmap(MScrollBarBdFactory.getBottomDown()),
			new Bitmap(MScrollBarBdFactory.getBottomUp()));
	}
	
	function newWrappedSlider(horizontal:Bool)
	{
		return new CSlider(
			horizontal,
			new CSimpleButtonWrapper(newUpSimpleButton()),
			new MFieldRectSkin());
	}
	
	function newWrappedScrollBar(horizontal:Bool)
	{
		return new CScrollBar(
			horizontal,
			new CSimpleButtonWrapper(newUpSimpleButton()),
			new CSimpleButtonWrapper(newDownSimpleButton()),
			new CSimpleButtonWrapper(newUpSimpleButton()),
			new CRasterScrollDrawedSkin(MCommonBdFactory.getTextBg(), new Scale9GridDrawer(), 18),
			false);
	}
}