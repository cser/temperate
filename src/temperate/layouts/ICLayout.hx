package temperate.layouts;
import temperate.layouts.parametrization.CChildWrapper;

interface ICLayout 
{
	function arrange(offsetX:Int, offsetY:Int):Void;
	
	function removeAll():Void;
	
	function iterator():Iterator<CChildWrapper>;
	
	var width:Float;
	
	var height:Float;
	
	var gapX:Float;
	
	var gapY:Float;
	
	var isCompactWidth:Bool;
	
	var isCompactHeight:Bool;
}