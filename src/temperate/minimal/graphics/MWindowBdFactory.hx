package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.geom.Matrix;
import temperate.components.CButtonState;
using temperate.core.CMath;

class MWindowBdFactory 
{
	static var DEFAULT_STRIAE_SIZE = 20;
	static var MAX_HEAD_HEIGHT = 50;
	
	public static inline var FRAME_CENTER_TOP = 30;
	
	public static var gradientHeight = 24;
	public static var color:UInt = 0x80ffffff;
	public static var bgColor:UInt = 0x00ffffff;
	public static var headTopColor:UInt = 0xf8407015;
	public static var headBottomColor:UInt = 0xe080c030;
	public static var headTopActiveColor:UInt = 0xf8508000;
	public static var headBottomActiveColor:UInt = 0xe0a0e020;
	public static var headTopLockedColor:UInt = 0xf0808080;
	public static var headBottomLockedColor:UInt = 0xf0cccccc;
	
	static function newStriae(color:UInt, bgColor:UInt, space:Int, size:Int)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var g = shape.graphics;
		g.clear();
		
		g.lineStyle(size, color.getColor(), color.getAlpha());
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
	
	static function newFrame(width:Int, height:Int, lineTop:Int)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var g = shape.graphics;
		g.clear();
		
		g.beginFill(0x000000, .2);
		g.drawRoundRect(2, 2, width, height, 12);
		g.drawRoundRect(2, 2, width - 2, height - 2, 12);
		g.endFill();
		
		g.beginFill(0x505050);
		g.drawRoundRect(0, 0, width, height, 12);
		g.drawRoundRect(1, 1, width - 2, height - 2, 10);
		
		g.lineStyle();
		
		g.beginFill(0xeeeeee);
		g.drawRoundRectComplex(1, lineTop, width - 2, height - lineTop - 1, 0, 0, 5, 5);
		g.endFill();
		
		g.beginFill(0xffffff);
		g.drawRoundRectComplex(1, lineTop, width - 2, height - lineTop - 1, 0, 0, 5, 5);
		g.drawRoundRectComplex(1, lineTop, width - 3, height - lineTop - 2, 0, 0, 5, 5);
		g.endFill();
		
		var matrix = new Matrix();
		matrix.createGradientBox(10, lineTop, Math.PI * .5);
		
		g.beginGradientFill(
			GradientType.LINEAR, [0xffffff, 0xffffff], [.5, 1], [0, 255], matrix);
		g.drawRoundRectComplex(1, 1, width - 2, lineTop - 1, 5, 5, 0, 0);
		g.drawRoundRectComplex(2, 2, width - 4, lineTop - 2, 5, 5, 0, 0);
		g.endFill();
		
		g.beginFill(0xffffff, .6);
		g.drawRect(2, lineTop - 2, width - 4, 1);
		g.endFill();
		g.beginFill(0x000000, .2);
		g.drawRect(2, lineTop - 1, width - 4, 1);
		g.endFill();
		
		var bd = new BitmapData(width + 2, height + 2, true, 0x00000000);
		bd.draw(shape);
		MBdFactoryUtil.qualityOff();
		return bd;
	}
	
	static function newTop(striae:BitmapData, topColor:UInt, bottomColor:UInt)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var g = shape.graphics;
		g.clear();
		
		var width = striae.width;
		
		var matrix = new Matrix();
		matrix.createGradientBox(10, gradientHeight, Math.PI * .5);
		g.beginGradientFill(
			GradientType.LINEAR,
			[topColor.getColor(), bottomColor.getColor()],
			[topColor.getAlpha(), bottomColor.getAlpha()],
			[0, 255], matrix);
		g.drawRect(0, 0, width, MAX_HEAD_HEIGHT);
		g.endFill();
		
		g.beginBitmapFill(striae);
		g.drawRect(0, 0, width, MAX_HEAD_HEIGHT);
		g.endFill();
		
		var bd = new BitmapData(width, MAX_HEAD_HEIGHT, true, 0x000000);
		bd.draw(shape);
		MBdFactoryUtil.qualityOff();
		return bd;
	}
	
	static var _defaultStriae:BitmapData;
	
	static function getDefaultStriae():BitmapData
	{
		if (_defaultStriae == null)
		{
			_defaultStriae = newStriae(color, bgColor, 4, 1);
		}
		return _defaultStriae;
	}
	
	static var _frame:BitmapData;
	
	public static function getFrame():BitmapData
	{
		if (_frame == null)
		{
			_frame = newFrame(100, 100, FRAME_CENTER_TOP);
		}
		return _frame;
	}
	
	static var _defaultTop:BitmapData;
	
	public static function getDefaultTop():BitmapData
	{
		if (_defaultTop == null)
		{
			_defaultTop = newTop(getDefaultStriae(), headTopColor, headBottomColor);
		}
		return _defaultTop;
	}
	
	static var _lockedTop:BitmapData;
	
	public static function getLockedTop():BitmapData
	{
		if (_lockedTop == null)
		{
			_lockedTop = newTop(getDefaultStriae(), headTopLockedColor, headBottomLockedColor);
		}
		return _lockedTop;
	}
	
	static var _activeTop:BitmapData;
	
	public static function getActiveTop():BitmapData
	{
		if (_activeTop == null)
		{
			_activeTop = newTop(getDefaultStriae(), headTopActiveColor, headBottomActiveColor);
		}
		return _activeTop;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Buttons
	//
	//----------------------------------------------------------------------------------------------
	
	public static var size = 22;
	
	static function getBgColor():MFlatBgColor
	{
		return MBdFlatColors.bgColor;
	}
	
	static function getBgSelectedColor():MFlatBgColor
	{
		return MBdFlatColors.bgSelectedColor2;
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
		g.drawRoundRect(0, 0, size, size, 8);
		g.drawRoundRect(0, 0, size - 1, size - 1, 8);
		g.endFill();
		
		var color = enabled ? params.bgTopLeftColor : params.bgTopLeftDisabledColor;
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRoundRect(0, 0, size, size, 8);
		g.drawRoundRect(1, 1, size - 1, size - 1, 8);
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
			g.drawRoundRect(1, 1, size - 2, size - 2, 6);
			g.endFill();
		}
		
		var color = params.bgInnerTopLeftColor;
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRoundRect(1, 1, size - 2, size - 2, 6);
		g.drawRoundRect(2, 2, size - 3, size - 3, 6);
		g.endFill();
		
		var color = params.bgInnerBottomRightColor;
		g.beginFill(color.getColor(), color.getAlpha());
		g.drawRoundRect(1, 1, size - 2, size - 2, 6);
		g.drawRoundRect(1, 1, size - 3, size - 3, 6);
		g.endFill();
		
		if (state == CButtonState.DOWN)
		{
			var color = params.bgInnerDownColor;
			g.beginFill(color.getColor(), color.getAlpha());
			g.drawRoundRect(2, 2, size - 4, size - 4, 6);
			g.drawRoundRect(3, 3, size - 6, size - 6, 6);
			g.endFill();
		}
		
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
	// Selected
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