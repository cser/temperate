package temperate.tooltips.docks;
import flash.geom.Rectangle;

class ACLineTooltipDock implements ICTooltipDock
{
	public function new() 
	{
		indent = 4;
	}
	
	public var indent:Float;
	
	public function setIndent(value:Int)
	{
		this.indent = value;
		return this;
	}
	
	public function arrange(
		target:Rectangle,
		ownerWidth:Int, ownerHeight:Int, rendererWidth:Int, rendererHeight:Int
	):Void
	{
	}
	
	public var rendererX(default, null):Int;
	
	public var rendererY(default, null):Int;
}