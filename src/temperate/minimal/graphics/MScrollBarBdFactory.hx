package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.Graphics;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import temperate.components.CButtonState;
import temperate.core.CMath;

class MScrollBarBdFactory 
{
	public static var arrowSize = 17;
	public static var arrowColor:UInt = 0xff508000;
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
	// Thumb
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
	
	//----------------------------------------------------------------------------------------------
	// Thumb over
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
	//
	//  Generators
	//
	//----------------------------------------------------------------------------------------------
	
	static var _upArrow:BitmapData;
	
	static function getUpArrow()
	{
		if (_upArrow == null)
		{
			_upArrow = new BitmapData(10, 6, true, 0x00000000);
			
			var line = [
				4, 0, 5, 0,
				3, 1, 4, 1, 5, 1, 6, 1,
				2, 2, 3, 2, 4, 2, 5, 2, 6, 2, 7, 2,
				1, 3, 2, 3, 3, 3, 4, 3, 5, 3, 6, 3, 7, 3, 8, 3,
				0, 4, 1, 4, 2, 4, 3, 4, 6, 4, 7, 4, 8, 4, 9, 4,
				0, 5, 1, 5, 8, 5, 9, 5
			];
			var i = line.length - 1;
			do
			{
				_upArrow.setPixel32(line[i - 1], line[i], arrowColor);
				i -= 2;
			}
			while (i > 0);
		}
		return _upArrow;
	}
	
	static function newArrow(horizontal:Bool, left:Bool, state:CButtonState)
	{
		MBdFactoryUtil.qualityOn();
		
		var bitmapData = getBg(horizontal, state).clone();
		var arrow = getUpArrow();
		
		var offsetX = (arrowSize - arrow.width) >> 1;
		var offsetY = (arrowSize - arrow.height) >> 1;
		
		if (horizontal && left)
		{
			bitmapData.draw(
				arrow, new Matrix(0, 1, 1, 0, offsetY, offsetX + 1));
		}
		else if (horizontal && !left)
		{
			bitmapData.draw(
				arrow, new Matrix(0, 1, -1, 0, offsetY + arrow.height + 1, offsetX + 1));
		}
		else if (!horizontal && left)
		{
			bitmapData.draw(arrow, new Matrix(1, 0, 0, 1, offsetX, offsetY));
		}
		else
		{
			bitmapData.draw(arrow, new Matrix(1, 0, 0, -1, offsetX, offsetY + arrow.height + 1));
		}
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
	
	/*static function newThumb(horizontal:Bool, state:CButtonState)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var bd = new BitmapData(arrowSize, arrowSize, true, 0x00000000);
		var shape = MBdFactoryUtil.getShape();
		var g = shape.graphics;
		
		g.clear();
		
		var color = 0xff407020;
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.drawRoundRect(0, 0, arrowSize, arrowSize, 6);
		g.drawRoundRect(0, 0, arrowSize - 1, arrowSize - 1, 6);
		g.endFill();
		
		var color = 0xffc0e0a0;
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.drawRoundRect(0, 0, arrowSize, arrowSize, 6);
		g.drawRoundRect(1, 1, arrowSize - 1, arrowSize - 1, 6);
		g.endFill();
		
		var color = 0xffffffff;
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.drawRoundRect(1, 1, arrowSize - 2, arrowSize - 2, 2);
		g.endFill();
		
		{
			var boxHeight = 20;
			var matrix = new Matrix();
			matrix.createGradientBox(
				boxHeight, boxHeight, 0, -3, -3);
			
			var colors = [];
			var alphas = [];
			var sourceColors;
			switch (state)
			{
				case CButtonState.OVER:
					sourceColors = [ 0xffe0ff80, 0xffc0ee30 ];
				default:
					sourceColors = [ 0xffc0ff50, 0xff80cc00 ];
			}
			MBdFactoryUtil.getColorsAndAlphas(sourceColors, colors, alphas);
			
			var ratios = [ 0, 255 ];
			
			g.beginGradientFill(GradientType.RADIAL, colors, alphas, ratios, matrix);
			g.drawRoundRect(2, 2, arrowSize - 4, arrowSize - 4, 2);
			g.endFill();
		}
		
		var color = 0x8050a030;
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.drawRoundRect(3, 3, arrowSize - 5, arrowSize - 5, 4);
		g.drawRoundRect(3, 3, arrowSize - 6, arrowSize - 6, 4);
		g.endFill();
		
		var color = 0xf050a030;
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.drawRoundRect(2, 2, arrowSize - 4, arrowSize - 4, 2);
		g.drawRoundRect(3, 3, arrowSize - 5, arrowSize - 5, 2);
		g.endFill();
			
		bd.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bd;
	}*/
	
	static var _bgByState:Array<BitmapData> = [];
	
	static function getBg(horizontal:Bool, state:CButtonState)
	{
		var bd = _bgByState[state.index];
		if (bd == null)
		{
			bd = new BitmapData(arrowSize, arrowSize, true, 0x00000000);
			var shape = MBdFactoryUtil.getShape();
			var g = shape.graphics;
			
			g.clear();
			
			var color = 0xff306010;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(0, 0, arrowSize, arrowSize, 6);
			g.drawRoundRect(0, 0, arrowSize - 1, arrowSize - 1, 6);
			g.endFill();
			
			var color = 0xffa0c070;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(0, 0, arrowSize, arrowSize, 6);
			g.drawRoundRect(1, 1, arrowSize - 1, arrowSize - 1, 6);
			g.endFill();
			
			{
				var boxHeight = 20;
				var matrix = new Matrix();
				matrix.createGradientBox(
					boxHeight, boxHeight, horizontal ? 0 : Math.PI * .5, -3, -3);
				
				var colors = [];
				var alphas = [];
				var sourceColors;
				switch (state)
				{
					case CButtonState.OVER:
						sourceColors = [ 0xffe0ff80, 0xffc0ee30 ];
					default:
						sourceColors = [ 0xffc0ff00, 0xff70c000 ];
				}
				MBdFactoryUtil.getColorsAndAlphas(sourceColors, colors, alphas);
				
				var ratios = [ 0, 255 ];
				
				g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
				g.drawRoundRect(1, 1, arrowSize - 2, arrowSize - 2, 4);
				g.endFill();
			}
			
			/*{
				var boxHeight = 20;
				var matrix = new Matrix();
				matrix.createGradientBox(boxHeight, boxHeight, Math.PI * .5, -3, -3);
				
				var colors = [];
				var alphas = [];
				var sourceColors = [ 0xffffffff, 0x80ffffff ];
				MBdFactoryUtil.getColorsAndAlphas(sourceColors, colors, alphas);
				
				var ratios = [ 0, 255 ];
				g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
				g.drawRoundRect(1, 1, arrowSize - 2, arrowSize - 2, 4);
				g.drawRoundRect(2, 2, arrowSize - 4, arrowSize - 4, 4);
				g.endFill();
			}*/
			
			var color = 0xffffffff;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(1, 1, arrowSize - 2, arrowSize - 2, 4);
			g.drawRoundRect(2, 2, arrowSize - 4, arrowSize - 4, 4);
			g.endFill();
			
			/*var color = 0x8050a030;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(3, 3, arrowSize - 5, arrowSize - 5, 6);
			g.drawRoundRect(3, 3, arrowSize - 6, arrowSize - 6, 6);
			g.endFill();*/
			
			/*var color = 0xf050a030;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(2, 2, arrowSize - 4, arrowSize - 4, 4);
			g.drawRoundRect(3, 3, arrowSize - 5, arrowSize - 5, 4);
			g.endFill();*/
			
			bd.draw(shape);
			_bgByState[state.index] = bd;
		}
		return bd;
	}
	
	static function newThumbCenter(horizontal:Bool)
	{
		var bd = new BitmapData(10, 10, true, 0x00000000);
		var rect = new Rectangle();
		if (horizontal)
		{
			rect.width = 1;
			rect.height = 8;
		}
		else
		{
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
}