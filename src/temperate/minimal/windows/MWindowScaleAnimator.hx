package temperate.minimal.windows;
import flash.display.DisplayObject;
import temperate.minimal.easing.MBack;
import temperate.minimal.MTween;
import temperate.windows.components.ACWindowComponent;
import temperate.windows.ICPopUp;

class MWindowScaleAnimator extends ACWindowComponent
{
	var _showDuration:Int;
	var _hideDuration:Int;
	
	public function new(showDuration:Int = 300, hideDuration:Int = 300)
	{
		super();
		
		_showDuration = showDuration;
		_hideDuration = hideDuration;
		
		_hideVars = cast { };
		_hideVars.alpha = 0;
		_hideVars.scaleX = 0;
		_hideVars.scaleY = 0;
		
		_showVars = cast { };
		_showVars.alpha = 1;
		_showVars.scaleX = 1;
		_showVars.scaleY = 1;
	}
	
	var _hideVars:MAnimationParameters;
	var _showVars:MAnimationParameters;
	var _tween:MTween<DisplayObject>;
	
	override public function animateShow(fast:Bool):Void
	{
		var width = getWidth();
		var height = getHeight();
		var x = getX();
		var y = getY();
		_hideVars.x = x + width * .5;
		_hideVars.y = y + height * .5;
		MTween.apply(_view, _hideVars);
		var view = _view;
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
	
	override public function animateHide(fast:Bool, onComplete:ICPopUp->Void):Void
	{
		var width = getWidth();
		var height = getHeight();
		var x = getX();
		var y = getY();
		_hideVars.x = x + width * .5;
		_hideVars.y = y + height * .5;
		var view = _view;
		if (fast)
		{
			MTween.apply(view, _hideVars);
			if (onComplete != null)
			{
				onComplete(_popUp);
			}
		}
		else
		{
			_onHideComplete = onComplete;
			_tween = MTween.to(view, _hideDuration, _hideVars)
				.setEase(MBack.typical.easeOut)
				.setVoidOnComplete(onTweenHideComplete);
		}
	}
	
	var _onHideComplete:ICPopUp->Void;
	
	function onTweenShowComplete()
	{
		_tween = null;
	}
	
	function onTweenHideComplete()
	{
		_tween = null;
		var onComplete = _onHideComplete;
		_onHideComplete = null;
		if (onComplete != null)
		{
			onComplete(_popUp);
		}
	}
}