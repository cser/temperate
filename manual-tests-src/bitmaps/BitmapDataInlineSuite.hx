package bitmaps;
import flash.display.Bitmap;
import flash.display.Sprite;
import temperate.components.CButtonState;
import temperate.minimal.graphics.MBdInlineUtil;
import temperate.minimal.graphics.MWindowBdFactory;

class BitmapDataInlineSuite extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var bd = MWindowBdFactory.getImageMaximize(CButtonState.UP);
		var source = BitmapDataInliner.encode(bd);
		addChild(new Bitmap(MBdInlineUtil.decode(source)));
	}
}