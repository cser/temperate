package temperate.signals;
import flash.utils.Dictionary;

class CSignal< TListener >
{
	public function new() 
	{
		dispatch = cast privateDispatch;
	}
	
	var _listeners:Dictionary;
	
	public function add(listener:TListener):Void
	{
		if (_listeners == null)
		{
			_listeners = new Dictionary();
		}
		untyped _listeners[listener] = listener;
	}
	
	public function remove(listener:TListener):Void
	{
		if (_listeners != null)
		{
			untyped __delete__(_listeners, listener);
		}
	}
	
	var _voidListeners:Dictionary;
	
	public function addVoid(listener:Void->Dynamic):Void
	{
		if (_voidListeners == null)
		{
			_voidListeners = new Dictionary();
		}
		untyped _voidListeners[listener] = listener;
	}
	
	public function removeVoid(listener:Void->Dynamic):Void
	{
		if (_voidListeners != null)
		{
			untyped __delete__(_voidListeners, listener);
		}
	}
	
	public var dispatch(default, null):TListener;
	
	function privateDispatch(__arguments__):Void
	{
		var voidKeys:Array < Void->Dynamic > = null;
		if (_voidListeners != null)
		{
			voidKeys = untyped __keys__(_voidListeners);
		}
		if (_listeners != null)
		{
			var keys:Array<TListener> = untyped __keys__(_listeners);
			for (listener in keys)
			{
				Reflect.callMethod(null, listener, __arguments__);
			}
		}
		if (_voidListeners != null)
		{
			for (listener in voidKeys)
			{
				listener();
			}
		}
	}
}