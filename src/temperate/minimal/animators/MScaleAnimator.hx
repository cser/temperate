package temperate.minimal.animators;
import flash.display.DisplayObject;
import flash.geom.Rectangle;
import temperate.minimal.easing.MBack;
import temperate.minimal.MTween;
import temperate.tooltips.animators.CAnimatorState;
import temperate.tooltips.animators.ICTooltipAnimator;
import temperate.tooltips.CGeomUtil;
import temperate.tooltips.renderers.ICTooltip;

class MScaleAnimator< T > implements ICTooltipAnimator<T>
{
	var _showDuration:Int;
	var _hideDuration:Int;
	
	var _state:CAnimatorState;
	
	public function new(showDuration:Int = 250, hideDuration:Int = 500) 
	{
		_showDuration = showDuration;
		_hideDuration = hideDuration;
		
		_state = CAnimatorState.HIDED;
		_hideVars = { };
		_showVars = { };
	}
	
	public function setTooltip(tooltip:ICTooltip<T>)
	{
		this.tooltip = tooltip;
	}
	
	var _x:Float;
	var _y:Float;
	var _width:Float;
	var _height:Float;
	var _target:Rectangle;
	
	var _hideVars:Dynamic;
	var _showVars:Dynamic;
	
	var _tween:MTween<DisplayObject>;
	
	public function arrange(x:Float, y:Float, width:Float, height:Float, target:Rectangle):Void
	{
		_x = x;
		_y = y;
		_width = width;
		_height = height;
		_target = target;
		
		CGeomUtil.getNearestRectCross(
			_width * .5, _height * .5,
			target.x + target.width * .5, target.y + target.height * .5,
			target.x, target.y, target.width, target.height, 0
		);
		
		_hideVars.alpha = 0;
		_hideVars.scaleX = 0;
		_hideVars.scaleY = 0;
		_hideVars.x = _x + CGeomUtil.crossX;
		_hideVars.y = _y + CGeomUtil.crossY;
		
		_showVars.alpha = 1;
		_showVars.scaleX = 1;
		_showVars.scaleY = 1;
		_showVars.x = _x;
		_showVars.y = _y;
		
		switch (_state)
		{
			case CAnimatorState.SHOWED:
				MTween.apply(tooltip.view, _showVars);
				tooltip.setTailTarget(_target);
			case CAnimatorState.SHOWING:
				_tween.setVars(_showVars);
				tooltip.setTailTarget(_target);
			case CAnimatorState.HIDING:
				_tween.setVars(_hideVars);
				tooltip.setTailTarget(_target);
			case CAnimatorState.HIDED:
		}
	}
	
	public function initBeforeShow()
	{
		MTween.apply(tooltip.view, _hideVars);
		
		tooltip.setTailTarget(_target);
	}
	
	public var tooltip:ICTooltip<T>;
	
	public function show(fast:Bool)
	{
		_state = SHOWING;
		_tween = null;
		var view = tooltip.view;
		if (fast)
		{
			MTween.apply(view, _showVars);
			_state = SHOWED;
		}
		else
		{
			_tween = MTween.to(view, _showDuration, _showVars)
				.setEase(MBack.typical.easeIn)
				.setOnComplete(onTweenShowComplete);
		}
	}
	
	public function hide(fast:Bool)
	{
		_state = HIDING;
		_tween = null;
		var view = tooltip.view;
		if (fast)
		{
			_state = HIDED;
			MTween.apply(view, _hideVars);
			if (onHideComplete != null)
			{
				onHideComplete();
			}
		}
		else
		{
			_tween = MTween.to(view, _hideDuration, _hideVars)
				.setOnComplete(onTweenHideComplete);
		}
	}
	
	public var onHideComplete:Void->Void;
	
	function onTweenShowComplete(tween)
	{
		_state = SHOWED;
		_tween = null;
	}
	
	function onTweenHideComplete(tween)
	{
		_state = HIDED;
		_tween = null;
		if (onHideComplete != null)
		{
			onHideComplete();
		}
	}
}