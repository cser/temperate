package temperate.layouts;
import flash.display.DisplayObject;
import temperate.components.CScrollPolicy;

interface ICScrollLayout 
{
	function arrange(
		showHScrollBar:Void->DisplayObject,
		hideHScrollBar:Void->Void,
		showVScrollBar:Void->DisplayObject,
		hideVScrollBar:Void->Void):Void;
		
	var content:DisplayObject;
	
	var hScrollPolicy:CScrollPolicy;
	
	var vScrollPolicy:CScrollPolicy;
	
	var isCompactWidth:Bool;
	
	var isCompactHeight:Bool;
	
	var width:Float;
	
	var height:Float;
}