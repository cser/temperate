package ;
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import temperate.containers.CHBox;
import temperate.minimal.graphics.MCommonBdFactory;
import temperate.minimal.graphics.MWindowBdFactory;
import temperate.minimal.MButton;
import temperate.minimal.MFlatButton;
import temperate.minimal.windows.MMaximizeButton;
import temperate.minimal.windows.MWindowManager;
import temperate.minimal.windows.MWindowSkin;
import temperate.raster.CScale9GridDrawer;
import temperate.raster.CVScale12GridDrawer;
import windows.MMaximizedWindow;

class NmeTestCurrent extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init():Void
	{
		var g = graphics;
		g.beginFill(0xeeeeee);
		g.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
		g.endFill();
		
		var shape = new Shape();
		addChild(shape);
		
		var bd = MCommonBdFactory.getButtonBgUp();
		var scaler = new CScale9GridDrawer(shape.graphics);
		scaler.setBitmapData(bd);
		scaler.setBounds(100, 100, 100, 100);
		scaler.redraw();
		
		var button = new MButton();
		button.text = "Button";
		addChild(button);
		
		var button = new MFlatButton();
		button.text = "Flat button";
		button.y = 100;
		addChild(button);
		
		var line = new CHBox().addTo(this, 300, 10);
		var skin = new MWindowSkin();
		line.add(new Bitmap(MWindowBdFactory.getFrame()));
		
		var shape = new Shape();
		line.add(shape).setFixedSize(100, 100);
		var drawer = new CVScale12GridDrawer();
		drawer.setBitmapData(MWindowBdFactory.getFrame());
		drawer.setInsets(
			10, 12, 10, 12, MWindowBdFactory.FRAME_CENTER_TOP -2, 2);
		drawer.setBounds(0, 0, 100, 100, 20);
		drawer.draw(shape.graphics);
		
		var line = new CHBox().addTo(this, 10, 200);
		var button = new MMaximizeButton();
		line.add(button);
		
		var button = new MWindowSkin().getMaximizeButton();
		line.add(button.view);
	}
}