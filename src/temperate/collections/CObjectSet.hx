package temperate.collections;
#if cpp
#else
import flash.utils.Dictionary;
#end

class CObjectSet< T >
{
	public function new()
	{
		#if cpp
		_values = new IntHash<T>();
		#else
		_dictionary = new Dictionary();
		#end
	}
	
	#if cpp
	private var _values:IntHash<T>;
	#else
	private var _dictionary:Dictionary;
	#end
	
	inline public function add(value:T):Void
	{
		#if cpp
		_values.set(getId(value), value);
		#else
		untyped _dictionary[value] = 1;
		#end
	}
	
	inline public function exists(value:T):Bool
	{
		#if cpp
		return _values.exists(getId(value));
		#else
		return untyped __in__(value, _dictionary);
		#end
	}
	
	inline public function delete(value:T):Void
	{
		#if cpp
		_values.remove(getId(value));
		#else
		untyped __delete__(_dictionary, value);
		#end
	}
	
	inline public function values():Array<T>
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
		return untyped __keys__(_dictionary);
		#end
	}
	
	#if cpp
	private function getId(value:T):Int
	{
		return untyped __global__.__hxcpp_obj_id(value);
	}
	#end
}