package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.filters.BevelFilter;
import flash.filters.BitmapFilterType;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import temperate.components.CButtonState;
using temperate.core.CMath;

class MWindowBdFactory 
{
	static var DEFAULT_STRIAE_SIZE = 20;
	static var MAX_HEAD_HEIGHT = 50;
	
	public static inline var FRAME_CENTER_TOP = 30;
	
	public static var gradientHeight = 24;
	public static var striaeColor:UInt = 0x80ffffff;
	public static var striaeBgColor:UInt = 0x00ffffff;
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
			_defaultStriae = newStriae(striaeColor, striaeBgColor, 4, 1);
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

			color.bgColorsUp = [ 0xffe0fe00, 0xffc0a000 ];
			color.bgColorsOver = [ 0xfffffe00, 0xffcac000 ];
			color.bgColorsDown = [ 0xffaa8000, 0xfffffe00 ];
			color.bgColorsDisabled = [ 0xffeeeecc, 0xffcccc82 ];

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
	
	public static var size = 22;
	
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
	
	//----------------------------------------------------------------------------------------------
	//
	//  Images
	//
	//----------------------------------------------------------------------------------------------
	
	public static var imageSize:Int = 12;
	public static var imageHorizontalIndent:Int = 2;
	public static var imageVerticalIndent:Int = 6;
	
	static function newImageBitmapData()
	{
		return new BitmapData(
			imageSize + imageHorizontalIndent * 2,
			imageSize + imageVerticalIndent * 2,
			true,
			0x00000000);
	}
	
	static function getImageOffsetMatrix()
	{
		return new Matrix(1, 0, 0, 1, imageHorizontalIndent, imageVerticalIndent);
	}
	
	static var _imageClose:BitmapData;
	public static function getImageClose():BitmapData
	{
		if (_imageClose == null)
		{
			_imageClose = newImageBitmapData();
			var shape = MBdFactoryUtil.getShape();
			var g = shape.graphics;
			g.clear();
			var halfWidth = 2;
			g.beginFill(0xffffff);
			g.moveTo(0, 0);
			g.lineTo(halfWidth, 0);
			g.lineTo(imageSize, imageSize - halfWidth);
			g.lineTo(imageSize, imageSize);
			g.lineTo(imageSize - halfWidth, imageSize);
			g.lineTo(0, halfWidth);
			g.lineTo(0, 0);
			g.endFill();
			g.beginFill(0xffffff);
			g.moveTo(imageSize, 0);
			g.lineTo(imageSize, halfWidth);
			g.lineTo(halfWidth, imageSize);
			g.lineTo(0, imageSize);
			g.lineTo(0, imageSize - halfWidth);
			g.lineTo(imageSize - halfWidth, 0);
			g.lineTo(imageSize, 0);
			g.endFill();
			MBdFactoryUtil.qualityOn();
			_imageClose.draw(shape, getImageOffsetMatrix());
			_imageClose.applyFilter(
				_imageClose, _imageClose.rect, new Point(),
				new GlowFilter(0x000000, 1, 2, 2));
			MBdFactoryUtil.qualityOff();
		}
		return _imageClose;
	}
	
	static var _imageMinimize:BitmapData;
	public static function getImageMinimize():BitmapData
	{
		if (_imageMinimize == null)
		{
			_imageMinimize = newImageBitmapData();
			var shape = MBdFactoryUtil.getShape();
			var g = shape.graphics;
			g.clear();
			g.beginFill(0xffffff);
			g.drawRect(0, imageSize - 3, imageSize, 3);
			g.endFill();
			MBdFactoryUtil.qualityOn();
			_imageMinimize.draw(shape, getImageOffsetMatrix());
			_imageMinimize.applyFilter(
				_imageMinimize, _imageMinimize.rect, new Point(),
				new GlowFilter(0x000000, 1, 2, 2));
			MBdFactoryUtil.qualityOff();
		}
		return _imageMinimize;
	}
	
	static var _imageMaximize:BitmapData;
	public static function getImageMaximize():BitmapData
	{
		if (_imageMaximize == null)
		{
			_imageMaximize = newImageBitmapData();
			var shape = MBdFactoryUtil.getShape();
			var g = shape.graphics;
			g.clear();
			g.beginFill(0xffffff);
			g.drawRect(0, 0, imageSize, imageSize);
			g.drawRect(2, 3, imageSize - 4, imageSize - 5);
			g.endFill();
			MBdFactoryUtil.qualityOn();
			_imageMaximize.draw(shape, getImageOffsetMatrix());
			_imageMaximize.applyFilter(
				_imageMaximize, _imageMaximize.rect, new Point(),
				new GlowFilter(0x000000, 1, 2, 2));
			MBdFactoryUtil.qualityOff();
		}
		return _imageMaximize;
	}
	
	static var _imageCollapse:BitmapData;
	public static function getImageCollapse():BitmapData
	{
		if (_imageCollapse == null)
		{
			_imageCollapse = newImageBitmapData();
			var shape = MBdFactoryUtil.getShape();
			var g = shape.graphics;
			g.clear();
			g.beginFill(0xffffff);
			g.drawRect(3, 0, imageSize - 3, imageSize - 4);
			g.drawRect(3, 3, imageSize - 5, imageSize - 7);
			g.endFill();
			g.beginFill(0xffffff);
			g.drawRect(0, 4, imageSize - 3, imageSize - 4);
			g.drawRect(2, 7, imageSize - 7, imageSize - 9);
			g.endFill();
			MBdFactoryUtil.qualityOn();
			_imageCollapse.draw(shape, getImageOffsetMatrix());
			_imageCollapse.applyFilter(
				_imageCollapse, _imageCollapse.rect, new Point(),
				new GlowFilter(0x000000, 1, 2, 2));
			MBdFactoryUtil.qualityOff();
		}
		return _imageCollapse;
	}
}