package temperate.layouts;
import flash.display.DisplayObject;
import temperate.components.CScrollPolicy;
import temperate.layouts.parametrization.CChildWrapper;

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
		width = isCompactWidth ? 0 : width;
		height = isCompactHeight ? 0 : height;
		if (wrapper != null)
		{
			if (vScrollPolicy == CScrollPolicy.ON && hScrollPolicy == CScrollPolicy.ON)
			{
				var hsb = showHScrollBar();
				var vsb = showVScrollBar();
				
				wrapper.setWidth(width - vsb.width);
				wrapper.setHeight(height - hsb.height);
			}
		}
		else
		{
			hideHScrollBar();
			hideVScrollBar();
		}
	}
		
	public var wrapper:CChildWrapper;
	
	public var hScrollPolicy:CScrollPolicy;
	
	public var vScrollPolicy:CScrollPolicy;
	
	public var isCompactWidth:Bool;
	
	public var isCompactHeight:Bool;
	
	public var width:Float;
	
	public var height:Float;
}