package minimal;
import flash.display.Bitmap;
import flash.display.Sprite;
import temperate.containers.CHBox;
import temperate.minimal.graphics.MCommonBdFactory;

class TestMBdFactory extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var line = new CHBox().addTo(this, 10, 10);
		line.add(new Bitmap(MCommonBdFactory.getButtonBgUp()));
		line.add(new Bitmap(MCommonBdFactory.getButtonBgDown()));
		line.add(new Bitmap(MCommonBdFactory.getButtonBgUpSelected()));
		line.add(new Bitmap(MCommonBdFactory.getButtonBgDownSelected()));
		line.add(new Bitmap(MCommonBdFactory.getCheckBoxBgUp()));
		line.add(new Bitmap(MCommonBdFactory.getCheckBoxBgDown()));
		line.add(new Bitmap(MCommonBdFactory.getCheckBoxBgUpSelected()));
		line.add(new Bitmap(MCommonBdFactory.getCheckBoxBgDownSelected()));
	}
}