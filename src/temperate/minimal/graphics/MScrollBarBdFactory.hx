package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.Graphics;
import flash.geom.Matrix;
import temperate.components.CButtonState;
import temperate.core.CMath;

class MScrollBarBdFactory 
{
	public static var arrowSize = 17;
	public static var arrowColor:UInt = 0xff508000;
	public static var bgColor:UInt = 0xff80f000;
	
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
			_topOver = newArrow(false, false, CButtonState.OVER);
		}
		return _topOver;
	}
	
	static var _bottomOver:BitmapData;
	
	public static function getBottomOver()
	{
		if (_bottomOver == null)
		{
			_bottomOver = newArrow(true, true, CButtonState.OVER);
		}
		return _bottomOver;
	}
	
	static var _hThumbUp:BitmapData;
	
	public static function getHThumbUp()
	{
		if (_hThumbUp == null)
		{
			_hThumbUp = newThumb(true, CButtonState.UP);
		}
		return _hThumbUp;
	}
	
	static var _hThumbOver:BitmapData;
	
	public static function getHThumbOver()
	{
		if (_hThumbOver == null)
		{
			_hThumbOver = newThumb(true, CButtonState.OVER);
		}
		return _hThumbOver;
	}
	
	static var _vThumbUp:BitmapData;
	
	public static function getVThumbUp()
	{
		if (_vThumbUp == null)
		{
			_vThumbUp = newThumb(false, CButtonState.UP);
		}
		return _vThumbUp;
	}
	
	static var _vThumbOver:BitmapData;
	
	public static function getVThumbOver()
	{
		if (_vThumbOver == null)
		{
			_vThumbOver = newThumb(false, CButtonState.OVER);
		}
		return _vThumbOver;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Generators
	//
	//----------------------------------------------------------------------------------------------
	
	static function newArrow(horizontal:Bool, left:Bool, state:CButtonState)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var bitmapData = getBg(state).clone();
		var g = shape.graphics;
		
		var color = arrowColor;
		g.clear();
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.moveTo(-1, -5);
		g.lineTo(4, 1);
		g.lineTo(-1, 7);
		g.lineTo(-3, 5);
		g.lineTo(0, 1);
		g.lineTo(-3, -3);
		g.endFill();
		
		var offsetX = arrowSize >> 1;
		var offsetY = arrowSize >> 1;
		
		if (horizontal && !left)
		{
			bitmapData.draw(shape, new Matrix(1, 0, 0, 1, offsetX, offsetY));
		}
		else if (horizontal && left)
		{
			bitmapData.draw(shape, new Matrix(-1, 0, 0, 1, arrowSize - offsetX, offsetY));
		}
		else if (!horizontal && !left)
		{
			bitmapData.draw(shape, new Matrix(0, 1, -1, 0, arrowSize - offsetX, offsetY));
		}
		else
		{
			bitmapData.draw(shape, new Matrix(0, -1, 1, 0, offsetX, arrowSize - offsetY));
		}
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
	
	static function newThumb(horizontal:Bool, state:CButtonState)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var bd = new BitmapData(arrowSize, arrowSize, true, 0x00000000);
		var shape = MBdFactoryUtil.getShape();
		var g = shape.graphics;
		
		g.clear();
		
		var color = 0xff407020;
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.drawRoundRect(0, 0, arrowSize, arrowSize, 4);
		g.drawRoundRect(0, 0, arrowSize - 1, arrowSize - 1, 4);
		g.endFill();
		
		var color = 0xffc0e0a0;
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.drawRoundRect(0, 0, arrowSize, arrowSize, 4);
		g.drawRoundRect(1, 1, arrowSize - 1, arrowSize - 1, 4);
		g.endFill();
		
		var color = 0xffffffff;
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.drawRoundRect(1, 1, arrowSize - 2, arrowSize - 2, 2);
		g.endFill();
		
		{
			var boxHeight = 20;
			var matrix = new Matrix();
			matrix.createGradientBox(boxHeight, boxHeight, 0, -3, -3);
			
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
		
		var color = 0xf050a030;
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.drawRoundRect(3, 3, arrowSize - 4, arrowSize - 4, 4);
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
	}
	
	static var _bgByState:Array<BitmapData> = [];
	
	static function getBg(state:CButtonState)
	{
		var bd = _bgByState[state.index];
		if (bd == null)
		{
			bd = new BitmapData(arrowSize, arrowSize, true, 0x00000000);
			var shape = MBdFactoryUtil.getShape();
			var g = shape.graphics;
			
			g.clear();
			
			var color = 0xff407020;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(0, 0, arrowSize, arrowSize, 4);
			g.drawRoundRect(0, 0, arrowSize - 1, arrowSize - 1, 4);
			g.endFill();
			
			var color = 0xffc0e0a0;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(0, 0, arrowSize, arrowSize, 4);
			g.drawRoundRect(1, 1, arrowSize - 1, arrowSize - 1, 4);
			g.endFill();
			
			var color = 0xffffffff;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(1, 1, arrowSize - 2, arrowSize - 2, 2);
			g.endFill();
			
			{
				var boxHeight = 20;
				var matrix = new Matrix();
				matrix.createGradientBox(boxHeight, boxHeight, 0, -3, -3);
				
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
			
			var color = 0xf050a030;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(3, 3, arrowSize - 4, arrowSize - 4, 4);
			g.drawRoundRect(3, 3, arrowSize - 6, arrowSize - 6, 4);
			g.endFill();
			
			var color = 0xf050a030;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(2, 2, arrowSize - 4, arrowSize - 4, 2);
			g.drawRoundRect(3, 3, arrowSize - 5, arrowSize - 5, 2);
			g.endFill();
			
			bd.draw(shape);
			_bgByState[state.index] = bd;
		}
		return bd;
	}
}