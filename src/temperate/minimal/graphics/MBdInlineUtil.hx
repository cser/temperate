package temperate.minimal.graphics;
import flash.display.BitmapData;

class MBdInlineUtil 
{
	public static function decode(source:Array<Int>):BitmapData
	{
		var length = source.length;
		var i = 0;
		var width:Int = source[i++];
		var height:Int = source[i++];
		var bd = new BitmapData(width, height, true, 0x00000000);
		var count = 0;
		var x = 0;
		var y = 0;
		while (true)
		{
			var color = source[i++];
			if (color & 1 == 1)
			{
				var count = color >> 1;
				color = source[i++];
				for (j in 0 ... count)
				{
					bd.setPixel32(x, y, color);
					x++;
					if (x >= width)
					{
						x = 0;
						y++;
					}
				}
			}
			else
			{
				bd.setPixel32(x, y, color);
				x++;
				if (x >= width)
				{
					x = 0;
					y++;
				}
			}
			if (i >= length)
			{
				break;
			}
		}
		return bd;
	}
}