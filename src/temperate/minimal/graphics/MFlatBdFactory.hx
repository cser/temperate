package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.geom.Matrix;
import temperate.components.CButtonState;
using temperate.core.CMath;

class MFlatBdFactory 
{
	public static var size = 17;
	
	static function getBgColor():MFlatBgColor
	{
		return MBdFlatColors.bgColor;
	}
	
	static function getBgSelectedColor():MFlatBgColor
	{
		return MBdFlatColors.bgSelectedColor;
	}
	
	static function getBg(params:MFlatBgColor, state:CButtonState)
	{
		MBdFactoryUtil.qualityOn();
		
		var bd = new BitmapData(size, size, true, 0x00000000);
		var shape = MBdFactoryUtil.getShape();
		var g = shape.graphics;
		
		g.clear();
		
		var color = state.enabled ? params.bgBottomRightColor : params.bgBottomRightDisabledColor;
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRoundRect(0, 0, size, size, 6);
		g.drawRoundRect(0, 0, size - 1, size - 1, 6);
		g.endFill();
		
		var color = state.enabled ? params.bgTopLeftColor : params.bgTopLeftDisabledColor;
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
			_bgUp = getBg(getBgColor(), CButtonState.UP);
		}
		return _bgUp;
	}
	
	static var _bgOver:BitmapData;
	
	public static function getBgOver()
	{
		if (_bgOver == null)
		{
			_bgOver = getBg(getBgColor(), CButtonState.OVER);
		}
		return _bgOver;
	}
	
	static var _bgDown:BitmapData;
	
	public static function getBgDown()
	{
		if (_bgDown == null)
		{
			_bgDown = getBg(getBgColor(), CButtonState.DOWN);
		}
		return _bgDown;
	}
	
	static var _bgDisabled:BitmapData;
	
	public static function getBgDisabled()
	{
		if (_bgDisabled == null)
		{
			_bgDisabled = getBg(getBgColor(), CButtonState.DISABLED);
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
			_bgUpSelected = getBg(getBgSelectedColor(), CButtonState.UP);
		}
		return _bgUpSelected;
	}
	
	static var _bgOverSelected:BitmapData;
	
	public static function getBgOverSelected()
	{
		if (_bgOverSelected == null)
		{
			_bgOverSelected = getBg(getBgSelectedColor(), CButtonState.OVER);
		}
		return _bgOverSelected;
	}
	
	static var _bgDownSelected:BitmapData;
	
	public static function getBgDownSelected()
	{
		if (_bgDownSelected == null)
		{
			_bgDownSelected = getBg(getBgSelectedColor(), CButtonState.DOWN);
		}
		return _bgDownSelected;
	}
	
	static var _bgDisabledSelected:BitmapData;
	
	public static function getBgDisabledSelected()
	{
		if (_bgDisabledSelected == null)
		{
			_bgDisabledSelected = getBg(getBgSelectedColor(), CButtonState.DISABLED);
		}
		return _bgDisabledSelected;
	}
}