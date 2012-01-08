package windowApplication;
import temperate.extra.CSignal;

class Primitives
{
	public static function fromArray(array:Array<Primitive>):Primitives
	{
		var primitives = new Primitives();
		for (primitive in array)
		{
			primitives.push(primitive);
		}
		return primitives;
	}
	
	public function new() 
	{
		changed = new CSignal();
		length = 0;
		_array = [];
	}
	
	public var changed(default, null):CSignal < Void->Void > ;
	
	public var length(default, null):Int;
	
	var _array:Array<Primitive>;
	
	public function push(object:Primitive)
	{
		_array[length++] = object;
		changed.dispatch();
	}
	
	public function iterator():Iterator<Primitive>
	{
		return _array.iterator();
	}
	
	public function toArray():Array<Primitive>
	{
		return _array.concat([]);
	}
}