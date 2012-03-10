package temperate.extra;

class CSignal< TListener >
{
	public function new() 
	{
		dispatch = Reflect.makeVarArgs(privateDispatch);
		_listeners = [];
		_length = 0;
		_voidListeners = [];
		_voidLength = 0;
	}
	
	var _listeners:Array<TListener>;
	var _length:Int;
	
	public function add(listener:TListener):Void
	{
		for (i in 0 ... _length)
		{
			if (_listeners[i] == listener)
			{
				return;
			}
		}
		_listeners[_length++] = listener;
	}
	
	public function remove(listener:TListener):Void
	{
		for (i in 0 ... _length)
		{
			if (_listeners[i] == listener)
			{
				_listeners[i] = _listeners[_length - 1];
				_listeners[_length - 1] = null;
				_length--;
				break;
			}
		}
	}
	
	var _voidListeners:Array < Void->Dynamic > ;
	var _voidLength:Int;
	
	public function addVoid(listener:Void->Dynamic):Void
	{
		for (i in 0 ... _voidLength)
		{
			if (_voidListeners[i] == listener)
			{
				return;
			}
		}
		_voidListeners[_voidLength++] = listener;
	}
	
	public function removeVoid(listener:Void->Dynamic):Void
	{
		for (i in 0 ... _voidLength)
		{
			if (_voidListeners[i] == listener)
			{
				_voidListeners[i] = _voidListeners[_voidLength - 1];
				_voidListeners[_voidLength - 1] = null;
				_voidLength--;
				break;
			}
		}
	}
	
	public var dispatch(default, null):TListener;
	
	function privateDispatch(args:Array<Dynamic>):Void
	{
		var voidListeners:Array < Void->Dynamic > = null;
		if (_voidLength > 0)
		{
			voidListeners = [];
			for (i in 0 ... _voidLength)
			{
				voidListeners[i] = _voidListeners[i];
			}
		}
		var listeners:Array<TListener> = null;
		if (_length > 0)
		{
			listeners = [];
			for (i in 0 ... _length)
			{
				listeners[i] = _listeners[i];
			}
		}
		if (listeners != null)
		{
			for (listener in listeners)
			{
				Reflect.callMethod(null, listener, args);
			}
		}
		if (voidListeners != null)
		{
			for (listener in voidListeners)
			{
				listener();
			}
		}
	}
}