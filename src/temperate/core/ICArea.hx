package temperate.core;
import flash.display.DisplayObjectContainer;

interface ICArea 
{
	var container(default, null):DisplayObjectContainer;
	
	var areaX(default, null):Int;
	
	var areaY(default, null):Int;
	
	var areaWidth(default, null):Int;
	
	var areaHeight(default, null):Int;
	
	function setArea(x:Int, y:Int, width:Int, height:Int):Void;
}