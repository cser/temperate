package temperate.tooltips.renderers;
import flash.display.DisplayObject;
import flash.geom.Rectangle;
import temperate.core.CSprite;

class ACTooltip< T > extends CSprite, implements ICTooltip<T>
{
	public function new() 
	{
		super();
		
		mouseEnabled = false;
		mouseChildren = false;
		view = this;
	}
	
	public var view(default, null):DisplayObject;
	
	public function initData(data:T):Void
	{
	}
	
	public function subscribe():Void
	{
	}
	
	public function unsubscribe():Void
	{
	}
	
	public function setTailTarget(target:Rectangle):Void
	{
		
	}

	/**
	 * Called by tooltip system. May be used for pool organization
	 */
	public function dispose()
	{
	}
	
	public dynamic function onResize(width:Int, height:Int)
	{
	}
}