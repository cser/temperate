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
			var hsb = null;
			var vsb = null;
			if (wrapper.getWidth() > width)
			{
				hsb = showHScrollBar();
			}
			else
			{
				hideHScrollBar();
			}
			if (wrapper.getHeight() > height)
			{
				vsb = showVScrollBar();
			}
			else
			{
				hideVScrollBar();
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