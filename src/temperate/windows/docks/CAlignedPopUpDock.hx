package temperate.windows.docks;

class CAlignedPopUpDock extends ACPopUpDock
{
	public function new(alignX:Float = .5, alignY:Float = .5)
	{
		super();
		this.alignX = alignX;
		this.alignY = alignY;
	}
	
	public var alignX:Float;
	public var alignY:Float;
	
	override public function arrange(width:Int, height:Int, mainWidth:Int, mainHeight:Int):Void
	{
		x = Std.int((mainWidth - width) * alignX);
		y = Std.int((mainHeight - height) * alignY);
	}
}