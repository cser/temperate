package temperate.minimal;
import flash.display.Shape;
import flash.events.Event;
import flash.Lib;
import flash.utils.TypedDictionary;
import temperate.minimal.easing.MEaseMethod;
import temperate.minimal.easing.MPower;

/**
 * Class was introduced for minimal components free of external libs.
 * This class is _not_ recomended to use.
 * In your project you mast use your favorite tweener
 */
class MTween< T >
{
	//----------------------------------------------------------------------------------------------
	//
	//  Collisions check
	//
	//----------------------------------------------------------------------------------------------
	
	static var _tweenSet:TypedDictionary<Dynamic, MTween<Dynamic>>;
	
	static function register(target:Dynamic, tween:MTween<Dynamic>)
	{
		if (_tweenSet == null)
		{
			_tweenSet = new TypedDictionary();
		}
		var oldTween = _tweenSet.get(target);
		if (oldTween != null)
		{
			oldTween.kill();
		}
		_tweenSet.set(target, tween);
	}
	
	static function unregister(target:Dynamic, tween:MTween<Dynamic>)
	{
		if (_tweenSet != null)
		{
			var oldTween = _tweenSet.get(target);
			if (oldTween == tween)
			{
				_tweenSet.delete(target);
			}
		}
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Other
	//
	//----------------------------------------------------------------------------------------------
	
	public static function killTargetTween(target:Dynamic)
	{
		if (_tweenSet != null)
		{
			var tween = _tweenSet.get(target);
			if (tween != null)
			{
				tween.kill();
			}
		}
	}
	
	/**
	 * Create and start tween
	 * @param	target - object, that fields changing by tween
	 * @param	vars - has of end values of target fields
	 * @param	duration - tween time milliseconds
	 * @return	tween object (for additional parametrization or stop,
	 * parametrization is _not_ damage tween if it in this frame)
	 */
	public static function to<T>(target:T, duration:Int, vars:Dynamic)
	{
		return new MTween(target, duration, vars);
	}
	
	public static function apply<T>(target:T, vars:Dynamic)
	{
		killTargetTween(target);
		for (field in Reflect.fields(vars))
		{
			Reflect.setField(target, field, Reflect.field(vars, field));
		}
	}
	
	static var _enterFrameDispatcher:Shape;
	
	var _vars:Dynamic;
	var _startVars:Dynamic;
	var _duration:Int;
	
	var _startTime:Int;
	
	function new(target:T, duration:Int, vars:Dynamic<Float>)
	{
		this.target = target;
		_vars = vars;
		_startVars = { };
		for (field in Reflect.fields(_vars))
		{
			Reflect.setField(_startVars, field, Reflect.field(target, field));
		}
		_duration = duration;
		_ease = MPower.quad.easeOut;
		register(target, this);
		
		if (_enterFrameDispatcher == null)
		{
			_enterFrameDispatcher = new Shape();
		}
		_startTime = Lib.getTimer();
		_elapsedTime = 0;
		_enterFrameDispatcher.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	public var target(default, null):T;
	
	/**
	 * (elapsed time, start value, delta value, duration) - current value
	 */
	var _ease:MEaseMethod;
	
	/**
	 * @param	ease function(t, b, c, d)
	 * t - elapsed time since tween start, current time;
	 * b - start value, value0;
	 * c - change, value1 - value0, delta value;
	 * d - duration, t1 - t0, delta time.
	 * Easing function mast returns current value
	 * 
	 * @return this
	 */
	public function setEase(ease:MEaseMethod)
	{
		_ease = ease;
		return this;
	}
	
	var _onComplete:MTween<T>->Void;
	
	public function setOnComplete(onComplete:MTween<T>->Void)
	{
		_onComplete = onComplete;
		return this;
	}
	
	var _voidOnComplete:Void->Void;
	
	public function setVoidOnComplete(voidOnComplete:Void->Void)
	{
		_voidOnComplete = voidOnComplete;
		return this;
	}
	
	var _onUpdate:MTween<T>->Void;
	
	public function setOnUpdate(onUpdate:MTween<T>->Void)
	{
		_onUpdate = onUpdate;
		return this;
	}
	
	var _voidOnUpdate:Void->Void;
	
	public function setVoidOnUpdate(voidOnUpdate:Void->Void)
	{
		_voidOnUpdate = voidOnUpdate;
		return this;
	}
	
	var _elapsedTime:Int;
	
	function onEnterFrame(event:Event)
	{
		_elapsedTime = Lib.getTimer() - _startTime;
		if (_elapsedTime >= _duration)
		{
			for (field in Reflect.fields(_vars))
			{
				var endValue:Float = Reflect.field(_vars, field);
				Reflect.setField(target, field, endValue);
			}
			if (_onUpdate != null)
			{
				_onUpdate(this);
			}
			if (_voidOnUpdate != null)
			{
				_voidOnUpdate();
			}
			kill(true);
		}
		else
		{
			for (field in Reflect.fields(_vars))
			{
				var startValue:Float = Reflect.field(_startVars, field);
				var endValue:Float = Reflect.field(_vars, field);
				var value = _ease(_elapsedTime, startValue, endValue - startValue, _duration);
				Reflect.setField(target, field, value);
			}
			if (_onUpdate != null)
			{
				_onUpdate(this);
			}
		}
	}
	
	public function kill(callComplete:Bool = false)
	{
		if (_enterFrameDispatcher != null)
		{
			_enterFrameDispatcher.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		unregister(target, this);
		if (callComplete)
		{
			if (_onComplete != null)
			{
				_onComplete(this);
			}
			if (_voidOnComplete != null)
			{
				_voidOnComplete();
			}
		}
	}
	
	public function getValue(startValue:Float, endValue:Float)
	{
		if (_elapsedTime >= _duration)
		{
			return endValue;
		}
		return _ease(_elapsedTime, startValue, endValue - startValue, _duration);
	}
	
	public function setVars(vars:Dynamic)
	{
		_vars = vars;
	}
}