package temperate.minimal.graphics;
import flash.display.BitmapData;

class MBdInlineUtil 
{
	public static function decode(source:Array<UInt>):BitmapData
	{
		var length = source.length;
		var i = 0;
		var width = source[i++];
		var height = source[i++];
		var bd = new BitmapData(width, height, true, 0x00000000);
		for (x in 0 ... width)
		{
			for (y in 0 ... height)
			{
				bd.setPixel32(x, y, source[i++]);
			}
		}
		return bd;
	}
}