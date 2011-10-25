package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.filters.DropShadowFilter;
import flash.geom.Point;

class MCursorBdFactory 
{
	static var _handUp:BitmapData;
	
	public static function getHandUp()
	{
		if (_handUp == null)
		{
			_handUp = newHand(false);
		}
		return _handUp;
	}
	
	static var _handDown:BitmapData;
	
	public static function getHandDown()
	{
		if (_handDown == null)
		{
			_handDown = newHand(true);
		}
		return _handDown;
	}
	
	static var _forbidden:BitmapData;
	
	public static function getForbidden()
	{
		if (_forbidden == null)
		{
			_forbidden = newForbidden();
		}
		return _forbidden;
	}
	
	static var _wait:BitmapData;
	
	public static function getWait()
	{
		if (_wait == null)
		{
			_wait = newWait();
		}
		return _wait;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Generators
	//
	//----------------------------------------------------------------------------------------------
	
	static function newHand(down:Bool)
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var g = shape.graphics;
		g.clear();
		if (down)
		{
			drawHandDown(g, true);
			drawHandDown(g, false);
		}
		else
		{
			drawHandUp(g, true);
			drawHandUp(g, false);
		}
		
		var bitmapData = new BitmapData(20, 24, true, 0x00000000);
		bitmapData.draw(shape);
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
	
	static function newForbidden()
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var borderColor = 0x000000;
		var fillColor = 0x808080;
		var r = 8;
		var x0 = r + 2;
		var y0 = r + 2;
		
		var g = shape.graphics;
		g.clear();
		
		g.lineStyle(4, borderColor);
		g.drawCircle(x0, y0, r);
		
		var sin = Math.sin(Math.PI * .25);
		var cos = Math.cos(Math.PI * .25);
		
		g.moveTo(x0 + sin * r, y0 + cos * r);
		g.lineTo(x0 - sin * r, y0 - cos * r);
		
		g.lineStyle(2, fillColor);
		g.drawCircle(x0, y0, r);
		
		g.moveTo(x0 + sin * r, y0 + cos * r);
		g.lineTo(x0 - sin * r, y0 - cos * r);
		
		var bitmapData = new BitmapData(x0 * 2 + 4, y0 * 2 + 4, true, 0x00000000);
		bitmapData.draw(shape);
		bitmapData.applyFilter(
			bitmapData, bitmapData.rect, new Point(),
			new DropShadowFilter(2, 45, 0x000000, .5, 2, 2)
		);
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
	
	static function newWait()
	{
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		
		var borderColor = 0x000000;
		var fillColor = 0x808080;
		var color = 0xffffff;
		var r = 10;
		var x0 = r + 2;
		var y0 = r + 2;
		
		var g = shape.graphics;
		g.clear();
		
		g.beginFill(color);
		g.drawCircle(x0, y0, r);
		g.endFill();
		
		g.beginFill(fillColor);
		g.drawCircle(x0, y0, r + 1);
		g.drawCircle(x0, y0, r);
		g.endFill();
		
		g.beginFill(borderColor);
		g.drawCircle(x0, y0, r - 1);
		g.drawCircle(x0, y0, r - 3);
		g.endFill();
		
		g.lineStyle(1, borderColor);
		
		g.moveTo(x0 - r + 1, y0);
		g.lineTo(x0 - r + 5, y0);
		g.moveTo(x0 + r - 1, y0);
		g.lineTo(x0 + r - 5, y0);
		g.moveTo(x0, y0 + r - 1);
		g.lineTo(x0, y0 + r - 5);
		g.moveTo(x0, y0 - r + 1);
		g.lineTo(x0, y0 - r + 5);
		
		g.moveTo(x0, y0);
		g.lineTo(x0 + 3, y0 - 5);
		g.moveTo(x0, y0);
		g.lineTo(x0 + 4, y0 + 3);
		
		var bitmapData = new BitmapData(x0 * 2 + 4, y0 * 2 + 4, true, 0x00000000);
		bitmapData.draw(shape);
		bitmapData.applyFilter(
			bitmapData, bitmapData.rect, new Point(),
			new DropShadowFilter(2, 45, 0x000000, .5, 2, 2)
		);
		
		MBdFactoryUtil.qualityOff();
		return bitmapData;
	}
	
	static function drawHandBegin(g:Graphics, drawBorder:Bool)
	{
		if (drawBorder)
		{
			g.lineStyle(2, 0x000000);
		}
		else
		{
			g.lineStyle();
			g.beginFill(0xffffff);
		}
	}
	
	static function drawHandEnd(g:Graphics, drawBorder:Bool)
	{
		if (!drawBorder)
		{
			g.endFill();
		}
	}
	
	static function drawHandUp(g:Graphics, drawBorder:Bool)
	{
		var x0 = 11;
		var y0 = 12;
		
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 - 6, y0, 11, 10, 6);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 - 6, y0 - 9, 2, 14, 4);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 - 3, y0 - 10, 2, 14, 4);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0, y0 - 10, 2, 14, 4);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 + 3, y0 - 8, 2, 14, 4);
		drawHandEnd(g, drawBorder);
		
		g.moveTo(x0 - 4, y0 + 10);
		drawHandBegin(g, drawBorder);
		g.lineTo(x0 - 10, y0 + 5);
		g.lineTo(x0 - 10, y0 - 1);
		g.lineTo(x0 - 8, y0);
		g.lineTo(x0 - 8, y0 + 2);
		g.lineTo(x0 - 7, y0 + 3);
		g.moveTo(x0 - 4, y0 + 3);
		drawHandEnd(g, drawBorder);
	}
	
	static function drawHandDown(g:Graphics, drawBorder:Bool)
	{
		var x0 = 11;
		var y0 = 12;
		
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 - 6, y0, 11, 10, 6);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 - 6, y0 - 4, 2, 10, 4);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 - 3, y0 - 5, 2, 10, 4);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0, y0 - 5, 2, 10, 4);
		drawHandEnd(g, drawBorder);
		drawHandBegin(g, drawBorder);
		g.drawRoundRect(x0 + 3, y0 - 4, 2, 10, 4);
		drawHandEnd(g, drawBorder);
		
		g.moveTo(x0 - 4, y0 + 10);
		drawHandBegin(g, drawBorder);
		g.lineTo(x0 - 10, y0 + 4);
		g.lineTo(x0 - 8, y0);
		g.lineTo(x0 - 8, y0);
		g.lineTo(x0 - 7, y0 + 2);
		g.lineTo(x0 - 7, y0 + 3);
		g.moveTo(x0 - 4, y0 + 3);
		drawHandEnd(g, drawBorder);
	}
}