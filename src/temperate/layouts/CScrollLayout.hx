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
		if (hScrollPolicy == CScrollPolicy.ON && vScrollPolicy == CScrollPolicy.ON)
		{
			var hsb = showHScrollBar();
			hsb.width = 0;
			var hsbWidth = hsb.width;
			var hsbHeight = hsb.height;
			var vsb = showVScrollBar();
			vsb.height = 0;
			var vsbWidth = vsb.width;
			var vsbHeight = vsb.height;
			
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
			}
		}
		else if (hScrollPolicy == CScrollPolicy.OFF && vScrollPolicy == CScrollPolicy.OFF)
		{
			if (width < 0)
			{
				width = 0;
			}
			if (height < 0)
			{
				height = 0;
			}
			if (wrapper != null)
			{
				if (!Math.isNaN(wrapper.widthPortion))
				{
					wrapper.setWidth(width);
				}
				if (!Math.isNaN(wrapper.heightPortion))
				{
					wrapper.setHeight(height);
				}
				width = wrapper.getWidth();
				height = wrapper.getHeight();
			}
			hideHScrollBar();
			hideVScrollBar();
		}
		else if (hScrollPolicy == CScrollPolicy.ON && vScrollPolicy == CScrollPolicy.OFF)
		{
			var hsb = showHScrollBar();
			hsb.width = 0;
			var hsbWidth = hsb.width;
			var hsbHeight = hsb.height;
			hideVScrollBar();
			
			if (width < hsbWidth)
			{
				width = hsbWidth;
			}
			if (height < hsbHeight)
			{
				height = hsbHeight;
			}
			
			if (wrapper != null)
			{
				if (!Math.isNaN(wrapper.widthPortion))
				{
					wrapper.setWidth(width);
				}
				if (!Math.isNaN(wrapper.heightPortion))
				{
					wrapper.setHeight(height - hsbHeight);
				}
				height = wrapper.getHeight() + hsbHeight;
			}
		}
		else if (hScrollPolicy == CScrollPolicy.OFF && vScrollPolicy == CScrollPolicy.ON)
		{
			var vsb = showVScrollBar();
			vsb.height = 0;
			var vsbWidth = vsb.width;
			var vsbHeight = vsb.height;
			hideHScrollBar();
			
			if (width < vsbWidth)
			{
				width = vsbWidth;
			}
			if (height < vsbHeight)
			{
				height = vsbHeight;
			}
			
			if (wrapper != null)
			{
				if (!Math.isNaN(wrapper.widthPortion))
				{
					wrapper.setWidth(width - vsbWidth);
				}
				if (!Math.isNaN(wrapper.heightPortion))
				{
					wrapper.setHeight(height);
				}
				width = wrapper.getWidth() + vsbWidth;
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