package temperate.collections;
#if cpp
#else
import flash.utils.Dictionary;
#end

/**
 * Allows String and Int keys
 * Works slowly than CObjectHash becouse perform type checking
 */
class CHash< K, T >
{
	public function new(defaultValue:T = null) 
	{
		#if cpp
		_mode = MODE_UNKNOWN;
		#else
		_dictionary = new Dictionary();
		#end
		
		_defaultValue = defaultValue;
	}
	
	#if cpp
	private var _values:IntHash<T>;
	private var _keys:IntHash<K>;
	private var _hash:Hash<T>;
	private var _intHash:IntHash<T>;
	
	private static var MODE_UNKNOWN:Int = 0;
	private static var MODE_OBJECT:Int = 1;
	private static var MODE_STRING:Int = 2;
	private static var MODE_INT:Int = 3;
	private var _mode:Int;
	#else
	private var _dictionary:Dictionary;
	#end
	
	private var _defaultValue:T;
	
	public inline function get(k:K):T
	{
		#if cpp
		switch (_mode)
		{
			case MODE_OBJECT:
				var id = getId(k);
				return _values.exists(id) ? _values.get(id) : _defaultValue;
			case MODE_STRING:
				var key:String = cast k;
				return _hash.exists(key) ? _hash.get(key) : _defaultValue;
			/*case MODE_INT:
				var key:Int = cast k;
				return _intHash.exists(key) ? _intHash.get(key) : _defaultValue;*/
			default:
				return _defaultValue;
		}
		#else
		return (untyped __in__(k, _dictionary)) ? (untyped _dictionary[k]) : _defaultValue;
		#end
	}

	public inline function set(k:K, v:T):Void
	{
		if (k != null)
		{
			#if cpp
			cppSet(k, v);
			#else
			untyped _dictionary[k] = v;
			#end
		}
	}

	public inline function exists(k:K):Bool
	{
		#if cpp
		switch (_mode)
		{
			case MODE_OBJECT:
				return _values.exists(getId(k));
			case MODE_STRING:
				var key:String = cast k;
				return _hash.exists(key);
			/*case MODE_INT:
				var key:Int = cast k;
				return _intHash.exists(key);*/
			default:
				return false;
		}
		#else
		return untyped __in__(k, _dictionary);
		#end
	}

	public inline function delete(k:K):Void
	{
		#if cpp
		switch (_mode)
		{
			case MODE_OBJECT:
				var id = getId(k);
				_values.remove(id);
				_keys.remove(id);
			case MODE_STRING:
				_hash.remove(cast k);
			/*case MODE_INT:
				_intHash.remove(cast k);*/
			default:
		}
		#else
		untyped __delete__(_dictionary, k);
		#end
	}

	public inline function keys():Array<K>
	{
		#if cpp
		return cppKeys();
		#else
		return untyped __keys__(_dictionary);
		#end
	}
	
	public inline function values():Array<T>
	{
		#if cpp
		return cppValues();
		#else
		return untyped __foreach__(_dictionary);
		#end
	}
	
	#if cpp
	private function cppSet(k:K, v:T):Void
	{
		if (_mode == MODE_UNKNOWN)
		{
			if (Std.is(k, String))
			{
				_mode = MODE_STRING;
				_hash = new Hash();
			}
			/*else if (Std.is(k, Int))
			{
				_mode = MODE_INT;
				_intHash = new IntHash();
			}*/
			else
			{
				_mode = MODE_OBJECT;
				_values = new IntHash();
				_keys = new IntHash();
			}
		}
		if (_mode == MODE_OBJECT)
		{
			var id = getId(k);
			_keys.set(id, k);
			_values.set(id, v);
		}
		else
		{
			_hash.set(cast k, v);
		}
	}
	
	private function cppKeys():Array<K>
	{
		var array:Array<K> = [];
		switch (_mode)
		{
			case MODE_OBJECT:
				var i = 0;
				for (k in _keys)
				{
					array[i++] = k;
				}
			case MODE_STRING:
				var i = 0;
				for (k in _hash.keys())
				{
					array[i++] = cast k;
				}
			case MODE_INT:
				var i = 0;
				for (k in _intHash.keys())
				{
					array[i++] = cast k;
				}
			default:
		}
		return array;
	}
	
	private function cppValues():Array<T>
	{
		var array:Array<T> = [];
		switch (_mode)
		{
			case MODE_OBJECT:
				var i = 0;
				for (v in _values)
				{
					array[i++] = v;
				}
			case MODE_STRING:
				var i = 0;
				for (v in _hash)
				{
					array[i++] = v;
				}
			case MODE_INT:
				var i = 0;
				for (v in _intHash)
				{
					array[i++] = v;
				}
			default:
		}
		return array;
	}
	
	private function getId(k:K):Int
	{
		return untyped __global__.__hxcpp_obj_id(k);
	}
	#end
}