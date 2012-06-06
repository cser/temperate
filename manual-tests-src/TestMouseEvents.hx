package ;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.display.Shape;
import temperate.core.CMath;
import temperate.minimal.MTween;

class TestMouseEvents extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init():Void
	{
		var sprite = new Sprite();
		sprite.addEventListener(MouseEvent.CLICK, onClick);
		addChild(sprite);
		drawRect(sprite.graphics, 0xff808080, 0, 0, 200, 200);
		
		var sprite = new Sprite();
		sprite.mouseEnabled = false;
		addChild(sprite);
		drawRect(sprite.graphics, 0x80ff0000, 100, 100, 200, 200);
		
		var shape = new Shape();
		var sprite = new Sprite();
		sprite.mouseEnabled = false;
		sprite.mouseChildren = false;
		addChild(sprite);
		sprite.addChild(shape);
		drawRect(shape.graphics, 0x800000ff, 100, 0, 100, 100);
	}
	
	private function drawRect(g, color:Int, x:Float, y:Float, width:Float, height:Float):Void
	{
		g.beginFill(CMath.getColor(color), CMath.getAlpha(color));
		g.drawRect(x, y, width, height);
		g.endFill();
	}
	
	private function onClick(event:MouseEvent):Void
	{
		var sprite:Sprite = cast event.target;
		sprite.alpha = .5;
		MTween.to(sprite, 500, { alpha: 1 } );
	}
}