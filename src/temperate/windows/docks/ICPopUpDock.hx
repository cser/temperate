package temperate.windows.docks;

interface ICPopUpDock
{
	function arrange(width:Int, height:Int, mainWidth:Int, mainHeight:Int):Void;
	
	var x(default, null):Int;
	
	var y(default, null):Int;
}