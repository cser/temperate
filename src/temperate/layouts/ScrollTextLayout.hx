package temperate.layouts;
import flash.display.DisplayObject;
import flash.text.TextField;
import temperate.components.CScrollPolicy;

class ScrollTextLayout implements IScrollTextLayout
{
	public function new()
	{
		minTextWidth = 10;
	}
	
	public function arrange(
		tf:TextField,
		showHScrollBar:Void->DisplayObject,
		hideHScrollBar:Void->Void,
		showVScrollBar:Void->DisplayObject,
		hideVScrollBar:Void->Void):Void
	{
		tf.width = width;
		tf.height = height;
		
		var vScrollBar = tryScrollV(tf, showVScrollBar, hideVScrollBar);
		var hasV = vScrollBar != null;
		if (hasV)
		{
			tf.width = width - vScrollBar.width;
		}
		
		var hScrollBar = tryScrollH(tf, showHScrollBar, hideHScrollBar);
		var hasH = hScrollBar != null;
		if (hasH && !hasV)
		{
			// Second try
			vScrollBar = tryScrollV(tf, showVScrollBar, hideVScrollBar);
			hasV = vScrollBar != null;
		}
		if (hasH)
		{
			tf.height = height - hScrollBar.height;
			hScrollBar.width = hasV ? width - vScrollBar.width : width;
		}
		
		if (hasV)
		{
			vScrollBar.height = hasH ? height - hScrollBar.height : height;
		}
	}
	
	function tryScrollH(
		tf:TextField, showHScrollBar:Void->DisplayObject, hideHScrollBar:Void->Void)
	{
		switch (hScrollPolicy)
		{
			case CScrollPolicy.ON:
				return showHScrollBar();
			case CScrollPolicy.OFF:
				hideHScrollBar();
				return null;
			case CScrollPolicy.AUTO:
				var min = 1;
				var max = tf.maxScrollH;
				if (max > min)
				{
					return showHScrollBar();
				}
				else
				{
					hideHScrollBar();
					return null;
				}
		}
	}
	
	function tryScrollV(
		tf:TextField, showVScrollBar:Void->DisplayObject, hideVScrollBar:Void->Void)
	{
		switch (vScrollPolicy)
		{
			case CScrollPolicy.ON:
				return showVScrollBar();
			case CScrollPolicy.OFF:
				hideVScrollBar();
				return null;
			case CScrollPolicy.AUTO:
				var min = 1;
				var max = tf.maxScrollV;
				trace(min + ", " + max);
				if (max > min)
				{
					return showVScrollBar();
				}
				else
				{
					hideVScrollBar();
					return null;
				}
		}
	}
	
	public var hScrollPolicy:CScrollPolicy;
	
	public var vScrollPolicy:CScrollPolicy;
		
	public var minTextWidth:Int;
	
	public var isCompactWidth:Bool;
	
	public var isCompactHeight:Bool;
	
	public var width:Float;
	
	public var height:Float;
}