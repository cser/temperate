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
	
	static var _scrollLeftUp:BitmapData;
	
	public static function getScrollLeftUp()
	{
		if (_scrollLeftUp == null)
		{
			_scrollLeftUp = newScrollUp(true, true, CButtonState.UP);
		}
		return _scrollLeftUp;
	}
	
	static var _scrollLeftOver:BitmapData;
	
	public static function getScrollLeftOver()
	{
		if (_scrollLeftOver == null)
		{
			_scrollLeftOver = newScrollUp(true, true, CButtonState.OVER);
		}
		return _scrollLeftOver;
	}
	
	static function newScrollUp(horizontal:Bool, left:Bool, state:CButtonState)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var bitmapData = getBg(state).clone();
		var g = shape.graphics;
		
		var color = arrowColor;
		if (state == CButtonState.OVER)
		{
			color = 0xffe0ff00;
		}
		g.clear();
		g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
		g.moveTo(-1, -5);
		g.lineTo(4, 1);
		g.lineTo(-1, 7);
		g.lineTo(-3, 5);
		g.lineTo(0, 1);
		g.lineTo(-3, -3);
		g.endFill();
		
		var innerStrength = 1.7;
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
			
			var color = 0xff50a030;
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
				var boxHeight = 15;
				var matrix = new Matrix();
				matrix.createGradientBox(boxHeight, boxHeight, Math.PI / 4);
				
				var colors = [];
				var alphas = [];
				MBdFactoryUtil.getColorsAndAlphas([ 0xffc0ff50, 0xff80cc00 ], colors, alphas);
				
				var ratios = [ 0, 255 ];
				
				g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
				g.drawRoundRect(2, 2, arrowSize - 4, arrowSize - 4, 2);
				g.endFill();
			}
			
			var color = 0x8050a030;
			g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
			g.drawRoundRect(3, 3, arrowSize - 5, arrowSize - 5, 4);
			g.drawRoundRect(3, 3, arrowSize - 6, arrowSize - 6, 4);
			g.endFill();
			
			var color = 0x8050a030;
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