package temperate.minimal.graphics;
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.filters.DropShadowFilter;
import flash.geom.Point;

class MCursorBdFactory 
{
	public static function getHandUp()
	{
		if (!_generated)
		{
			generate();
		}
		return _handUp;
	}
	
	public static function getHandDown()
	{
		if (!_generated)
		{
			generate();
		}
		return _handDown;
	}
	
	public static function getForbidden()
	{
		if (!_generated)
		{
			generate();
		}
		return _forbidden;
	}
	
	public static function getResize()
	{
		if (!_generated)
		{
			generate();
		}
		return _resize;
	}
	
	public static function getWait()
	{
		if (!_generated)
		{
			generate();
		}
		return _wait;
	}
	
	static var _generated = false;
	static var _handUp:BitmapData;
	static var _handDown:BitmapData;
	static var _forbidden:BitmapData;
	static var _resize:BitmapData;
	static var _wait:BitmapData;
	
	static function generate()
	{
		_generated = true;
		
		MBdFactoryUtil.qualityOn();
		var shape = MBdFactoryUtil.getShape();
		var g = shape.graphics;
		var shadowFilter = new DropShadowFilter(2, 45, 0x000000, .5, 2, 2);
		var zero = new Point();
		_handUp = {
			g.clear();
			drawHandUp(g, true);
			drawHandUp(g, false);
			var bd = new BitmapData(20, 24, true, 0x00000000);
			bd.draw(shape);
			bd;
		}
		_handDown = {
			g.clear();
			drawHandDown(g, true);
			drawHandDown(g, false);
			var bd = new BitmapData(20, 24, true, 0x00000000);
			bd.draw(shape);
			bd;
		}
		_forbidden = {
			var borderColor = 0x000000;
			var fillColor = 0x808080;
			var r = 8;
			var x0 = r + 2;
			var y0 = r + 2;
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
			
			var bd = new BitmapData(x0 * 2 + 4, y0 * 2 + 4, true, 0x00000000);
			bd.draw(shape);
			bd.applyFilter(bd, bd.rect, zero, shadowFilter);
			bd;
		}
		_resize = {
			g.clear();
			
			g.lineStyle(0, 0x000000, 1, true);
			g.beginFill(0x808080);
			g.moveTo(0, 0);
			g.lineTo(6, 0);
			g.lineTo(3, 2);
			g.lineTo(14, 13);
			g.lineTo(16, 10);
			g.lineTo(16, 16);
			g.lineTo(10, 16);
			g.lineTo(13, 14);
			g.lineTo(2, 3);
			g.lineTo(0, 6);
			g.lineTo(0, 0);
			
			var bd = new BitmapData(20, 20, true, 0x00000000);
			bd.draw(shape);
			bd.applyFilter(bd, bd.rect, zero, shadowFilter);
			bd;
		}
		_wait = {
			var borderColor = 0x000000;
			var fillColor = 0x808080;
			var color = 0xffffff;
			var r = 10;
			var x0 = r + 2;
			var y0 = r + 2;
			
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
			
			var bd = new BitmapData(x0 * 2 + 4, y0 * 2 + 4, true, 0x00000000);
			bd.draw(shape);
			bd.applyFilter(bd, bd.rect, zero, shadowFilter);
			bd;
		}
		MBdFactoryUtil.qualityOff();
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