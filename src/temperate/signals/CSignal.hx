package temperate.signals;
import flash.utils.Dictionary;

class CSignal< TListener >
{
	var _listeners:Dictionary;
	
	public function new() 
	{
		_listeners = new Dictionary();
		dispatch = cast privateDispatch;
	}
	
	public function add(listener:TListener):Void
	{
		untyped _listeners[listener] = listener;
	}
	
	public function remove(listener:TListener):Void
	{
		untyped __delete__(_listeners, listener);
	}
	
	public var dispatch(default, null):TListener;
	
	function privateDispatch(__arguments__):Void
	{
		var keys:Array<TListener> = untyped __keys__(_listeners);
		for (listener in keys)
		{
			Reflect.callMethod(null, listener, __arguments__);
		}
	}
}