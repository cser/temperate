package temperate.windows.docks;

interface ICWindowDock
{
	function arrange(width:Int, height:Int, mainWidth:Int, mainHeight:Int):Void;
	
	function move(
		width:Int, height:Int, mainWidth:Int, mainHeight:Int, x:Int, y:Int, needSave:Bool):Void;
	
	var x(default, null):Int;
	
	var y(default, null):Int;
}