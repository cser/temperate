package temperate.minimal.animators;
import flash.display.DisplayObject;
import temperate.minimal.easing.MBack;
import temperate.minimal.MTween;
import temperate.windows.animators.ICPopUpAnimator;
import temperate.windows.ICPopUp;

class MPopUpScaleAnimator implements ICPopUpAnimator
{
	var _showDuration:Int;
	var _hideDuration:Int;
	
	public function new(showDuration:Int = 300, hideDuration:Int = 500)
	{
		_showDuration = showDuration;
		_hideDuration = hideDuration;
		
		_hideVars = { };
		_hideVars.alpha = 0;
		_hideVars.scaleX = 0;
		_hideVars.scaleY = 0;
		
		_showVars = { };
		_showVars.alpha = 1;
		_showVars.scaleX = 1;
		_showVars.scaleY = 1;
	}
	
	var _hideVars:Dynamic;
	var _showVars:Dynamic;
	var _tween:MTween<DisplayObject>;
	
	public function setPopUp(popUp:ICPopUp):Void
	{
		this.popUp = popUp;
	}
	
	public var popUp:ICPopUp;
	
	public function initBeforeShow()
	{
		MTween.apply(popUp.view, _hideVars);
	}
	
	public function show(fast:Bool):Void
	{
		var view = popUp.view;
		if (fast)
		{
			MTween.apply(view, _showVars);
		}
		else
		{
			_tween = MTween.to(view, _showDuration, _showVars)
				.setEase(MBack.typical.easeIn)
				.setVoidOnComplete(onTweenShowComplete);
		}
	}
	
	public function hide(fast:Bool):Void
	{
		var view = popUp.view;
		if (fast)
		{
			MTween.apply(view, _hideVars);
			if (onHideComplete != null)
			{
				onHideComplete(this);
			}
		}
		else
		{
			_tween = MTween.to(view, _hideDuration, _hideVars)
				.setVoidOnComplete(onTweenHideComplete);
		}
	}
	
	public var onHideComplete:ICPopUpAnimator->Void;
	
	function onTweenShowComplete()
	{
		_tween = null;
	}
	
	function onTweenHideComplete()
	{
		_tween = null;
		if (onHideComplete != null)
		{
			onHideComplete(this);
		}
	}
}