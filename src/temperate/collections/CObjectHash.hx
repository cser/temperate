package temperate.collections;
#if cpp
#else
import flash.utils.Dictionary;
#end

/**
 * Don't use this class for string or int keys
 */
class CObjectHash< K, T >
{
	public function new(defaultValue:T = null) 
	{
		#if cpp
		_values = new IntHash();
		_keys = new IntHash();
		#else
		_dictionary = new Dictionary();
		#end
		
		_defaultValue = defaultValue;
	}
	
	#if cpp
	private var _values:IntHash<T>;
	private var _keys:IntHash<K>;
	#else
	private var _dictionary:Dictionary;
	#end
	
	private var _defaultValue:T;
	
	public inline function get(k:K):T
	{
		#if cpp
		var id = getId(k);
		return _values.exists(id) ? _values.get(id) : _defaultValue;
		#else
		return (untyped __in__(k, _dictionary)) ? (untyped _dictionary[k]) : _defaultValue;
		#end
	}

	public inline function set(k:K, v:T):Void
	{
		#if cpp
		var id = getId(k);
		_keys.set(id, k);
		_values.set(id, v);
		#else
		untyped _dictionary[k] = v;
		#end
	}

	public inline function exists(k:K):Bool
	{
		#if cpp
		return _values.exists(getId(k));
		#else
		return untyped __in__(k, _dictionary);
		#end
	}

	public inline function delete(k:K):Void
	{
		#if cpp
		var id = getId(k);
		_values.remove(id);
		_keys.remove(id);
		#else
		untyped __delete__(_dictionary, k);
		#end
	}

	public inline function keys():Array<K>
	{
		#if cpp
		var array = [];
		var i = 0;
		for (k in _keys)
		{
			array[i++] = k;
		}
		return array;
		#else
		return untyped __keys__(_dictionary);
		#end
	}
	
	public inline function values():Array<T>
	{
		#if cpp
		var array = [];
		var i = 0;
		for (k in _values)
		{
			array[i++] = k;
		}
		return array;
		#else
		return untyped __foreach__(_dictionary);
		#end
	}
	
	#if cpp
	private function getId(k:K):Int
	{
		return untyped __global__.__hxcpp_obj_id(k);
	}
	#end
}