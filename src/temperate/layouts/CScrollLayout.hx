package temperate.layouts;
import flash.display.DisplayObject;
import temperate.components.CScrollPolicy;
import temperate.core.CMath;
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
	
	public function arrange(hIndent:Int, vIndent:Int)
	{
		width = isCompactWidth ? 0 : CMath.max(0, width - hIndent);
		height = isCompactHeight ? 0 : CMath.max(0, height - vIndent);
		
		var isHOn = hScrollPolicy == CScrollPolicy.ON;
		var isHAuto = hScrollPolicy == CScrollPolicy.AUTO;
		var hsb = null;
		var hsbWidth = 0.;
		var hsbHeight = 0.;
		if (isHOn || isHAuto)
		{
			hsb = showHScrollBar();
			hsb.width = 0;
			hsbWidth = CMath.max(0, hsb.width - hIndent);
			hsbHeight = hsb.height;
		}
		else
		{
			hideHScrollBar();
		}
		var isVOn = vScrollPolicy == CScrollPolicy.ON;
		var isVAuto = vScrollPolicy == CScrollPolicy.AUTO;
		var vsb = null;
		var vsbWidth = 0.;
		var vsbHeight = 0.;
		if (isVOn || isVAuto)
		{
			var vsb = showVScrollBar();
			vsb.height = 0;
			vsbWidth = vsb.width;
			vsbHeight = CMath.max(0, vsb.height - vIndent);
		}
		else
		{
			hideVScrollBar();
		}
		
		if (!isHAuto && !isVAuto)
		{
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
				if (!isHOn)
				{
					width = wrapper.getWidth() + vsbWidth;
				}
				if (!isVOn)
				{
					height = wrapper.getHeight() + hsbHeight;
				}
			}
		}
		else if (isHAuto && !isVAuto)
		{
			if (width < hsbWidth + vsbWidth)
			{
				width = hsbWidth + vsbWidth;
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
				if (wrapper.getWidth() <= width - vsbWidth)
				{
					hideHScrollBar();
					if (!Math.isNaN(wrapper.heightPortion))
					{
						wrapper.setHeight(height);
					}
					if (!isVOn)
					{
						height = wrapper.getHeight();
					}
				}
				else
				{
					if (isVOn && height <= vsbHeight + hsbHeight)
					{
						height = vsbHeight + hsbHeight;
					}
					if (!Math.isNaN(wrapper.heightPortion))
					{
						wrapper.setHeight(height - hsbHeight);
					}
					if (!isVOn)
					{						
						height = wrapper.getHeight() + hsbHeight;
					}
				}
			}
			else
			{
				hideHScrollBar();
			}
		}
		else if (!isHAuto && isVAuto)
		{
			if (width < vsbWidth + hsbWidth)
			{
				width = vsbWidth + hsbWidth;
			}
			if (height < vsbHeight + hsbHeight)
			{
				height = vsbHeight + hsbHeight;
			}
			if (wrapper != null)
			{
				if (!isHOn)
				{
					var minWrapperWidth = if (!Math.isNaN(wrapper.widthPortion))
					{
						wrapper.setWidth(width - vsbWidth);
						wrapper.getWidth();
					}
					else
					{
						wrapper.getWidth();
					}
					width = minWrapperWidth + vsbWidth;
					if (!Math.isNaN(wrapper.widthPortion))
					{
						wrapper.setWidth(width);
					}
					if (!Math.isNaN(wrapper.heightPortion))
					{
						wrapper.setHeight(height);
					}
					if (wrapper.getHeight() <= height)
					{
						hideVScrollBar();
					}
					else if (!Math.isNaN(wrapper.widthPortion))
					{
						wrapper.setWidth(width - vsbWidth);
					}
				}
				else
				{
					if (!Math.isNaN(wrapper.widthPortion))
					{
						wrapper.setWidth(width);
					}
					if (!Math.isNaN(wrapper.heightPortion))
					{
						wrapper.setHeight(height - hsbHeight);
					}
					if (wrapper.getHeight() <= height - hsbHeight)
					{
						hideVScrollBar();
					}
					else if (!Math.isNaN(wrapper.widthPortion))
					{
						wrapper.setWidth(width - vsbWidth);
					}
				}
			}
			else
			{
				hideVScrollBar();
			}
		}
		else
		{
			if (width < vsbWidth + hsbWidth)
			{
				width = vsbWidth + hsbWidth;
			}
			if (height < vsbHeight + hsbHeight)
			{
				height = vsbHeight + hsbHeight;
			}
			if (wrapper != null)
			{
				/*
				Check order of (needHsb, needVsb)
				(false, false) -> (false, true)
				  |                    |
				  \/                   \/
				(true, false) -> (true, true)
				*/
				
				var needHsb = false;
				var needVsb = false;
				
				// (needHsb: false, needVsb: false)
				if (!Math.isNaN(wrapper.widthPortion))
				{
					wrapper.setWidth(width);
				}
				if (wrapper.getWidth() > width)
				{
					// (needHsb: true, needVsb: false)
					needHsb = true;
					if (!Math.isNaN(wrapper.heightPortion))
					{
						wrapper.setHeight(height - hsbHeight);
					}
					if (wrapper.getHeight() > height - hsbHeight)
					{
						// (needHsb: true, needVsb: true)
						needVsb = true;
						if (!Math.isNaN(wrapper.widthPortion))
						{
							wrapper.setWidth(width - vsbWidth);
						}
					}
				}
				else
				{
					// (needHsb: false, needVsb: false)
					if (!Math.isNaN(wrapper.heightPortion))
					{
						wrapper.setHeight(height);
					}
					if (wrapper.getHeight() > height)
					{
						// (needHsb: false, needVsb: true)
						needVsb = true;
						if (!Math.isNaN(wrapper.widthPortion))
						{
							wrapper.setWidth(width - vsbWidth);
						}
						if (wrapper.getWidth() > width - vsbWidth)
						{
							// (needHsb: true, needVsb: true)
							needHsb = true;
						}
					}
				}
				if (!needHsb)
				{
					hideHScrollBar();
				}
				if (!needVsb)
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
		width += hIndent;
		height += vIndent;
	}
		
	public var wrapper:CChildWrapper;
	
	public var hScrollPolicy:CScrollPolicy;
	
	public var vScrollPolicy:CScrollPolicy;
	
	public var isCompactWidth:Bool;
	
	public var isCompactHeight:Bool;
	
	public var width:Float;
	
	public var height:Float;
}