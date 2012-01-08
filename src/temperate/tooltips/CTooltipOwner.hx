package temperate.tooltips;
import flash.display.DisplayObjectContainer;
import flash.geom.Rectangle;
import temperate.core.ICArea;
import temperate.tooltips.docks.ICTooltipDock;

class CTooltipOwner implements ICArea
{
	public function new(container:DisplayObjectContainer)
	{
		this.container = container;
		
		areaX = 0;
		areaY = 0;
		areaWidth = 100;
		areaHeight = 100;
	}
	
	public var container(default, null):DisplayObjectContainer;
	
	public var areaX(default, null):Int;
	
	public var areaY(default, null):Int;
	
	public var areaWidth(default, null):Int;
	
	public var areaHeight(default, null):Int;
	
	public function setArea(x:Int, y:Int, width:Int, height:Int):Void
	{
		areaX = x;
		areaY = y;
		areaWidth = width;
		areaHeight = height;
	}
	
	static var _rectangle:Rectangle;
	
	public function arrange(
		dock:ICTooltipDock, target:Rectangle, rendererWidth:Int, rendererHeight:Int)
	{
		if (_rectangle == null)
		{
			_rectangle = new Rectangle();
		}
		_rectangle.x = target.x - areaX;
		_rectangle.y = target.y - areaY;
		_rectangle.width = target.width;
		_rectangle.height = target.height;
		dock.arrange(_rectangle, areaWidth, areaHeight, rendererWidth, rendererHeight);
		rendererX = dock.rendererX + areaX;
		rendererY = dock.rendererY + areaY;
	}
	
	public var rendererX(default, null):Int;
	
	public var rendererY(default, null):Int;
}