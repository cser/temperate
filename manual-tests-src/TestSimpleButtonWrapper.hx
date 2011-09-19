package ;
import flash.display.Bitmap;
import flash.display.SimpleButton;
import flash.display.Sprite;
import temperate.components.CNumericStepper;
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
		
		var line = new CVBox().addTo(main);
		line.add(new MLabel().setText("Simple buttons"));
		line.add(newUpSimpleButton());
		line.add(newDownSimpleButton());
		
		var line = new CVBox().addTo(main);
		line.add(new MLabel().setText("Wrapped buttons"));
		line.add(new CSimpleButtonWrapper(newUpSimpleButton()).view);
		line.add(new CSimpleButtonWrapper(newDownSimpleButton()).view);
		
		var line = new CVBox().addTo(main);
		line.add(new MLabel().setText("Numeric stepper with simple buttons"));
		line.add(
			new CNumericStepper(
				new CSimpleButtonWrapper(newUpSimpleButton()),
				new CSimpleButtonWrapper(newDownSimpleButton()),
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