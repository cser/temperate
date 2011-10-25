package temperate.tooltips.docks;
import flash.geom.Rectangle;

class CHTooltipDock extends ACLineTooltipDock
{
	public function new() 
	{
		super();
		
		isDefaultLeft = true;
	}
	
	public var isDefaultLeft:Bool;
	
	public function setDefaultLeft(value:Bool)
	{
		isDefaultLeft = value;
		return this;
	}
	
	override public function arrange(
		target:Rectangle, ownerWidth:Int, ownerHeight:Int, rendererWidth:Int, rendererHeight:Int
	)
	{
		var leftSpace = target.left - indent;
		var rightSpace = ownerWidth - target.right - indent;
		
		if (isDefaultLeft)
		{
			if (leftSpace >= rendererWidth)
			{
				rendererX = Std.int(target.x - indent - rendererWidth);
			}
			else if (rightSpace >= rendererWidth)
			{
				rendererX = Std.int(target.right + indent);
			}
			else if (leftSpace >= rightSpace)
			{
				rendererX = 0;
			}
			else
			{
				rendererX = ownerWidth - rendererWidth;
			}
		}
		else
		{
			if (rightSpace >= rendererWidth)
			{
				rendererX = Std.int(target.right + indent);
			}
			else if (leftSpace >= rendererWidth)
			{
				rendererX = Std.int(target.left - indent - rendererWidth);
			}
			else if (leftSpace > rightSpace)
			{
				rendererX = 0;
			}
			else
			{
				rendererX = ownerWidth - rendererWidth;
			}
		}
		
		rendererY = Std.int(target.y + (target.height - rendererHeight) * .5);
		if (rendererY < 0)
		{
			rendererY = 0;
		}
		if (rendererY > ownerHeight - rendererHeight)
		{
			rendererY = ownerHeight - rendererHeight;
		}
	}
}