package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import temperate.components.CButtonState;
using temperate.core.CMath;
using temperate.core.CGraphicsUtil;

class MScrollBarBdFactory 
{
	//----------------------------------------------------------------------------------------------
	//
	//  Parametrization
	//
	//----------------------------------------------------------------------------------------------
	
	static function getBgColor()
	{
		return MBdFlatColors.bgColor;
	}
	
	public static var arrowSize = 17;
	
	public static var arrowUpColor:Int = 0xff305000;
	public static var arrowOverColor:Int = 0xff508020;
	public static var arrowDisabledColor:Int = 0x75808080;
	
	public static var thumbCenterLightColor:Int = 0xccffffff;
	public static var thumbCenterDarkColor:Int = 0x80305010;
	
	public static var scrollBgDownColor:Int = 0xffcccccc;
	public static var scrollBgUpColor:Int = 0xffeeeeee;
	public static var scrollBgDarkColor:Int = 0xffd0d0d0;
	public static var scrollBgLightColor:Int = 0xffffffff;
	
	//----------------------------------------------------------------------------------------------
	//
	//  Getters
	//
	//----------------------------------------------------------------------------------------------
	
	//----------------------------------------------------------------------------------------------
	// Arrow up
	//----------------------------------------------------------------------------------------------
	
	static var _leftUp:BitmapData;
	
	public static function getLeftUp()
	{
		if (_leftUp == null)
		{
			_leftUp = newArrow(true, true, CButtonState.UP);
		}
		return _leftUp;
	}
	
	static var _rightUp:BitmapData;
	
	public static function getRightUp()
	{
		if (_rightUp == null)
		{
			_rightUp = newArrow(true, false, CButtonState.UP);
		}
		return _rightUp;
	}
	
	static var _topUp:BitmapData;
	
	public static function getTopUp()
	{
		if (_topUp == null)
		{
			_topUp = newArrow(false, true, CButtonState.UP);
		}
		return _topUp;
	}
	
	static var _bottomUp:BitmapData;
	
	public static function getBottomUp()
	{
		if (_bottomUp == null)
		{
			_bottomUp = newArrow(false, false, CButtonState.UP);
		}
		return _bottomUp;
	}
	
	//----------------------------------------------------------------------------------------------
	// Arrow over
	//----------------------------------------------------------------------------------------------
	
	static var _leftOver:BitmapData;
	
	public static function getLeftOver()
	{
		if (_leftOver == null)
		{
			_leftOver = newArrow(true, true, CButtonState.OVER);
		}
		return _leftOver;
	}
	
	static var _rightOver:BitmapData;
	
	public static function getRightOver()
	{
		if (_rightOver == null)
		{
			_rightOver = newArrow(true, false, CButtonState.OVER);
		}
		return _rightOver;
	}
	
	static var _topOver:BitmapData;
	
	public static function getTopOver()
	{
		if (_topOver == null)
		{
			_topOver = newArrow(false, true, CButtonState.OVER);
		}
		return _topOver;
	}
	
	static var _bottomOver:BitmapData;
	
	public static function getBottomOver()
	{
		if (_bottomOver == null)
		{
			_bottomOver = newArrow(false, false, CButtonState.OVER);
		}
		return _bottomOver;
	}
	
	//----------------------------------------------------------------------------------------------
	// Arrow down
	//----------------------------------------------------------------------------------------------
	
	static var _leftDown:BitmapData;
	
	public static function getLeftDown()
	{
		if (_leftDown == null)
		{
			_leftDown = newArrow(true, true, CButtonState.DOWN);
		}
		return _leftDown;
	}
	
	static var _rightDown:BitmapData;
	
	public static function getRightDown()
	{
		if (_rightDown == null)
		{
			_rightDown = newArrow(true, false, CButtonState.DOWN);
		}
		return _rightDown;
	}
	
	static var _topDown:BitmapData;
	
	public static function getTopDown()
	{
		if (_topDown == null)
		{
			_topDown = newArrow(false, true, CButtonState.DOWN);
		}
		return _topDown;
	}
	
	static var _bottomDown:BitmapData;
	
	public static function getBottomDown()
	{
		if (_bottomDown == null)
		{
			_bottomDown = newArrow(false, false, CButtonState.DOWN);
		}
		return _bottomDown;
	}
	
	//----------------------------------------------------------------------------------------------
	// Arrow disabled
	//----------------------------------------------------------------------------------------------
	
	static var _leftDisabled:BitmapData;
	
	public static function getLeftDisabled()
	{
		if (_leftDisabled == null)
		{
			_leftDisabled = newArrow(true, true, CButtonState.DISABLED);
		}
		return _leftDisabled;
	}
	
	static var _rightDisabled:BitmapData;
	
	public static function getRightDisabled()
	{
		if (_rightDisabled == null)
		{
			_rightDisabled = newArrow(true, false, CButtonState.DISABLED);
		}
		return _rightDisabled;
	}
	
	static var _topDisabled:BitmapData;
	
	public static function getTopDisabled()
	{
		if (_topDisabled == null)
		{
			_topDisabled = newArrow(false, true, CButtonState.DISABLED);
		}
		return _topDisabled;
	}
	
	static var _bottomDisabled:BitmapData;
	
	public static function getBottomDisabled()
	{
		if (_bottomDisabled == null)
		{
			_bottomDisabled = newArrow(false, false, CButtonState.DISABLED);
		}
		return _bottomDisabled;
	}
	
	//----------------------------------------------------------------------------------------------
	// Thumb horizontal
	//----------------------------------------------------------------------------------------------
	
	static var _hThumbUp:BitmapData;
	
	public static function getHThumbUp()
	{
		if (_hThumbUp == null)
		{
			_hThumbUp = getBg(true, CButtonState.UP);
		}
		return _hThumbUp;
	}
	
	static var _hThumbOver:BitmapData;
	
	public static function getHThumbOver()
	{
		if (_hThumbOver == null)
		{
			_hThumbOver = getBg(true, CButtonState.OVER);
		}
		return _hThumbOver;
	}
	
	static var _hThumbDown:BitmapData;
	
	public static function getHThumbDown()
	{
		if (_hThumbDown == null)
		{
			_hThumbDown = getBg(true, CButtonState.DOWN);
		}
		return _hThumbDown;
	}
	
	//----------------------------------------------------------------------------------------------
	// Thumb vertical
	//----------------------------------------------------------------------------------------------
	
	static var _vThumbUp:BitmapData;
	
	public static function getVThumbUp()
	{
		if (_vThumbUp == null)
		{
			_vThumbUp = getBg(false, CButtonState.UP);
		}
		return _vThumbUp;
	}
	
	static var _vThumbOver:BitmapData;
	
	public static function getVThumbOver()
	{
		if (_vThumbOver == null)
		{
			_vThumbOver = getBg(false, CButtonState.OVER);
		}
		return _vThumbOver;
	}
	
	static var _vThumbDown:BitmapData;
	
	public static function getVThumbDown()
	{
		if (_vThumbDown == null)
		{
			_vThumbDown = getBg(false, CButtonState.DOWN);
		}
		return _vThumbDown;
	}
	
	//----------------------------------------------------------------------------------------------
	// Thumb center
	//----------------------------------------------------------------------------------------------
	
	static var _hThumbCenter:BitmapData;
	
	public static function getHThumbCenter()
	{
		if (_hThumbCenter == null)
		{
			_hThumbCenter = newThumbCenter(true);
		}
		return _hThumbCenter;
	}
	
	static var _vThumbCenter:BitmapData;
	
	public static function getVThumbCenter()
	{
		if (_vThumbCenter == null)
		{
			_vThumbCenter = newThumbCenter(false);
		}
		return _vThumbCenter;
	}
	
	//----------------------------------------------------------------------------------------------
	// Background
	//----------------------------------------------------------------------------------------------
	
	static var _hBgUp:BitmapData;
	
	public static function getHBgUp()
	{
		if (_hBgUp == null)
		{
			_hBgUp = newScrollBg(true, false);
		}
		return _hBgUp;
	}
	
	static var _hBgDown:BitmapData;

	public static function getHBgDown()
	{
		if (_hBgDown == null)
		{
			_hBgDown = newScrollBg(true, true);
		}
		return _hBgDown;
	}
	
	static var _vBgUp:BitmapData;
	
	public static function getVBgUp()
	{
		if (_vBgUp == null)
		{
			_vBgUp = newScrollBg(false, false);
		}
		return _vBgUp;
	}
	
	static var _vBgDown:BitmapData;

	public static function getVBgDown()
	{
		if (_vBgDown == null)
		{
			_vBgDown = newScrollBg(false, true);
		}
		return _vBgDown;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Generators
	//
	//----------------------------------------------------------------------------------------------
	
	static function newArrow(horizontal:Bool, left:Bool, state:CButtonState)
	{
		var bitmapData = getBg(horizontal, state).clone();
		
		var arrowColor = switch (state)
		{
			case CButtonState.OVER:
				arrowOverColor;
			case CButtonState.DISABLED:
				arrowDisabledColor;
			default:
				arrowUpColor;
		}
		var arrow = MArrowBdFactory.newUpArrow(arrowColor);
		
		var offsetX = (arrowSize - arrow.width) >> 1;
		var offsetY = (arrowSize - arrow.height) >> 1;
		if (horizontal && left)
		{
			bitmapData.draw(arrow, new Matrix(0, 1, 1, 0, offsetY, offsetX + 1));
		}
		else if (horizontal && !left)
		{
			bitmapData.draw(
				arrow, new Matrix(0, 1, -1, 0, offsetY + arrow.height + 1, offsetX + 1));
		}
		else if (!horizontal && left)
		{
			bitmapData.draw(arrow, new Matrix(1, 0, 0, 1, offsetX + 1, offsetY));
		}
		else
		{
			bitmapData.draw(
				arrow, new Matrix(1, 0, 0, -1, offsetX + 1, offsetY + arrow.height + 1));
		}
		
		return bitmapData;
	}
	
	static var _bgByState:Array<BitmapData> = [];
	
	static function getBg(horizontal:Bool, state:CButtonState)
	{
		var key = state.index * 2 + (horizontal ? 1 : 0);
		var bd = _bgByState[key];
		if (bd == null)
		{
			MBdFactoryUtil.qualityOn();
			
			var params = getBgColor();
			
			bd = new BitmapData(arrowSize, arrowSize, true, 0x00000000);
			var shape = MBdFactoryUtil.getShape();
			var g = shape.graphics;
			
			g.clear();
			
			var enabled = state != CButtonState.DISABLED;
			
			var color = enabled ? params.bgBottomRightColor : params.bgBottomRightDisabledColor;
			g.drawBottomRightBorder(
				0, 0, arrowSize, arrowSize, 3, color.getColor(), color.getAlpha(), 1, true);
			
			var color = enabled ? params.bgTopLeftColor : params.bgTopLeftDisabledColor;
			g.drawTopLeftBorder(
				0, 0, arrowSize, arrowSize, 3, color.getColor(), color.getAlpha(), 1, true);
			
			{
				var boxHeight = 20;
				var matrix = new Matrix();
				matrix.createGradientBox(
					boxHeight, boxHeight, horizontal ? Math.PI * .5 : 0, -3, -3);
				
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
				g.drawRoundRect(1, 1, arrowSize - 2, arrowSize - 2, 4);
				g.endFill();
			}
			
			var color = params.bgInnerTopLeftColor;
			g.drawTopLeftBorder(
				1, 1, arrowSize - 2, arrowSize - 2, 2, color.getColor(), color.getAlpha(), 1, true);
			
			var color = params.bgInnerBottomRightColor;
			g.drawBottomRightBorder(
				1, 1, arrowSize - 2, arrowSize - 2, 2, color.getColor(), color.getAlpha(), 1, true);
			
			if (state == CButtonState.DOWN)
			{
				var color = params.bgInnerDownColor;
				g.drawRoundRectBorder(
					2, 2, arrowSize - 4, arrowSize - 4, 2,
					color.getColor(), color.getAlpha(), 1);
			}
			
			bd.draw(shape);
			_bgByState[key] = bd;
			
			MBdFactoryUtil.qualityOff();
		}
		return bd;
	}
	
	static function newThumbCenter(horizontal:Bool)
	{
		var bd;
		var rect = new Rectangle();
		if (horizontal)
		{
			bd = new BitmapData(8, 10, true, 0x00000000);
			rect.width = 1;
			rect.height = 8;
		}
		else
		{
			bd = new BitmapData(10, 8, true, 0x00000000);
			rect.height = 1;
			rect.width = 8;
		}
		for (i in 0 ... 4)
		{
			if (horizontal)
			{
				rect.x = i << 1;
				rect.y = 1;
				bd.fillRect(rect, thumbCenterLightColor);
				rect.x = (i << 1) + 1;
				rect.y = 2;
				bd.fillRect(rect, thumbCenterDarkColor);
			}
			else
			{
				rect.x = 1;
				rect.y = i << 1;
				bd.fillRect(rect, thumbCenterLightColor);
				rect.x = 2;
				rect.y = (i << 1) + 1;
				bd.fillRect(rect, thumbCenterDarkColor);
			}
		}
		return bd;
	}
	
	static function newScrollBg(horizontal:Bool, down:Bool)
	{
		var bgColor = down ? scrollBgDownColor : scrollBgUpColor;

		var bd = new BitmapData(arrowSize, arrowSize, true, bgColor);
		var rect = new Rectangle();
		if (horizontal)
		{
			rect.height = 1;
			rect.width = arrowSize;
		}
		else
		{
			rect.width = 1;
			rect.height = arrowSize;
		}
		
		if (horizontal)
		{
			rect.y = 0;
			bd.fillRect(rect, scrollBgDarkColor);
			rect.y = 1;
			bd.fillRect(rect, scrollBgLightColor);
			rect.y = arrowSize - 2;
			bd.fillRect(rect, scrollBgLightColor);
			rect.y = arrowSize - 1;
			bd.fillRect(rect, scrollBgDarkColor);
		}
		else
		{
			rect.x = 0;
			bd.fillRect(rect, scrollBgDarkColor);
			rect.x = 1;
			bd.fillRect(rect, scrollBgLightColor);
			rect.x = arrowSize - 2;
			bd.fillRect(rect, scrollBgLightColor);
			rect.x = arrowSize - 1;
			bd.fillRect(rect, scrollBgDarkColor);
		}
		
		return bd;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Slider
	//
	//----------------------------------------------------------------------------------------------
	
	//----------------------------------------------------------------------------------------------
	// Thumb horizontal
	//----------------------------------------------------------------------------------------------
	
	static var _sliderHThumbUp:BitmapData;
	
	public static function getSliderHThumbUp()
	{
		if (_sliderHThumbUp == null)
		{
			_sliderHThumbUp = newSliderThumb(true, CButtonState.UP);
		}
		return _sliderHThumbUp;
	}
	
	static var _sliderHThumbOver:BitmapData;
	
	public static function getSliderHThumbOver()
	{
		if (_sliderHThumbOver == null)
		{
			_sliderHThumbOver = newSliderThumb(true, CButtonState.OVER);
		}
		return _sliderHThumbOver;
	}
	
	static var _sliderHThumbDown:BitmapData;
	
	public static function getSliderHThumbDown()
	{
		if (_sliderHThumbDown == null)
		{
			_sliderHThumbDown = newSliderThumb(true, CButtonState.DOWN);
		}
		return _sliderHThumbDown;
	}
	
	static var _sliderHThumbDisabled:BitmapData;
	
	public static function getSliderHThumbDisabled()
	{
		if (_sliderHThumbDisabled == null)
		{
			_sliderHThumbDisabled = newSliderThumb(true, CButtonState.DISABLED);
		}
		return _sliderHThumbDisabled;
	}
	
	//----------------------------------------------------------------------------------------------
	// Thumb vertical
	//----------------------------------------------------------------------------------------------
	
	static var _sliderVThumbUp:BitmapData;
	
	public static function getSliderVThumbUp()
	{
		if (_sliderVThumbUp == null)
		{
			_sliderVThumbUp = newSliderThumb(false, CButtonState.UP);
		}
		return _sliderVThumbUp;
	}
	
	static var _sliderVThumbOver:BitmapData;
	
	public static function getSliderVThumbOver()
	{
		if (_sliderVThumbOver == null)
		{
			_sliderVThumbOver = newSliderThumb(false, CButtonState.OVER);
		}
		return _sliderVThumbOver;
	}
	
	static var _sliderVThumbDown:BitmapData;
	
	public static function getSliderVThumbDown()
	{
		if (_sliderVThumbDown == null)
		{
			_sliderVThumbDown = newSliderThumb(false, CButtonState.DOWN);
		}
		return _sliderVThumbDown;
	}
	
	static var _sliderVThumbDisabled:BitmapData;
	
	public static function getSliderVThumbDisabled()
	{
		if (_sliderVThumbDisabled == null)
		{
			_sliderVThumbDisabled = newSliderThumb(false, CButtonState.DISABLED);
		}
		return _sliderVThumbDisabled;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Slider generators
	//
	//----------------------------------------------------------------------------------------------
	
	static function newSliderThumb(horizontal:Bool, state:CButtonState)
	{
		var params = getBgColor();
		
		var directSize = 20;
		var crossSize = 12;
		var downOffsetX;
		var downOffsetY;
		var bdWidth;
		var bdHeight;
		if (horizontal)
		{
			downOffsetX = 0;
			downOffsetY = state == CButtonState.DOWN ? 1 : 0;
			bdWidth = directSize;
			bdHeight = crossSize;
		}
		else
		{
			downOffsetX = state == CButtonState.DOWN ? 1 : 0;
			downOffsetY = 0;
			bdWidth = crossSize;
			bdHeight = directSize;
		}
		var width = bdWidth - downOffsetX * 2;
		var height = bdHeight - downOffsetY * 2;
		
		MBdFactoryUtil.qualityOn();
		var bd = new BitmapData(bdWidth, bdHeight, true, 0x00000000);
		var shape = MBdFactoryUtil.getShape();
		var g = shape.graphics;
		
		g.clear();
		
		var enabled = state != CButtonState.DISABLED;
		var diameter1 = 8;
		var diameter2 = 6;
		
		var color = enabled ? params.bgBottomRightColor : params.bgBottomRightDisabledColor;
		g.drawBottomRightBorder(
			downOffsetX, downOffsetY, width, height, diameter1 >> 1,
			color.getColor(), color.getAlpha(), 1, true);
		
		var color = enabled ? params.bgTopLeftColor : params.bgTopLeftDisabledColor;
		g.drawTopLeftBorder(
			downOffsetX, downOffsetY, width, height, diameter1 >> 1,
			color.getColor(), color.getAlpha(), 1, true);
		
		{
			var boxHeight = 12;
			var matrix = new Matrix();
			matrix.createGradientBox(
				boxHeight, boxHeight, horizontal ? Math.PI * .5 : 0, -1, -1);
			
			var colors = [];
			var alphas = [];
			var sourceColors;
			var ratios;
			switch (state)
			{
				case CButtonState.OVER, CButtonState.DOWN:
					sourceColors = params.bgColorsOver;
					ratios = params.bgRatiosOver;
				case CButtonState.DISABLED:
					sourceColors = params.bgColorsDisabled;
					ratios = params.bgRatiosDisabled;
				default:						
					sourceColors = params.bgColorsUp;
					ratios = params.bgRatiosUp;
			}
			MBdFactoryUtil.getColorsAndAlphas(sourceColors, colors, alphas);
			
			g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
			g.drawRoundRect(downOffsetX + 1, downOffsetY + 1, width - 2, height - 2, diameter2);
			g.endFill();
		}
		
		var color = params.bgInnerTopLeftColor;
		g.drawTopLeftBorder(
			downOffsetX + 1, downOffsetY + 1, width - 2, height - 2, diameter2 >> 1,
			color.getColor(), color.getAlpha(), 1, true);
		
		var color = params.bgInnerBottomRightColor;
		g.drawBottomRightBorder(
			downOffsetX + 1, downOffsetY + 1, width - 2, height - 2, diameter2 >> 1,
			color.getColor(), color.getAlpha(), 1, true);
		
		bd.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bd;
	}
}