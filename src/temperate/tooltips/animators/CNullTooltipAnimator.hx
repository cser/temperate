package temperate.tooltips.animators;
import flash.geom.Rectangle;
import temperate.tooltips.renderers.ICTooltip;

class CNullTooltipAnimator< T > implements ICTooltipAnimator<T>
{
	public function new() 
	{
	}
	
	public function setTooltip(tooltip:ICTooltip<T>)
	{
		this.tooltip = tooltip;
	}
	
	public function arrange(x:Float, y:Float, width:Float, height:Float, target:Rectangle):Void
	{
		tooltip.view.x = x;
		tooltip.view.y = y;
		tooltip.setTailTarget(target);
	}
	
	public var tooltip:ICTooltip<T>;
	
	public function initBeforeShow()
	{
	}
	
	public function show(fast:Bool)
	{
	}
	
	public function hide(fast:Bool)
	{
		if (onHideComplete != null)
		{
			onHideComplete();
		}
	}
	
	public function updatePosition()
	{
		
	}
	
	public var onHideComplete:Void->Void;
}