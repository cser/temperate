package temperate.tooltips.docks;
import flash.geom.Rectangle;

class CVTooltipDock extends ACLineTooltipDock
{
	public function new()
	{
		super();
		
		isDefaultTop = true;
	}
	
	public var isDefaultTop:Bool;
	
	public function setDefaultTop(value:Bool)
	{
		isDefaultTop = value;
		return this;
	}
	
	override public function arrange(
		target:Rectangle, ownerWidth:Int, ownerHeight:Int, rendererWidth:Int, rendererHeight:Int
	):Void
	{
		var topSpace = target.top - indent;
		var bottomSpace = ownerHeight - target.bottom - indent;
		
		if (isDefaultTop)
		{
			if (topSpace >= rendererHeight)
			{
				rendererY = Std.int(target.y - indent - rendererHeight);
			}
			else if (bottomSpace >= rendererHeight)
			{
				rendererY = Std.int(target.bottom + indent);
			}
			else if (topSpace >= bottomSpace)
			{
				rendererY = 0;
			}
			else
			{
				rendererY = ownerHeight - rendererHeight;
			}
		}
		else
		{
			if (bottomSpace >= rendererHeight)
			{
				rendererY = Std.int(target.bottom + indent);
			}
			else if (topSpace >= rendererHeight)
			{
				rendererY = Std.int(target.top - indent - rendererHeight);
			}
			else if (topSpace > bottomSpace)
			{
				rendererY = 0;
			}
			else
			{
				rendererY = ownerHeight - rendererHeight;
			}
		}
		
		rendererX = Std.int(target.x + (target.width - rendererWidth) * .5);
		if (rendererX < 0)
		{
			rendererX = 0;
		}
		if (rendererX > ownerWidth - rendererWidth)
		{
			rendererX = ownerWidth - rendererWidth;
		}
	}
}