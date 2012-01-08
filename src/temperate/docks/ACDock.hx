package temperate.docks;

class ACDock implements ICDock
{
	function new() 
	{
		noTargetMode = false;
	}
	
	public var noTargetMode:Bool;
	
	public function arrange(
		width:Int, height:Int, mainWidth:Int, mainHeight:Int, targetWidth:Int, targetHeight:Int
	):Void
	{
	}
	
	public var mainX(default, null):Int;
	
	public var mainY(default, null):Int;
	
	public var targetX(default, null):Int;
	
	public var targetY(default, null):Int;
	
	public var width(default, null):Int;
	
	public var height(default, null):Int;
}