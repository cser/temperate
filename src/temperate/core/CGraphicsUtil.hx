package temperate.core;
import flash.display.Graphics;

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
}