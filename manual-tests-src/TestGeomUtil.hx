package ;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import temperate.core.CGeomUtil;
import temperate.minimal.MButton;
import temperate.minimal.renderers.MTextTooltip;

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
			
		drawMTooltipRenderers();
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
	
	function drawMTooltipRenderers()
	{
		drawMTooltipRenderersByCoords(
			200, 410,
			[
				new Point( -100, -100),	new Point(0, -100),	new Point(100, -100),
				new Point( -100, 0),	new Point(0, 0),	new Point(100, 0),	
				new Point( -100, 100),	new Point(0, 100), new Point(100, 100)
			]
		);
	}
	
	function drawMTooltipRenderersByCoords(centerX:Int, centerY:Int, coords:Array<Point>)
	{
		var sprite:Sprite = new Sprite();
		sprite.x = centerX;
		sprite.y = centerY;
		addChild(sprite);
		
		var button = new MButton().addTo(sprite, -25, -25);
		button.width = 50;
		button.height = 50;
		
		for (point in coords)
		{
			var renderer = new MTextTooltip();
			renderer.fillColor = 0x80ffffff;
			renderer.borderColor = 0xff508000;
			renderer.initData("Some text");
			renderer.x = point.x - renderer.width * .5;
			renderer.y = point.y * .5 - renderer.height * .5;
			renderer.setTailTarget(new Rectangle(
				button.x - renderer.x,
				button.y - renderer.y,
				button.width,
				button.height
			));
			sprite.addChild(renderer);
		}
	}
}