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
	
	public static function drawBottomRightBorder(
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
	
	public static function drawTopLeftBorder(
		g:Graphics,
		x:Float, y:Float, width:Float, height:Float, radius:Float, color:UInt, alpha:Float,
		thickness:Int, inner:Bool):Void
	{
		var x1 = x + width;
		var y1 = y + height;
		
		g.beginFill(color, alpha);
		g.moveTo(x + radius, y);
		g.lineTo(x1 - radius, y);
		if (inner)
		{
			g.curveTo(x1, y, x1, y + radius);
			g.curveTo(x1, y + thickness, x1 - radius, y + thickness);
		}
		else
		{
			g.curveTo(x1 - thickness, y, x1 - thickness, y + radius);
			g.curveTo(x1 - thickness, y + thickness, x1 - radius, y + thickness);
		}
		g.lineTo(x + radius, y + thickness);
		g.curveTo(x + thickness, y + thickness, x + thickness, y + radius);
		g.lineTo(x + thickness, y1 - radius);
		if (inner)
		{
			g.curveTo(x + thickness, y1, x + radius, y1);
			g.curveTo(x, y1, x, y1 - radius);
		}
		else
		{
			g.curveTo(x + thickness, y1 - thickness, x + radius, y1 - thickness);
			g.curveTo(x, y1 - thickness, x, y1 - radius);
		}
		g.lineTo(x, y + radius);
		g.curveTo(x, y, x + radius, y);
		g.endFill();
	}
	
	public static function drawCircleBorder(
		g:Graphics,
		x:Float, y:Float, radius:Float, thickness:Int,
		color:UInt, alpha:Float):Void
	{
		g.beginFill(color, alpha);
		draw1per8SegmentBorder(g, 0, 4, x, y, radius, thickness);
		g.endFill();
		g.beginFill(color, alpha);
		draw1per8SegmentBorder(g, 4, 8, x, y, radius, thickness);
		g.endFill();
	}
	
	public static function drawCircleGradientBorder(
		g:Graphics,
		x:Float, y:Float, radius:Float, thickness:Int,
		colors:Array<UInt>, alphas:Array<Float>, ratios:Array<UInt>, matrix:Matrix):Void
	{
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		draw1per8SegmentBorder(g, 0, 4, x, y, radius, thickness);
		g.endFill();
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		draw1per8SegmentBorder(g, 4, 8, x, y, radius, thickness);
		g.endFill();
	}
	
	public static function draw1per8SegmentBorder(
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
	
	public static function drawArc(
		g:Graphics,
		x:Float, y:Float, radius:Float, angle0:Float, angle1:Float):Void
	{
		var numSegments = Math.ceil((angle1 - angle0) * 4 / Math.PI);
		if (numSegments < 0)
		{
			numSegments = -numSegments;
		}
		var deltaAngle = (angle1 - angle0) / numSegments;
		var externalRadius = radius / Math.cos(deltaAngle * .5);
		for (i in 0 ... numSegments)
		{
			var angle = angle0 + (i + 1) * deltaAngle;
			var halfAngle = angle0 + (i + .5) * deltaAngle;
			var x1 = x + Math.cos(halfAngle) * externalRadius;
			var y1 = y + Math.sin(halfAngle) * externalRadius;
			var x2 = x + Math.cos(angle) * radius;
			var y2 = y + Math.sin(angle) * radius;
			g.curveTo(x1, y1, x2, y2);
		}
	}
	
	public static function drawRoundRectComplexStepByStep(
		g:Graphics,
		x:Float, y:Float, width:Float, height:Float,
		topLeftRadius:Float, topRightRadius:Float,
		bottomLeftRadius:Float, bottomRightRadius:Float):Void
	{
		var x1 = x + width;
		var y1 = y + height;
		var r = topLeftRadius;
		if (r > 0)
		{
			g.moveTo(x + r, y);
		}
		else
		{
			g.moveTo(x, y);
		}
		var r = topRightRadius;
		if (r > 0)
		{
			g.lineTo(x1 - r, y);
			g.curveTo(x1, y, x1, y + r);
		}
		else
		{
			g.lineTo(x1, y);
		}
		var r = bottomRightRadius;
		if (r > 0)
		{
			g.lineTo(x1, y1 - r);
			g.curveTo(x1, y1, x1 - r, y1);
		}
		else
		{
			g.lineTo(x1, y1);
		}
		var r = bottomLeftRadius;
		if (r > 0)
		{
			g.lineTo(x + r, y1);
			g.curveTo(x, y1, x, y1 - r);
		}
		else
		{
			g.lineTo(x, y1);
		}
		var r = topLeftRadius;
		if (r > 0)
		{
			g.lineTo(x, y + r);
			g.curveTo(x, y, x + r, y);
		}
		else
		{
			g.lineTo(x, y);
		}
	}
}