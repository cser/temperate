package ;
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.geom.Matrix;
import temperate.core.CSprite;
import temperate.minimal.graphics.MCommonBdFactory;
import temperate.minimal.MButton;
import temperate.minimal.MFlatButton;
import temperate.raster.CScale9GridDrawer;

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
		
		var bd = MCommonBdFactory.getButtonBgUp();
		//addChild(new Bitmap(bd));
		
		var shape = new Shape();
		addChild(shape);
		
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
	}
}