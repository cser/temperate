package temperate.layouts;
import flash.display.DisplayObject;
import temperate.components.CScrollPolicy;

class CScrollLayout implements ICScrollLayout
{
	public function new() 
	{
		
	}
	
	public function arrange(
		showHScrollBar:Void->DisplayObject,
		hideHScrollBar:Void->Void,
		showVScrollBar:Void->DisplayObject,
		hideVScrollBar:Void->Void):Void
	{
		
	}
		
	public var content:DisplayObject;
	
	public var hScrollPolicy:CScrollPolicy;
	
	public var vScrollPolicy:CScrollPolicy;
	
	public var isCompactWidth:Bool;
	
	public var isCompactHeight:Bool;
	
	public var width:Float;
	
	public var height:Float;
}