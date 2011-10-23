package temperate.layouts;
import flash.display.DisplayObject;
import temperate.components.CScrollPolicy;
import temperate.layouts.parametrization.CChildWrapper;

interface ICScrollLayout 
{
	var showHScrollBar:Void->DisplayObject;
	var hideHScrollBar:Void->Void;
	var showVScrollBar:Void->DisplayObject;
	var hideVScrollBar:Void->Void;
	
	function arrange():Void;
		
	var wrapper:CChildWrapper;
	
	var hScrollPolicy:CScrollPolicy;
	
	var vScrollPolicy:CScrollPolicy;
	
	var isCompactWidth:Bool;
	
	var isCompactHeight:Bool;
	
	var width:Float;
	
	var height:Float;
}