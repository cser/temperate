package ;
import flash.display.Bitmap;
import flash.display.SimpleButton;
import flash.display.Sprite;
import temperate.components.CNumericStepper;
import temperate.components.CSimpleButton;
import temperate.components.CSimpleButtonWrapper;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.graphics.MScrollBarBdFactory;
import temperate.minimal.MLabel;
import temperate.minimal.skins.MFieldRectSkin;

class TestSimpleButtonWrapper extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var main = new CHBox().addTo(this, 10, 10);
		
		var column = new CVBox().addTo(main);
		column.add(new MLabel().setText("Simple buttons"));
		column.add(newUpSimpleButton());
		column.add(newDownSimpleButton());
		
		var column = new CVBox().addTo(main);
		column.add(new MLabel().setText("Wrapped buttons"));
		column.add(new CSimpleButtonWrapper(newUpSimpleButton()).view);
		column.add(new CSimpleButtonWrapper(newDownSimpleButton()).view);
		
		var column = new CVBox().addTo(main);
		column.add(new MLabel().setText("Numeric stepper with\nwrapped simple buttons"));
		column.add(
			new CNumericStepper(
				new CSimpleButtonWrapper(newUpSimpleButton()),
				new CSimpleButtonWrapper(newDownSimpleButton()),
				new MFieldRectSkin()));
		
		var column = new CVBox().addTo(main);
		column.add(new MLabel().setText("CSimpleButton"));
		column.add(
			new CSimpleButton(
				new Bitmap(MScrollBarBdFactory.getTopUp()),
				new Bitmap(MScrollBarBdFactory.getTopOver()),
				new Bitmap(MScrollBarBdFactory.getTopDown()),
				new Bitmap(MScrollBarBdFactory.getTopUp())));
		
		var column = new CVBox().addTo(main);
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
	
	function newUpSimpleButton()
	{
		return new SimpleButton(
			new Bitmap(MScrollBarBdFactory.getTopUp()),
			new Bitmap(MScrollBarBdFactory.getTopOver()),
			new Bitmap(MScrollBarBdFactory.getTopDown()),
			new Bitmap(MScrollBarBdFactory.getTopUp())
		);
	}
	
	function newDownSimpleButton()
	{
		return new SimpleButton(
			new Bitmap(MScrollBarBdFactory.getBottomUp()),
			new Bitmap(MScrollBarBdFactory.getBottomOver()),
			new Bitmap(MScrollBarBdFactory.getBottomDown()),
			new Bitmap(MScrollBarBdFactory.getBottomUp())
		);
	}
}
/*
TODO
Заменть ACButton на ICButton в:
	CButtonSelector
	CScrollBar
	CSlider
*/