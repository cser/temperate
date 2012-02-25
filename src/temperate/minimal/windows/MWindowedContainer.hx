package temperate.minimal.windows;
import flash.display.Sprite;
import flash.events.Event;

class MWindowedContainer< TData > extends AMWindow<TData>
{
	public function new(container:Sprite, title:String = null)
	{
		_container = container;
		super();
		if (title != null)
		{
			this.title = title;
		}
	}
	
	var _container:Sprite;
	
	override function newContainer():Sprite
	{
		return _container;
	}
}