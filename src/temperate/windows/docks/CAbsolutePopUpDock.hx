package temperate.windows.docks;

class CAbsolutePopUpDock extends ACPopUpDock
{
	public function new(x:Int = 0, y:Int = 0)
	{
		super();
		this.x = x;
		this.y = y;
	}
	
	override public function move(
		width:Int, height:Int, mainWidth:Int, mainHeight:Int, x:Int, y:Int
	):Void
	{
		this.x = x;
		this.y = y;
	}
}