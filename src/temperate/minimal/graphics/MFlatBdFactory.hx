package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.geom.Matrix;
import temperate.components.CButtonState;
using temperate.core.CMath;

class MFlatBdFactory 
{
	public static var size = 17;
	
	public static var bgColor(get_bgColor, set_bgColor):MFlatBgColor;
	static var _bgColor:MFlatBgColor;
	static function get_bgColor()
	{
		if (_bgColor == null)
		{
			var color = new MFlatBgColor();
			
			color.bgRatiosUp = [ 0, 138, 140, 250 ];
			color.bgRatiosOver = [ 0, 138, 140, 250 ];
			color.bgRatiosDown = [ 0, 250 ];
			color.bgRatiosDisabled = [ 0, 250 ];

			color.bgColorsUp = [ 0xffd0f060, 0xff80c020, 0xff60a000, 0xffa0c000 ];
			color.bgColorsOver = [ 0xffbfef50, 0xffafcf50, 0xff8fbf30, 0xffafcf30 ];
			color.bgColorsDown = [ 0xff506f00, 0xffc0ff30 ];
			color.bgColorsDisabled = [ 0xffeeeeee, 0xffcccccc ];

			color.bgBottomRightColor = 0xff105000;
			color.bgBottomRightDisabledColor = 0xffbabaaa;

			color.bgTopLeftColor = 0xff80a080;
			color.bgTopLeftDisabledColor = 0xffcccccc;

			color.bgInnerTopLeftColor = 0xa0ffffff;
			color.bgInnerBottomRightColor = 0xe0ffffff;

			color.bgInnerDownColor = 0x2e000000;
			
			_bgColor = color;
		}
		return _bgColor;
	}
	static function set_bgColor(value:MFlatBgColor)
	{
		_bgColor = value;
		return _bgColor;
	}
	
	public static var bgSelectedColor(get_bgSelectedColor, set_bgSelectedColor):MFlatBgColor;
	static var _bgSelectedColor:MFlatBgColor;
	static function get_bgSelectedColor()
	{
		if (_bgSelectedColor == null)
		{
			var color = new MFlatBgColor();
			
			color.bgRatiosUp = [ 0, 138, 140, 250 ];
			color.bgRatiosOver = [ 0, 138, 140, 250 ];
			color.bgRatiosDown = [ 0, 250 ];
			color.bgRatiosDisabled = [ 0, 250 ];

			color.bgColorsUp = [ 0xffb5b5b5, 0xff757575, 0xff555555, 0xff757575 ];
			color.bgColorsOver = [ 0xffaaaaaa, 0xff909090, 0xff707070, 0xff8f8f8f ];
			color.bgColorsDown = [ 0xff404040, 0xffa5a5a5 ];
			color.bgColorsDisabled = [ 0xffcccccc, 0xff828282 ];

			color.bgBottomRightColor = 0xff202020;

			color.bgBottomRightDisabledColor = 0xffb5b5b5;

			color.bgTopLeftColor = 0xff8b8b8b;
			color.bgTopLeftDisabledColor = 0xffcccccc;

			color.bgInnerTopLeftColor = 0xa0ffffff;
			color.bgInnerBottomRightColor = 0xe0ffffff;

			color.bgInnerDownColor = 0x2e000000;
			
			_bgSelectedColor = color;
		}
		return _bgSelectedColor;
	}
	static function set_bgSelectedColor(value:MFlatBgColor)
	{
		_bgSelectedColor = value;
		return _bgSelectedColor;
	}
	
	static function getBg(params:MFlatBgColor, state:CButtonState)
	{
		MBdFactoryUtil.qualityOn();
		
		var bd = new BitmapData(size, size, true, 0x00000000);
		var shape = MBdFactoryUtil.getShape();
		var g = shape.graphics;
		
		g.clear();
		
		var enabled = state != CButtonState.DISABLED;
		
		var color = enabled ? params.bgBottomRightColor : params.bgBottomRightDisabledColor;
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRoundRect(0, 0, size, size, 6);
		g.drawRoundRect(0, 0, size - 1, size - 1, 6);
		g.endFill();
		
		var color = enabled ? params.bgTopLeftColor : params.bgTopLeftDisabledColor;
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRoundRect(0, 0, size, size, 6);
		g.drawRoundRect(1, 1, size - 1, size - 1, 6);
		g.endFill();
		
		{
			var boxHeight = 20;
			var matrix = new Matrix();
			matrix.createGradientBox(boxHeight, boxHeight, Math.PI * .5, -3, -3);
			
			var colors = [];
			var alphas = [];
			var sourceColors;
			var ratios;
			switch (state)
			{
				case CButtonState.OVER:
					sourceColors = params.bgColorsOver;
					ratios = params.bgRatiosOver;
				case CButtonState.DOWN:
					sourceColors = params.bgColorsDown;
					ratios = params.bgRatiosDown;
				case CButtonState.DISABLED:
					sourceColors = params.bgColorsDisabled;
					ratios = params.bgRatiosDisabled;
				default:						
					sourceColors = params.bgColorsUp;
					ratios = params.bgRatiosUp;
			}
			MBdFactoryUtil.getColorsAndAlphas(sourceColors, colors, alphas);
			
			g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
			g.drawRoundRect(1, 1, size - 2, size - 2, 4);
			g.endFill();
		}
		
		var color = params.bgInnerTopLeftColor;
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRoundRect(1, 1, size - 2, size - 2, 4);
		g.drawRoundRect(2, 2, size - 3, size - 3, 4);
		g.endFill();
		
		var color = params.bgInnerBottomRightColor;
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRoundRect(1, 1, size - 2, size - 2, 4);
		g.drawRoundRect(1, 1, size - 3, size - 3, 4);
		g.endFill();
		
		if (state == CButtonState.DOWN)
		{
			var color = params.bgInnerDownColor;
			g.beginFill(color.getColor(), color.getAlpha());
			g.drawRoundRect(2, 2, size - 4, size - 4, 4);
			g.drawRoundRect(3, 3, size - 6, size - 6, 4);
			g.endFill();
		}
		
		bd.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bd;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Normal
	//
	//----------------------------------------------------------------------------------------------
	
	static var _bgUp:BitmapData;
	
	public static function getBgUp()
	{
		if (_bgUp == null)
		{
			_bgUp = getBg(bgColor, CButtonState.UP);
		}
		return _bgUp;
	}
	
	static var _bgOver:BitmapData;
	
	public static function getBgOver()
	{
		if (_bgOver == null)
		{
			_bgOver = getBg(bgColor, CButtonState.OVER);
		}
		return _bgOver;
	}
	
	static var _bgDown:BitmapData;
	
	public static function getBgDown()
	{
		if (_bgDown == null)
		{
			_bgDown = getBg(bgColor, CButtonState.DOWN);
		}
		return _bgDown;
	}
	
	static var _bgDisabled:BitmapData;
	
	public static function getBgDisabled()
	{
		if (_bgDisabled == null)
		{
			_bgDisabled = getBg(bgColor, CButtonState.DISABLED);
		}
		return _bgDisabled;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Selected
	//
	//----------------------------------------------------------------------------------------------
	
	static var _bgUpSelected:BitmapData;
	
	public static function getBgUpSelected()
	{
		if (_bgUpSelected == null)
		{
			_bgUpSelected = getBg(bgSelectedColor, CButtonState.UP);
		}
		return _bgUpSelected;
	}
	
	static var _bgOverSelected:BitmapData;
	
	public static function getBgOverSelected()
	{
		if (_bgOverSelected == null)
		{
			_bgOverSelected = getBg(bgSelectedColor, CButtonState.OVER);
		}
		return _bgOverSelected;
	}
	
	static var _bgDownSelected:BitmapData;
	
	public static function getBgDownSelected()
	{
		if (_bgDownSelected == null)
		{
			_bgDownSelected = getBg(bgSelectedColor, CButtonState.DOWN);
		}
		return _bgDownSelected;
	}
	
	static var _bgDisabledSelected:BitmapData;
	
	public static function getBgDisabledSelected()
	{
		if (_bgDisabledSelected == null)
		{
			_bgDisabledSelected = getBg(bgSelectedColor, CButtonState.DISABLED);
		}
		return _bgDisabledSelected;
	}
}