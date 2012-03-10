package temperate.minimal.windows;
import flash.display.DisplayObject;
import temperate.minimal.easing.MBack;
import temperate.minimal.MTween;
import temperate.windows.components.ACWindowComponent;
import temperate.windows.ICWindow;

class MWindowScaleAnimator extends ACWindowComponent
{
	static var MIN_SCALE = .1;
	
	var _showDuration:Int;
	var _hideDuration:Int;
	
	public function new(showDuration:Int = 300, hideDuration:Int = 300)
	{
		super();
		
		_showDuration = showDuration;
		_hideDuration = hideDuration;
		
		_hideVars = cast { };
		_hideVars.alpha = 0;
		_hideVars.scaleX = MIN_SCALE;
		_hideVars.scaleY = MIN_SCALE;
		
		_showVars = cast { };
		_showVars.alpha = 1;
		_showVars.scaleX = 1;
		_showVars.scaleY = 1;
	}
	
	var _hideVars: {
		width:Float, height:Float, x:Float, y:Float, alpha:Float, scaleX:Float, scaleY:Float
	};
	
	var _showVars: {
		width:Float, height:Float, x:Float, y:Float, alpha:Float, scaleX:Float, scaleY:Float
	};
	
	var _tween:MTween<DisplayObject>;
	
	var _isShowing:Bool;
	
	override public function animateShow(fast:Bool):Void
	{
		var width = getWidth();
		var height = getHeight();
		var x = getX();
		var y = getY();
		_hideVars.x = x + width * .5 * (1 - MIN_SCALE);
		_hideVars.y = y + height * .5 * (1 - MIN_SCALE);
		_showVars.x = x;
		_showVars.y = y;
		MTween.apply(_view, _hideVars);
		if (fast)
		{
			MTween.apply(_view, _showVars);
		}
		else
		{
			_isShowing = true;
			_tween = MTween.to(_view, _showDuration, _showVars)
				.setEase(MBack.typical.easeIn)
				.setVoidOnComplete(onTweenShowComplete);
		}
	}
	
	var _isHiding:Bool;
	
	override public function animateHide(fast:Bool, onComplete:ICWindow->Void):Void
	{
		var width = getWidth();
		var height = getHeight();
		var x = getX();
		var y = getY();
		_hideVars.x = x + width * .5 * (1 - MIN_SCALE);
		_hideVars.y = y + height * .5 * (1 - MIN_SCALE);
		if (fast)
		{
			MTween.apply(_view, _hideVars);
			if (onComplete != null)
			{
				onComplete(_popUp);
			}
		}
		else
		{
			_isHiding = true;
			_onHideComplete = onComplete;
			_tween = MTween.to(_view, _hideDuration, _hideVars)
				.setEase(MBack.typical.easeOut)
				.setVoidOnComplete(onTweenHideComplete);
		}
	}
	
	var _onHideComplete:ICWindow->Void;
	
	function onTweenShowComplete()
	{
		_isShowing = false;
		_tween = null;
	}
	
	function onTweenHideComplete()
	{
		_tween = null;
		_isHiding = false;
		var onComplete = _onHideComplete;
		_onHideComplete = null;
		if (onComplete != null)
		{
			onComplete(_popUp);
		}
	}
	
	override public function move(x:Int, y:Int, needSave:Bool):Void 
	{
		if (_isShowing)
		{
			_showVars.x = x;
			_showVars.y = y;
		}
		super.move(x, y, needSave);
	}
}