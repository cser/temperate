package temperate.docks;

interface ICDock
{
	var noTargetMode:Bool;
	
	function arrange(
		width:Int, height:Int, mainWidth:Int, mainHeight:Int, targetWidth:Int, targetHeight:Int
	):Void;
	
	var mainX(default, null):Int;
	
	var mainY(default, null):Int;
	
	var targetX(default, null):Int;
	
	var targetY(default, null):Int;
	
	var width(default, null):Int;
	
	var height(default, null):Int;
}