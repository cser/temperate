package temperate.layouts;
import flash.display.DisplayObject;
import flash.text.TextField;
import temperate.components.CScrollPolicy;

class ScrollTextLayout implements IScrollTextLayout
{
	public function new()
	{
		minWidth = 50;
		minHeight = 50;
	}
	
	public function arrange(
		tf:TextField,
		showHScrollBar:Void->DisplayObject,
		hideHScrollBar:Void->Void,
		showVScrollBar:Void->DisplayObject,
		hideVScrollBar:Void->Void,
		textDeltaX:Int,
		textDeltaY:Int):Void
	{
		if (width < minWidth || isCompactWidth)
		{
			width = minWidth;
		}
		if (height < minHeight || isCompactHeight)
		{
			height = minHeight;
		}
		tf.width =  width - textDeltaX;
		tf.height = height - textDeltaY;
		if (tf.wordWrap)
		{
			var sb = tryScrollV(tf, showVScrollBar, hideVScrollBar);
			if (sb != null)
			{
				tf.width = width - sb.width - textDeltaX;
				tf.maxScrollH;
				tf.maxScrollV;
				sb.height = height;
			}
		}
		else
		{
			var hScrollBar = tryScrollH(tf, showHScrollBar, hideHScrollBar);
			var hasH = hScrollBar != null;
			if (hasH)
			{
				tf.height = height - hScrollBar.height - textDeltaY;
				tf.maxScrollH;
				tf.maxScrollV;
			}
			var vScrollBar = tryScrollV(tf, showVScrollBar, hideVScrollBar);
			var hasV = vScrollBar != null;
			if (hasV)
			{
				tf.width = width - vScrollBar.width - textDeltaX;
				tf.maxScrollH;
				tf.maxScrollV;
			}
			if (hasH)
			{
				hScrollBar.width = hasV ? width - vScrollBar.width : width;
			}
			if (hasV)
			{
				vScrollBar.height = hasH ? height - hScrollBar.height : height;
			}
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
				tf.maxScrollV;// flashplayer bug spigot
				var max = tf.maxScrollH;
				if (max > 0)
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
				tf.maxScrollH;// flashplayer bug spigot
				var max = tf.maxScrollV;
				if (max > 1)
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
	
	public var minWidth:Int;
	
	public var minHeight:Int;
	
	public var isCompactWidth:Bool;
	
	public var isCompactHeight:Bool;
	
	public var width:Float;
	
	public var height:Float;
}