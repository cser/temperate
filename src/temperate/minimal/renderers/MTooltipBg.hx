package temperate.minimal.renderers;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;
import temperate.core.CGeomUtil;
import temperate.core.CMath;

class MTooltipBg extends Sprite
{
	public function new() 
	{
		super();
		
		borderRadius = 4;
		borderThickness = 1;
		tailIndent = -4;
		tailHalfWidth = 6;
		fillColor = 0xffffffe0;
		borderColor = 0xff808080;
	}
	
	public var borderRadius:Int;
	
	public var borderThickness:Int;
	
	public var tailIndent:Int;
	
	public var tailHalfWidth:Int;
	
	public var fillColor:UInt;
	
	public var borderColor:UInt;
	
	var _tailBeginX:Float;
	var _tailBeginY:Float;
	var _tailEndX:Float;
	var _tailEndY:Float;
	var _width:Float;
	var _height:Float;
	
	public function redraw(width:Float, height:Float, target:Rectangle):Void
	{
		_width = width;
		_height = height;
		
		var centerX = _width * .5;
		var centerY = _height * .5;
		var targetCenterX = target.x + target.width * .5;
		var targetCenterY = target.y + target.height * .5;
		
		CGeomUtil.getNearestRectCross(
			targetCenterX, targetCenterY,
			centerX, centerY,
			tailHalfWidth + 1, tailHalfWidth + 1,
			_width - tailHalfWidth * 2 - 2, _height - tailHalfWidth * 2 - 2,
			0
		);
		_tailBeginX = CGeomUtil.crossX;
		_tailBeginY = CGeomUtil.crossY;
		
		CGeomUtil.getNearestRectCross(
			centerX, centerY,
			targetCenterX, targetCenterY,
			target.x, target.y, target.width, target.height,
			tailIndent
		);
		_tailEndX = CGeomUtil.crossX;
		_tailEndY = CGeomUtil.crossY;
		
		drawShape();
	}
	
	function drawShape()
	{
		var dx = _tailEndX - _tailBeginX;
		var dy = _tailEndY - _tailBeginY;
		var a = Math.sqrt(dx * dx + dy * dy);
		
		var tail = null;
		if (a > 1)
		{
			var cos = dx / a;
			var sin = dy / a;
			tail = [
				_tailBeginX - tailHalfWidth * sin, _tailBeginY + tailHalfWidth * cos,
				_tailEndX, _tailEndY,
				_tailBeginX + tailHalfWidth * sin, _tailBeginY - tailHalfWidth * cos];
		}
		
		var x0 = borderThickness;
		var y0 = borderThickness;
		var x1 = _width - borderThickness * 2;
		var y1 = _height - borderThickness * 2;
		var rect:Array<Float>;
		if (borderRadius > 0)
		{
			rect = [];
			var i = 0;
			
			rect[i++] = x0 + borderRadius;
			rect[i++] = y0;
			rect[i++] = x1 - borderRadius;
			rect[i++] = y0;
			
			i = addArcPoints(
				rect, i, x1 - borderRadius, y0 + borderRadius, -Math.PI * .5, 0);
			
			rect[i++] = x1;
			rect[i++] = y0 + borderRadius;
			rect[i++] = x1;
			rect[i++] = y1 - borderRadius;
			
			i = addArcPoints(
				rect, i, x1 - borderRadius, y1 - borderRadius, 0, Math.PI * .5);
			
			rect[i++] = x1 - borderRadius;
			rect[i++] = y1;
			rect[i++] = x0 + borderRadius;
			rect[i++] = y1;
			
			i = addArcPoints(
				rect, i, x0 + borderRadius, y1 - borderRadius, Math.PI * .5, Math.PI);
			
			rect[i++] = x0;
			rect[i++] = y1 - borderRadius;
			rect[i++] = x0;
			rect[i++] = y0 + borderRadius;
			
			i = addArcPoints(
				rect, i, x0 + borderRadius, y0 + borderRadius, -Math.PI, -Math.PI * .5);
		}
		else
		{
			rect = [x0, y0, x1, y0, x1, y1, x0, y1];
		}
		var poligon = tail != null ? CGeomUtil.getUnionOfConvexPoligons(rect, tail, 100) : rect;
		
		
		var g = graphics;
		g.clear();
		g.lineStyle(
			borderThickness, CMath.getColor(borderColor), CMath.getAlpha(borderColor), true);
		g.beginFill(CMath.getColor(fillColor), CMath.getAlpha(fillColor));
		
		var i = 0;
		var x0 = poligon[i];
		var y0 = poligon[i + 1];
		g.moveTo(x0, y0);
		i += 2;
		while (i < poligon.length)
		{
			var x = poligon[i];
			var y = poligon[i + 1];
			g.lineTo(x, y);
			i += 2;
		}
		g.lineTo(x0, y0);
		
		g.endFill();
	}
	
	function addArcPoints(
		coords:Array<Float>, startIndex:Int, x0:Float, y0:Float, begin:Float, end:Float):Int
	{
		var count:Int = Std.int(borderRadius * .3);
		if (count < 1)
		{
			count = 1;
		}
		var step = (end - begin) / (count + 1);
		var angle = begin + step;
		while (angle < end - .00001)
		{
			coords[startIndex++] = x0 + Math.cos(angle) * borderRadius;
			coords[startIndex++] = y0 + Math.sin(angle) * borderRadius;
			angle += step;
		}
		return startIndex;
	}
	
	function getMinPositive(k0:Float, k1:Float, k2:Float, k3:Float)
	{
		var k = Math.POSITIVE_INFINITY;
		if (k0 > 0)
		{
			k = k0;
		}
		if (k1 > 0 && k1 < k)
		{
			k = k1;
		}
		if (k2 > 0 && k2 < k)
		{
			k = k2;
		}
		if (k3 > 0 && k3 < k)
		{
			k = k3;
		}
		return k == Math.POSITIVE_INFINITY ? 0 : k;
	}
}