package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import temperate.components.CButtonState;
import temperate.core.CMath;

class MScrollBarBdFactory 
{
	public static var arrowSize = 17;
	public static var arrowColor:UInt = 0xff385900;
	public static var bgColor:UInt = 0xff80f000;
	
	public static var thumbCenterLightColor:UInt = 0xeeffffff;
	public static var thumbCenterDarkColor:UInt = 0x80305010;
	
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
	
	private static var _hBgUp:BitmapData;
	
	public static function getHBgUp()
	{
		if (_hBgUp == null)
		{
			_hBgUp = newScrollBg(true, false);
		}
		return _hBgUp;
	}
	
	private static var _hBgDown:BitmapData;

	public static function getHBgDown()
	{
		if (_hBgDown == null)
		{
			_hBgDown = newScrollBg(true, true);
		}
		return _hBgDown;
	}
	
	private static var _vBgUp:BitmapData;
	
	public static function getVBgUp()
	{
		if (_vBgUp == null)
		{
			_vBgUp = newScrollBg(false, false);
		}
		return _vBgUp;
	}
	
	private static var _vBgDown:BitmapData;

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
	
	static var _upArrow:BitmapData;
	
	static function getUpArrow()
	{
		if (_upArrow == null)
		{
			_upArrow = MArrowBdFactory.newUpArrow(arrowColor);
		}
		return _upArrow;
	}
	
	static function newArrow(horizontal:Bool, left:Bool, state:CButtonState)
	{
		var bitmapData = getBg(horizontal, state).clone();
		var arrow = getUpArrow();
		
		var transform;
		switch (state)
		{
			case CButtonState.OVER:
				transform = new ColorTransform(1.5, 1.5, 1.5);
			case CButtonState.DISABLED:
				transform = new ColorTransform(1.5, 1, 1.5, .3);
			default:
				transform = new ColorTransform();
		}
		
		var offsetX = (arrowSize - arrow.width) >> 1;
		var offsetY = (arrowSize - arrow.height) >> 1;
		if (horizontal && left)
		{
			var tx = offsetY;
			var ty = offsetX + 1;
			bitmapData.draw(arrow, new Matrix(0, 1, 1, 0, tx, ty), transform);
		}
		else if (horizontal && !left)
		{
			var tx = offsetY + arrow.height + 1;
			var ty = offsetX + 1;
			bitmapData.draw(arrow, new Matrix(0, 1, -1, 0, tx, ty), transform);
		}
		else if (!horizontal && left)
		{
			var tx = offsetX + 1;
			var ty = offsetY;
			bitmapData.draw(arrow, new Matrix(1, 0, 0, 1, tx, ty), transform);
		}
		else
		{
			var tx = offsetX + 1;
			var ty = offsetY + arrow.height + 1;
			bitmapData.draw(arrow, new Matrix(1, 0, 0, -1, tx, ty), transform);
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
			
			bd = new BitmapData(arrowSize, arrowSize, true, 0x00000000);
			var shape = MBdFactoryUtil.getShape();
			var g = shape.graphics;
			
			g.clear();
			
			var enabled = state != CButtonState.DISABLED;
			
			var color = enabled ? 0xff306010 : 0xffbabaaa;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(0, 0, arrowSize, arrowSize, 6);
			g.drawRoundRect(0, 0, arrowSize - 1, arrowSize - 1, 6);
			g.endFill();
			
			var color = enabled ? 0xffa0c070 : 0xffcccccc;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(0, 0, arrowSize, arrowSize, 6);
			g.drawRoundRect(1, 1, arrowSize - 1, arrowSize - 1, 6);
			g.endFill();
			
			{
				var boxHeight = 20;
				var matrix = new Matrix();
				matrix.createGradientBox(
					boxHeight, boxHeight, horizontal ? Math.PI * .5 : 0, -3, -3);
				
				var colors = [];
				var alphas = [];
				var sourceColors;
				switch (state)
				{
					case CButtonState.OVER:
						sourceColors = [ 0xffbfef50, 0xffafcf30 ];
					case CButtonState.DOWN:
						sourceColors = [ 0xff80af00, 0xffb0d030 ];
					case CButtonState.DISABLED:
						sourceColors = [ 0xffe8fac0, 0xffddefaa ];
					default:
						sourceColors = [ 0xffaae030, 0xff80c000 ];
				}
				MBdFactoryUtil.getColorsAndAlphas(sourceColors, colors, alphas);
				
				var ratios = [ 100, 255 ];
				
				g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
				g.drawRoundRect(1, 1, arrowSize - 2, arrowSize - 2, 4);
				g.endFill();
			}
			
			var color = 0xffffffff;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(1, 1, arrowSize - 2, arrowSize - 2, 4);
			g.drawRoundRect(2, 2, arrowSize - 4, arrowSize - 4, 4);
			g.endFill();
			
			var color = enabled ? 0x2e000000 : 0x10000000;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(2, 2, arrowSize - 4, arrowSize - 4, 4);
			g.drawRoundRect(3, 3, arrowSize - 5, arrowSize - 5, 4);
			g.endFill();
			
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
		var bgColor = down ? 0xffcccccc : 0xffeeeeee;
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
		
		var darkColor = 0xffd0d0d0;
		var lightColor = 0xffffffff;
		if (horizontal)
		{
			rect.y = 0;
			bd.fillRect(rect, darkColor);
			rect.y = 1;
			bd.fillRect(rect, lightColor);
			rect.y = arrowSize - 2;
			bd.fillRect(rect, lightColor);
			rect.y = arrowSize - 1;
			bd.fillRect(rect, darkColor);
		}
		else
		{
			rect.x = 0;
			bd.fillRect(rect, darkColor);
			rect.x = 1;
			bd.fillRect(rect, lightColor);
			rect.x = arrowSize - 2;
			bd.fillRect(rect, lightColor);
			rect.x = arrowSize - 1;
			bd.fillRect(rect, darkColor);
		}
		
		return bd;
	}
}