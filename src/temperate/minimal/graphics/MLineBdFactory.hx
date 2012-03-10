package temperate.minimal.graphics;
import flash.display.BitmapData;
using temperate.core.CMath;
using temperate.core.CGraphicsUtil;

class MLineBdFactory 
{
	public static var borderColor = 0xff707070;
	public static var fillColor = 0xffaaaaaa;
	public static var borderLightColor = 0xffcccccc;
	
	//----------------------------------------------------------------------------------------------
	//
	//  Getters
	//
	//----------------------------------------------------------------------------------------------
	
	static var _hBg:BitmapData;
	
	public static function getHBg()
	{
		if (_hBg == null)
		{
			_hBg = newBg(true);
		}
		return _hBg;
	}
	
	static var _vBg:BitmapData;
	
	public static function getVBg()
	{
		if (_vBg == null)
		{
			_vBg = newBg(false);
		}
		return _vBg;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Generators
	//
	//----------------------------------------------------------------------------------------------
	
	static function newBg(horizontal:Bool)
	{
		var width = horizontal ? 20 : 4;
		var height = horizontal ? 4 : 20;
		var bd = new BitmapData(width, height, true, 0x00000000);
		
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var g = shape.graphics;
		g.clear();
		g.beginFill(fillColor.getColor(), fillColor.getAlpha());
		g.drawRoundRect(0, 0, width, height, 4);
		g.endFill();
		g.drawBottomRightBorder(
			0, 0, width, height, 2,
			borderLightColor.getColor(), borderLightColor.getAlpha(), 1, true);
		g.drawTopLeftBorder(
			0, 0, width, height, 2,
			borderColor.getColor(), borderColor.getAlpha(), 1, true);
		bd.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		
		return bd;
	}
}