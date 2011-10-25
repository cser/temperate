package temperate.docks;
import temperate.core.CMath;

class CRightDock extends ACDock
{
	public function new(space:Int, alignY:Float)
	{
		super();
		_space = space;
		_alignY = alignY;
	}
	
	var _space:Int;
	var _alignY:Float;
	
	override public function arrange(
		width:Int, height:Int, mainWidth:Int, mainHeight:Int, targetWidth:Int, targetHeight:Int
	):Void
	{
		if (noTargetMode)
		{
			this.width = CMath.intMax(mainWidth, width);
			this.height = CMath.intMax(mainHeight, height);
			mainY = Std.int((this.height - mainHeight) * _alignY);
			targetX = 0;
			targetY = 0;
		}
		else
		{
			this.width = CMath.intMax(mainWidth + _space + targetWidth, width);
			this.height = CMath.intMax(CMath.intMax(mainHeight, targetHeight), height);
			mainY = Std.int((this.height - mainHeight) * _alignY);
			targetX = mainWidth + _space;
			targetY = Std.int((this.height - targetHeight) * _alignY);				
		}
	}
}