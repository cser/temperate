package temperate.layouts;
import flash.display.DisplayObject;
import temperate.components.CScrollPolicy;
import temperate.layouts.parametrization.CChildWrapper;

/**
 * Rules:
 * If on/auto ScrollBar - size is constraints by minimal ScrollBars sizes
 * If no ScrollBar - size is constraints by content size
 * If no wrapper - size has no constraints else minimal ScrollBar sizes
 */
class CScrollLayout implements ICScrollLayout
{
	public function new() 
	{
		
	}
	
	public var showHScrollBar:Void->DisplayObject;
	public var hideHScrollBar:Void->Void;
	public var showVScrollBar:Void->DisplayObject;
	public var hideVScrollBar:Void->Void;
	
	public function arrange()
	{
		width = isCompactWidth ? 0 : width;
		height = isCompactHeight ? 0 : height;
		if (hScrollPolicy != CScrollPolicy.AUTO && vScrollPolicy != CScrollPolicy.AUTO)
		{
			var hOn = hScrollPolicy == CScrollPolicy.ON;
			var hsb = null;
			var hsbWidth = 0.;
			var hsbHeight = 0.;
			if (hOn)
			{
				hsb = showHScrollBar();
				hsb.width = 0;
				hsbWidth = hsb.width;
				hsbHeight = hsb.height;
			}
			else
			{
				hideHScrollBar();
			}
			var vOn = vScrollPolicy == CScrollPolicy.ON;
			var vsb = null;
			var vsbWidth = 0.;
			var vsbHeight = 0.;
			if (vOn)
			{
				var vsb = showVScrollBar();
				vsb.height = 0;
				vsbWidth = vsb.width;
				vsbHeight = vsb.height;
			}
			else
			{
				hideVScrollBar();
			}
			
			if (width < hsbWidth + vsbWidth)
			{
				width = hsbWidth + vsbWidth;
			}
			if (height < hsbHeight + vsbHeight)
			{
				height = hsbHeight + vsbHeight;
			}
			
			if (wrapper != null)
			{
				if (!Math.isNaN(wrapper.widthPortion))
				{
					wrapper.setWidth(width - vsbWidth);
				}
				if (!Math.isNaN(wrapper.heightPortion))
				{
					wrapper.setHeight(height - hsbHeight);
				}
				if (!hOn)
				{
					width = wrapper.getWidth() + vsbWidth;
				}
				if (!vOn)
				{
					height = wrapper.getHeight() + hsbHeight;
				}
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