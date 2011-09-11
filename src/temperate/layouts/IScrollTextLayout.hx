package temperate.layouts;
import flash.display.DisplayObject;
import flash.text.TextField;
import temperate.components.CScrollPolicy;

interface IScrollTextLayout
{
	function arrange(
		tf:TextField,
		showHScrollBar:Void->DisplayObject,
		hideHScrollBar:Void->Void,
		showVScrollBar:Void->DisplayObject,
		hideVScrollBar:Void->Void):Void;
	
	var hScrollPolicy:CScrollPolicy;
	
	var vScrollPolicy:CScrollPolicy;
	
	var minTextWidth:Int;
	
	var isCompactWidth:Bool;
	
	var isCompactHeight:Bool;
	
	var minWidth:Int;
	
	var minHeight:Int;
	
	var width:Float;
	
	var height:Float;
}