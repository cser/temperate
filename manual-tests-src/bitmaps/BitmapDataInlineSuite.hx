package bitmaps;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.sampler.NewObjectSample;
import temperate.components.CButtonState;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.graphics.MBdInlineUtil;
import temperate.minimal.graphics.MCursorBdFactory;
import temperate.minimal.graphics.MLineBdFactory;
import temperate.minimal.graphics.MWindowBdFactory;

class BitmapDataInlineSuite extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var g = graphics;
		g.beginFill(0xeeeeee);
		g.drawRect(0, 0, 800, 600);
		g.endFill();
		var line = new CHBox().addTo(this, 10, 10);
		line.add(new Bitmap(MWindowBdFactory.getImageMaximize(CButtonState.UP)));
		line.add(new Bitmap(MWindowBdFactory.getImageMaximize(CButtonState.OVER)));
		line.add(new Bitmap(MWindowBdFactory.getImageMaximize(CButtonState.DOWN)));
		line.add(new Bitmap(MWindowBdFactory.getImageMaximize(CButtonState.DISABLED)));
		line.add(new Bitmap(MWindowBdFactory.getImageCollapse(CButtonState.UP)));
		line.add(new Bitmap(MWindowBdFactory.getImageCollapse(CButtonState.OVER)));
		line.add(new Bitmap(MWindowBdFactory.getImageCollapse(CButtonState.DOWN)));
		line.add(new Bitmap(MWindowBdFactory.getImageCollapse(CButtonState.DISABLED)));
		line.add(new Bitmap(MWindowBdFactory.getImageClose(CButtonState.UP)));
		line.add(new Bitmap(MWindowBdFactory.getImageClose(CButtonState.OVER)));
		line.add(new Bitmap(MWindowBdFactory.getImageClose(CButtonState.DOWN)));
		line.add(new Bitmap(MWindowBdFactory.getImageClose(CButtonState.DISABLED)));
		line.add(new Bitmap(MCursorBdFactory.getForbidden()));
		line.add(new Bitmap(MCursorBdFactory.getHandDown()));
		line.add(new Bitmap(MCursorBdFactory.getHandUp()));
		line.add(new Bitmap(MCursorBdFactory.getResize()));
		line.add(new Bitmap(MCursorBdFactory.getWait()));
		line.add(new Bitmap(MLineBdFactory.getHBg()));
		line.add(new Bitmap(MLineBdFactory.getVBg()));
		
		var bd = MLineBdFactory.getVBg();
		var source = BitmapDataInliner.encode(bd);
		trace(sourceToString(source));
		var bitmap = new Bitmap(MBdInlineUtil.decode(source));
		bitmap.x = 10;
		bitmap.y = 100;
		addChild(bitmap);
	}
	
	private function sourceToString(source:Array<Int>):String
	{
		var text = "[";
		var first = true;
		var k = 0;
		for (value in source)
		{
			if (!first)
			{
				text += ", ";
			}
			if (k > 6)
			{
				k = 0;
				text += "\n";
			}
			k++;
			first = false;
			text += "0x" + untyped value.toString(16);
		}
		text += "]";
		return text;
	}
}