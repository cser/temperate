package ;
import flash.display.Sprite;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.core.CSprite;

class TestValidationBug extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var main = new CVBox().addTo(this);
		var box = new CHBox().addTo(main);
		var sprite = new CSprite();
		box.add(sprite);
	}
}