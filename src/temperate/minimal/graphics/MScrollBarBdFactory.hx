package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.geom.Matrix;
import temperate.core.CMath;

class MScrollBarBdFactory 
{
	public static var arrowWidth = 17;
	public static var arrowHeight = 17;
	public static var arrowColor:UInt = 0xff508000;
	public static var bgColor:UInt = 0xff80f000;
	
	static var _scrollLeftUp:BitmapData;
	
	public static function getScrollLeftUp()
	{
		if (_scrollLeftUp == null)
		{
			_scrollLeftUp = newScrollUp(true, true);
		}
		return _scrollLeftUp;
	}
	
	static function newScrollUp(horizontal:Bool, left:Bool)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var width = horizontal ? arrowWidth : arrowHeight;
		var height = horizontal ? arrowHeight : arrowWidth;
		var bitmapData = new BitmapData(width, height, true, 0x00000000);
		
		var g = shape.graphics;
		drawBg(g, width, height);
		bitmapData.draw(shape);
		
		g.clear();
		g.beginFill(CMath.colorPart(arrowColor), CMath.alphaPart(arrowColor));
		g.moveTo(-1, -5);
		g.lineTo(4, 1);
		g.lineTo(-1, 7);
		g.lineTo(-3, 5);
		g.lineTo(0, 1);
		g.lineTo(-3, -3);
		g.endFill();
		
		var innerStrength = 1.7;
		var offsetX = width >> 1;
		var offsetY = height >> 1;
		
		if (horizontal && !left)
		{
			bitmapData.draw(shape, new Matrix(1, 0, 0, 1, offsetX, offsetY));
		}
		else if (horizontal && left)
		{
			bitmapData.draw(shape, new Matrix(-1, 0, 0, 1, width - offsetX, offsetY));
		}
		else if (!horizontal && !left)
		{
			bitmapData.draw(shape, new Matrix(0, 1, -1, 0, width - offsetX, offsetY));
		}
		else
		{
			bitmapData.draw(shape, new Matrix(0, -1, 1, 0, offsetX, height - offsetY));
		}
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
	
	static function drawBg(g:Graphics, width:Int, height:Int)
	{
		g.clear();
		
		g.beginFill(CMath.colorPart(bgColor), CMath.alphaPart(bgColor));
		g.drawRoundRect(0, 0, width, height, 4);
		g.endFill();
		
		var color = 0xffffffff;
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.drawRoundRect(1, 1, width - 2, height - 2, 4);
		g.endFill();
		
		var color = 0xff80cc00;
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.drawRoundRect(2, 2, width - 4, height - 4, 2);
		g.endFill();
	}
}