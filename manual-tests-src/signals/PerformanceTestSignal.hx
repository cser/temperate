package signals;

class PerformanceTestSignal< TListener >
{
	var _listeners:Array< TListener >;
	
	public function new() 
	{
		_listeners = [];
		dispatch = cast privateDispatch;
	}
	
	public function add(listener:TListener):Void
	{
		for (listenerI in _listeners)
		{
			if (listenerI == listener)
			{
				return;
			}
		}
		_listeners.push(listener);
	}
	
	public function remove(listener:TListener):Void
	{
		_listeners.remove(listener);
	}
	
	public var dispatch(default, null):TListener;
	
	function privateDispatch(__arguments__):Void
	{
		var listeners = _listeners.copy();		
		for (listener in _listeners)
		{
			Reflect.callMethod(null, listener, __arguments__);
		}
	}
}