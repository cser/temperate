package temperate.minimal;
import flash.display.Sprite;

class MWindowedContainer< T:Sprite > extends MWindow
{
	public function new(container:T, title:String = null)
	{
		this.container = container;
		super();
		if (title != null)
		{
			this.title = title;
		}
	}
	
	public var container(default, null):T;
	
	override function newContainer():Sprite
	{
		return container;
	}
}