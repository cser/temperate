package ;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import temperate.core.CGeomUtil;

class TestGeomUtil extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		testPoligons(
			[0, 0, 100, 0, 100, 100, 0, 100], [50, 50, 150, 50, 150, 80, 50, 80],
			10, 10);
		
		testPoligons(
			[-50, 0, 50, 0, 0, 100], [50, 20, -50, 20, 0, -80],
			300, 100);
			
		testPoligons(
			[-10, 50, 150, 50, 150, 150, -10, 150], [0, 0, 100, 0, 100, 100, 0, 100],
			500, 10);
	}
	
	function testPoligons(coords0:Array<Dynamic>, coords1:Array<Dynamic>, offsetX:Int, offsetY:Int)
	{
		var shape = new Shape();
		shape.x = offsetX;
		shape.y = offsetY;
		addChild(shape);
		
		var result = CGeomUtil.getUnionPoligon(cast coords0, cast coords1);
		
		var g = shape.graphics;
		g.lineStyle(1, 0xff0000);
		drawPoligon(g, cast coords0);
		g.lineStyle(1, 0xff0000);
		drawPoligon(g, cast coords1);
		g.lineStyle(3, 0xff0000);
		drawPoligon(g, cast result);
	}
	
	private function drawPoligon(g:Graphics, coords:Array<Float>):Void
	{
		var i = 0;
		var x0 = coords[i];
		var y0 = coords[i + 1];
		g.moveTo(x0, y0);
		g.drawCircle(x0, y0, 2);
		i += 2;
		while (i < coords.length)
		{
			var x = coords[i];
			var y = coords[i + 1];
			g.lineTo(x, y);
			i += 2;
		}
		g.lineTo(x0, y0);
	}
}