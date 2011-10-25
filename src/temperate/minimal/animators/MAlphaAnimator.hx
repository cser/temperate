package temperate.minimal.animators;
import flash.geom.Rectangle;
import temperate.minimal.MTween;
import temperate.tooltips.animators.ICTooltipAnimator;
import temperate.tooltips.renderers.ICTooltip;

class MAlphaAnimator< T > implements ICTooltipAnimator<T>
{
	var _showDuration:Int;
	var _hideDuration:Int;
	
	public function new(showDuration:Int = 500, hideDuration:Int = 500) 
	{
		_showDuration = showDuration;
		_hideDuration = hideDuration;
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
	
	public function initBeforeShow()
	{
		tooltip.view.alpha = 0;
	}
	
	public var tooltip:ICTooltip<T>;
	
	public function show(fast:Bool)
	{
		var view = tooltip.view;
		if (fast)
		{
			MTween.killTargetTween(view);
			tooltip.view.alpha = 1;
		}
		else
		{
			MTween.to(view, _showDuration, { alpha:1 });
		}
	}
	
	public function hide(fast:Bool)
	{
		var view = tooltip.view;
		if (fast)
		{
			MTween.killTargetTween(view);
			view.alpha = 0;
			if (onHideComplete != null)
			{
				onHideComplete();
			}
		}
		else
		{
			MTween.to(view, _hideDuration, { alpha:0 }).setOnComplete(onTweenHideComplete);
		}
	}
	
	public var onHideComplete:Void->Void;
	
	function onTweenHideComplete(tween)
	{
		if (onHideComplete != null)
		{
			onHideComplete();
		}
	}
}