package temperate.collections;
import flash.utils.Dictionary;

class CDoubleDictionary< K, T >
{
	var _vByK:Dictionary;
	var _kByV:Dictionary;
	
	public function new() 
	{
		_vByK = new Dictionary();
		_kByV = new Dictionary();
	}
	
	inline public function getValue(k:K):Null<T>
	{
		return untyped _vByK[k];
	}
	
	inline public function getKey(v:T):Null<K>
	{
		return untyped _kByV[v];
	}
	
	public function set(k:K, v:T):Void
	{
		var oldK = untyped _kByV[v];
		if (oldK != null)
		{
			untyped __delete__(_vByK, oldK);
		}
		var oldV = untyped _vByK[k];
		if (oldV != null)
		{
			untyped __delete__(_kByV, oldV);
		}
		untyped _vByK[k] = v;
		untyped _kByV[v] = k;
	}

	inline public function existsKey(k:K):Bool
	{
		return untyped _vByK[k] != null;
	}
	
	inline public function existsValue(v:T):Bool
	{
		return untyped _kByV[v] != null;
	}

	inline public function deleteByKey(k:K):Void
	{
		var v = untyped _vByK[k];
		untyped __delete__(_vByK, k);
		untyped __delete__(_kByV, v);
	}
	
	inline public function deleteByValue(v:T):Void
	{
		var k = untyped _kByV[v];
		untyped __delete__(_vByK, k);
		untyped __delete__(_kByV, v);
	}

	inline public function keys():Array<K>
	{
		return untyped __keys__(_vByK);
	}
	
	inline public function values():Array<T>
	{
		return untyped __keys__(_kByV);
	}

	public function iterator():Iterator<K>
	{
		return keys().iterator();
	}
}