package temperate.minimal.graphics;
import flash.display.BitmapData;

class MArrowBdFactory 
{
	public static function newUpArrow(color:Int)
	{
		var bd = new BitmapData(10, 6, true, 0x00000000);
		
		var line = [
			4, 0, 5, 0,
			3, 1, 4, 1, 5, 1, 6, 1,
			2, 2, 3, 2, 4, 2, 5, 2, 6, 2, 7, 2,
			1, 3, 2, 3, 3, 3, 4, 3, 5, 3, 6, 3, 7, 3, 8, 3,
			0, 4, 1, 4, 2, 4, 3, 4, 6, 4, 7, 4, 8, 4, 9, 4,
			0, 5, 1, 5, 8, 5, 9, 5
		];
		var i = line.length - 1;
		do
		{
			bd.setPixel32(line[i - 1], line[i], color);
			i -= 2;
		}
		while (i > 0);
		return bd;
	}
}