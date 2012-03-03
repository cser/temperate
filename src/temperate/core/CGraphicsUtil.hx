package temperate.core;
import flash.display.GradientType;
import flash.display.Graphics;
import flash.geom.Matrix;

class CGraphicsUtil 
{
	public static function drawRoundRectBorder(
		g:Graphics,
		x:Float, y:Float, width:Float, height:Float, radius:Float, color:UInt, alpha:Float,
		thickness:Int):Void
	{
		var x1 = x + width;
		var y1 = y + height;
		
		g.beginFill(color, alpha);
		g.moveTo(x, y1 - radius);
		g.lineTo(x, y + radius);
		g.curveTo(x, y, x + radius, y);
		g.lineTo(x1 - radius, y);
		g.curveTo(x1, y, x1, y + radius);
		g.lineTo(x1, y1 - radius);
		g.lineTo(x1 - thickness, y1 - radius);
		g.lineTo(x1 - thickness, y + radius);
		g.curveTo(x1 - thickness, y + thickness, x1 - radius, y + thickness);
		g.lineTo(x + radius, y + thickness);
		g.curveTo(x + thickness, y + thickness, x + thickness, y + radius);
		g.lineTo(x + thickness, y1 - radius);
		g.lineTo(x, y1 - radius);
		g.endFill();
		
		g.beginFill(color, alpha);
		g.moveTo(x, y1 - radius);
		g.lineTo(x + thickness, y1 - radius);
		g.curveTo(x + thickness, y1 - thickness, x + radius, y1 - thickness);
		g.lineTo(x1 - radius, y1 - thickness);
		g.curveTo(x1 - thickness, y1 - thickness, x1 - thickness, y1 - radius);
		g.lineTo(x1, y1 - radius);
		g.curveTo(x1, y1, x1 - radius, y1);
		g.lineTo(x + radius, y1);
		g.curveTo(x, y1, x, y1 - radius);
		g.endFill();
	}
	
	public static function drawRightBottomBorder(
		g:Graphics,
		x:Float, y:Float, width:Float, height:Float, radius:Float, color:UInt, alpha:Float,
		thickness:Int, inner:Bool):Void
	{
		var x1 = x + width;
		var y1 = y + height;
		
		g.beginFill(color, alpha);
		if (inner)
		{
			g.moveTo(x1 - radius, y);
			g.curveTo(x1, y, x1, y + radius);
		}
		else
		{
			g.moveTo(x1 - radius, y + thickness);
			g.curveTo(x1, y + thickness, x1, y + radius);
		}
		g.lineTo(x1, y1 - radius);
		g.curveTo(x1, y1, x1 - radius, y1);
		g.lineTo(x + radius, y1);
		
		if (inner)
		{
			g.curveTo(x, y1, x, y1 - radius);
			g.curveTo(x, y1 - thickness, x + radius, y1 - thickness);
		}
		else
		{
			g.curveTo(x + thickness, y1, x + thickness, y1 - radius);
			g.curveTo(x + thickness, y1 - thickness, x + radius, y1 - thickness);
		}
		
		g.lineTo(x1 - radius, y1 - thickness);
		g.curveTo(x1 - thickness, y1 - thickness, x1 - thickness, y1 - radius);
		g.lineTo(x1 - thickness, y + radius);
		if (inner)
		{
			g.curveTo(x1 - thickness, y, x1 - radius, y);
		}
		else
		{
			g.curveTo(x1 - thickness, y + thickness, x1 - radius, y + thickness);
		}
		g.endFill();
	}
	
	public static function drawCircleBorder(
		g:Graphics,
		x:Float, y:Float, radius:Float, thickness:Int,
		color:UInt, alpha:Float):Void
	{
		g.beginFill(color, alpha);
		drawSegmentBorder(g, 0, 4, x, y, radius, thickness);
		g.endFill();
		g.beginFill(color, alpha);
		drawSegmentBorder(g, 4, 8, x, y, radius, thickness);
		g.endFill();
	}
	
	public static function drawCircleGradientBorder(
		g:Graphics,
		x:Float, y:Float, radius:Float, thickness:Int,
		colors:Array<UInt>, alphas:Array<Float>, ratios:Array<UInt>, matrix:Matrix):Void
	{
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		drawSegmentBorder(g, 0, 4, x, y, radius, thickness);
		g.endFill();
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		drawSegmentBorder(g, 4, 8, x, y, radius, thickness);
		g.endFill();
	}
	
	public static function drawCircleRectBorder(
		g:Graphics,
		x:Float, y:Float, width:Float, height:Float,
		colors:Array<UInt>, alphas:Array<Float>, ratios:Array<UInt>, matrix:Matrix,
		thickness:Int):Void
	{
		var r = height * .5;
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		drawSegmentBorder(g, 2, 6, x + r, y + r, r, thickness);
		g.endFill();
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		drawSegmentBorder(g, -2, 2, x + width - r, y + r, r, thickness);
		g.endFill();
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		g.drawRect(x + r, y, width - r * 2, thickness);
		g.endFill();
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		g.drawRect(x + r, y + height - thickness, width - r * 2, thickness);
		g.endFill();
	}
	
	static function drawSegmentBorder(
		g:Graphics,
		i0:Int, i1:Int, x:Float, y:Float, radius:Float, thickness:Int):Void
	{
		var step = Math.PI * .125;
		var k = 1 / Math.cos(step);
		var r1 = radius;
		var r1_ = k * r1;
		var r0 = r1 - thickness;
		var r0_ = k * r0;
		
		var i = i0;
		var angle = 2 * i * step;
		g.moveTo(x + r1 * Math.cos(angle), y + r1 * Math.sin(angle));
		while (i < i1)
		{
			var angle0 = (2 * i + 1) * step;
			var angle1 = (2 * i + 2) * step;
			g.curveTo(
				x + r1_ * Math.cos(angle0), y + r1_ * Math.sin(angle0),
				x + r1 * Math.cos(angle1), y + r1 * Math.sin(angle1));
			i++;
		}
		var angle = 2 * i * step;
		g.lineTo(x + r0 * Math.cos(angle), y + r0 * Math.sin(angle));
		while (i > i0)
		{
			var angle0 = (2 * i - 1) * step;
			var angle1 = (2 * i - 2) * step;
			g.curveTo(
				x + r0_ * Math.cos(angle0), y + r0_ * Math.sin(angle0),
				x + r0 * Math.cos(angle1), y + r0 * Math.sin(angle1));
			i--;
		}
		var angle = 2 * i * step;
		g.lineTo(x + r1 * Math.cos(angle), y + r1 * Math.sin(angle));
	}
}