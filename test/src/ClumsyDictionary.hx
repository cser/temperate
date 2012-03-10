package ;

/**
 * Never! Never use it class.
 * It's very poor in performance
 */
class ClumsyDictionary< K, T >
{
	public function new() 
	{
		_keys = [];
		_values = [];
	}
	
	private var _keys:Array<K>;
	private var _values:Array<T>;
	
	public function get(k:K):Null<T>
	{
		for (i in 0 ... _keys.length)
		{
			if (_keys[i] == k)
			{
				return _values[i];
			}
		}
		return null;
	}

	public function set(k:K, v:T)
	{
		for (i in 0 ... _keys.length)
		{
			if (_keys[i] == k)
			{
				_values[i] = v;
				return;
			}
		}
		var i = _keys.length;
		_keys[i] = k;
		_values[i] = v;
	}

	public function exists(k:K)
	{
		for (i in 0 ... _keys.length)
		{
			if (_keys[i] == k)
			{
				return true;
			}
		}
		return false;
	}

	public function delete(k:K)
	{
		for (i in 0 ... _keys.length)
		{
			if (_keys[i] == k)
			{
				_keys.splice(i, 1);
				_values.splice(i, 1);
				return;
			}
		}
	}

	public function keys():Array<K>
	{
		return _keys;
	}

	public function iterator():Iterator<K>
	{
		return _keys.iterator();
	}
}