package ;
import flash.display.Sprite;
import flash.events.MouseEvent;
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
		var g = sprite.graphics;
		g.beginFill(0x808080);
		g.drawRect(0, 0, 200, 200);
		g.endFill();
		
		var sprite = new Sprite();
		sprite.x = 100;
		sprite.y = 100;
		sprite.mouseEnabled = false;
		addChild(sprite);
		var g = sprite.graphics;
		g.beginFill(0xff0000, .5);
		g.drawRect(0, 0, 200, 200);
		g.endFill();
	}
	
	private function onClick(event:MouseEvent):Void
	{
		var sprite:Sprite = cast event.target;
		sprite.alpha = .5;
		MTween.to(sprite, 500, { alpha: 1 } );
	}
}