package temperate.layouts;
import flash.display.DisplayObject;
import flash.text.TextField;
import temperate.components.CScrollPolicy;

class CScrollTextLayout implements ICScrollTextLayout
{
	public function new()
	{
		minWidth = 50;
		minHeight = 50;
	}
	
	public var tf:TextField;
	
	public function arrange(
		showHScrollBar:Void->DisplayObject,
		hideHScrollBar:Void->Void,
		showVScrollBar:Void->DisplayObject,
		hideVScrollBar:Void->Void,
		textDeltaX:Int,
		textDeltaY:Int,
		isFirst:Bool):Void
	{
		if (width < minWidth || isCompactWidth)
		{
			width = minWidth;
		}
		if (height < minHeight || isCompactHeight)
		{
			height = minHeight;
		}
		var fictiveWidth = Std.int(width) - textDeltaX;
		var fictiveHeight = Std.int(height) - textDeltaY;
		if (isFirst)
		{
			tf.width = fictiveWidth;
			tf.height = fictiveHeight;
		}
		if (tf.wordWrap)
		{
			var sb = tryScrollV(showVScrollBar, hideVScrollBar);
			if (sb != null)
			{
				setTextSize(Std.int(fictiveWidth - sb.width), fictiveHeight);
				sb.height = height;
			}
			else
			{
				setTextSize(fictiveWidth, fictiveHeight);
			}
		}
		else
		{
			var vScrollBar = tryScrollV(showVScrollBar, hideVScrollBar);
			var hScrollBar = tryScrollH(showHScrollBar, hideHScrollBar);
			setTextSize(
				fictiveWidth - (vScrollBar != null ? Std.int(vScrollBar.width) : 0),
				fictiveHeight - (hScrollBar != null ? Std.int(hScrollBar.height) : 0)
			);
			
			// catch the edge case of the horizontal scroll bar necessitating a vertical one:
			if (hScrollBar != null && vScrollBar == null)
			{
				vScrollBar = tryScrollV(showVScrollBar, hideVScrollBar);
				if (vScrollBar != null)
				{
					setTextSize(
						fictiveWidth - (vScrollBar != null ? Std.int(vScrollBar.width) : 0),
						fictiveHeight - (hScrollBar != null ? Std.int(hScrollBar.height) : 0)
					);
				}
			}
			
			var hasH = hScrollBar != null;
			var hasV = vScrollBar != null;
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
	
	function tryScrollH(showHScrollBar:Void->DisplayObject, hideHScrollBar:Void->Void)
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
	
	function tryScrollV(showVScrollBar:Void->DisplayObject, hideVScrollBar:Void->Void)
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
	
	function setTextSize(width:Int, height:Int)
	{
		if (width != tf.width)
		{
			tf.width = width;
		}
		if (height != tf.height)
		{
			tf.height = height;
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