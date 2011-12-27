package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.geom.Matrix;
import temperate.components.CButtonState;
using temperate.core.CMath;

class MToolBdFactory 
{
	public static var bgColor(get_bgColor, set_bgColor):MWindowBdColor;
	static var _bgColor:MWindowBdColor;
	static function get_bgColor()
	{
		if (_bgColor == null)
		{
			var color = new MWindowBdColor();
			
			color.bgRatiosUp = [ 0, 250 ];
			color.bgRatiosOver = [ 0, 250 ];
			color.bgRatiosDown = [ 0, 250 ];
			color.bgRatiosDisabled = [ 0, 250 ];
			
			color.bgColorsUp = [ 0xffd0f060, 0xff80c020 ];
			color.bgColorsOver = [ 0xffbfef50, 0xffafcf50 ];
			color.bgColorsDown = [ 0xff506f00, 0xffc0ff30 ];
			color.bgColorsDisabled = [ 0xffeeeeee, 0xffcccccc ];
			
			color.bgInnerTopLeftColor = 0xa0ffffff;
			color.bgInnerBottomRightColor = 0x30000000;
			color.outerBorderColor = 0xc0ffffff;
			color.outerBorderDisabledColor = 0x80ffffff;
			color.innerBorderColor = 0xff508000;
			color.innerBorderDisabledColor = 0xff808080;
			
			_bgColor = color;
		}
		return _bgColor;
	}
	static function set_bgColor(value:MWindowBdColor)
	{
		_bgColor = value;
		return _bgColor;
	}
	
	public static var bgSelectedColor(get_bgSelectedColor, set_bgSelectedColor):MWindowBdColor;
	static var _bgSelectedColor:MWindowBdColor;
	static function get_bgSelectedColor()
	{
		if (_bgSelectedColor == null)
		{
			var color = new MWindowBdColor();
			
			color.bgRatiosUp = [ 0, 250 ];
			color.bgRatiosOver = [ 0, 250 ];
			color.bgRatiosDown = [ 0, 250 ];
			color.bgRatiosDisabled = [ 0, 250 ];
			
			color.bgColorsUp = [ 0xff506f00, 0xffc0ff30 ];
			color.bgColorsOver = [ 0xff5a8000, 0xffd0ff50 ];
			color.bgColorsDown = [ 0xff506f00, 0xffc0ff30 ];
			color.bgColorsDisabled = [ 0xff808080, 0xffefefef ];

			color.bgInnerTopLeftColor = 0xa0ffffff;
			color.bgInnerBottomRightColor = 0x30000000;
			color.outerBorderColor = 0xc0ffffff;
			color.outerBorderDisabledColor = 0x80ffffff;
			color.innerBorderColor = 0xff508000;
			color.innerBorderDisabledColor = 0xff808080;
			
			_bgSelectedColor = color;
		}
		return _bgSelectedColor;
	}
	static function set_bgSelectedColor(value:MWindowBdColor)
	{
		_bgSelectedColor = value;
		return _bgSelectedColor;
	}
	
	public static var size = 34;
	
	static function getBg(params:MWindowBdColor, state:CButtonState)
	{
		MBdFactoryUtil.qualityOn();
		
		var bd = new BitmapData(size, size, true, 0x00000000);
		var shape = MBdFactoryUtil.getShape();
		var g = shape.graphics;
		
		g.clear();
		
		var color = state.enabled ? params.outerBorderColor : params.outerBorderDisabledColor;
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRoundRect(0, 0, size, size, 8);
		g.drawRoundRect(1, 1, size - 2, size - 2, 6);
		g.endFill();
		
		var color = state.enabled ? params.innerBorderColor : params.innerBorderDisabledColor;
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRoundRect(1, 1, size - 2, size - 2, 6);
		g.drawRoundRect(2, 2, size - 4, size - 4, 4);
		g.endFill();
		
		{
			var boxHeight = size - 2;
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
			g.drawRoundRect(2, 2, size - 4, size - 4, 4);
			g.endFill();
		}
		
		var color = params.bgInnerBottomRightColor;
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRoundRect(2, 2, size - 4, size - 4, 4);
		g.drawRoundRect(2, 2, size - 5, size - 5, 4);
		g.endFill();
		
		var color = params.bgInnerTopLeftColor;
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRoundRect(2, 2, size - 4, size - 4, 4);
		g.drawRoundRect(3, 3, size - 5, size - 5, 4);
		g.endFill();
		
		bd.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bd;
	}
	
	//----------------------------------------------------------------------------------------------
	// Normal
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
	// Selected
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