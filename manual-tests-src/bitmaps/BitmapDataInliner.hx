package bitmaps;
import flash.display.BitmapData;

class BitmapDataInliner 
{
	public static function encode(bd:BitmapData):Array<UInt>
	{
		var array:Array<UInt> = [];
		var width = bd.width;
		var height = bd.height;
		var i = 0;
		array[i++] = width;
		array[i++] = height;
		for (x in 0 ... width)
		{
			for (y in 0 ... height)
			{
				array[i++] = bd.getPixel32(x, y);
			}
		}
		return array;
	}
}