package temperate.minimal.graphics;
import flash.display.BitmapData;
using temperate.core.CMath;

class MWindowBdFactory 
{
	static var DEFAULT_STRIAE_SIZE = 20;
	
	public static var color:UInt = 0x80ffffff;
	public static var bgColor:UInt = 0x00ffffff;
	
	static function newStriae(color:UInt, bgColor:UInt, space:Int, size:Int)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var g = shape.graphics;
		g.clear();
		
		g.lineStyle(size, color.colorPart(), color.alphaPart());
		var x = -DEFAULT_STRIAE_SIZE;
		while (x < DEFAULT_STRIAE_SIZE)
		{
			g.moveTo(x + DEFAULT_STRIAE_SIZE, 0);
			g.lineTo(x, DEFAULT_STRIAE_SIZE);
			x += space + size;
		}
		
		var bitmapData = new BitmapData(
			DEFAULT_STRIAE_SIZE, DEFAULT_STRIAE_SIZE, true, bgColor);
		bitmapData.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
	
	public static function getDefaultStriae():BitmapData
	{
		return newStriae(color, bgColor, 4, 1);
	}
}