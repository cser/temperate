package temperate.layouts;
import temperate.layouts.parametrization.ChildWrapper;

interface ILayout 
{
	function arrange(offsetX:Int, offsetY:Int):Void;
	
	function removeAll():Void;
	
	function iterator():Iterator<ChildWrapper>;
	
	var width:Float;
	
	var height:Float;
	
	var gapX:Float;
	
	var gapY:Float;
	
	var isCompactWidth:Bool;
	
	var isCompactHeight:Bool;
}