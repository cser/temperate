package temperate.tooltips;
import flash.display.DisplayObjectContainer;
import flash.geom.Rectangle;
import temperate.tooltips.docks.ICTooltipDock;

class CTooltipOwner 
{
	public function new(container:DisplayObjectContainer)
	{
		this.container = container;
		
		left = 0;
		top = 0;
		right = 100;
		bottom = 100;
	}
	
	public var container(default, null):DisplayObjectContainer;
	
	public var left:Int;
	public var top:Int;
	public var right:Int;
	public var bottom:Int;
	
	static var _rectangle:Rectangle;
	
	public function arrange(
		dock:ICTooltipDock, target:Rectangle, rendererWidth:Int, rendererHeight:Int)
	{
		if (_rectangle == null)
		{
			_rectangle = new Rectangle();
		}
		_rectangle.x = target.x - left;
		_rectangle.y = target.y - top;
		_rectangle.width = target.width;
		_rectangle.height = target.height;
		dock.arrange(_rectangle, right - left, bottom - top, rendererWidth, rendererHeight);
		rendererX = dock.rendererX + left;
		rendererY = dock.rendererY + top;
	}
	
	public var rendererX(default, null):Int;
	
	public var rendererY(default, null):Int;
}