package temperate.layouts;
import flash.display.DisplayObject;
import flash.text.TextField;
import temperate.components.CScrollPolicy;

interface IScrollTextLayout
{
	function arrange(
		showHScrollBar:Void->DisplayObject,
		hideHScrollBar:Void->Void,
		showVScrollBar:Void->DisplayObject,
		hideVScrollBar:Void->Void,
		textDeltaX:Int,
		textDeltaY:Int,
		isFirst:Bool):Void;
		
	var tf:TextField;
	
	var hScrollPolicy:CScrollPolicy;
	
	var vScrollPolicy:CScrollPolicy;
	
	var isCompactWidth:Bool;
	
	var isCompactHeight:Bool;
	
	var minWidth:Int;
	
	var minHeight:Int;
	
	var width:Float;
	
	var height:Float;
}