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
		for (y in 0 ... height)
		{
			for (x in 0 ... width)
			{
				array[i++] = bd.getPixel32(x, y);
			}
		}
		var i = 0;
		var result:Array<UInt> = [];
		result[i++] = width;
		result[i++] = height;
		var isSummState = false;
		var countIndex = 0;
		var j = 0;
		var length = array.length;
		var oldColor:UInt = 0x000000;
		while (true)
		{
			if (isSummState)
			{
				if (array[j] != oldColor || j >= length - 1)
				{
					isSummState = false;
					result[countIndex] = (result[countIndex] << 1) | 1;
				}
				else
				{
					result[countIndex]++;
					j++;
				}
			}
			else
			{
				if (j + 1 < length && array[j] == array[j + 1])
				{
					isSummState = true;
					countIndex = i;
					result[i++] = 1;
					result[i++] = array[j] & 0xfffffffe;
					oldColor = array[j];
				}
				else
				{
					result[i++] = array[j] & 0xfffffffe;
				}
				j++;
				if (j >= length)
				{
					break;
				}
			}
		}
		return result;
	}
}