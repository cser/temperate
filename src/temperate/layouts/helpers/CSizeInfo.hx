package temperate.layouts.helpers;

class CSizeInfo 
{	
	private function new()
	{
		
	}
	
	public static var num = 0;
	
	public static inline function get()
	{
		return if (_first != null)
		{
			var result = _first;
			_first = result._next;
			result._next = null;
			result;
		}
		else
		{
			num++;
			new CSizeInfo();
		}
	}
	
	static var _first:CSizeInfo;
	
	var _next:CSizeInfo;
	
	public inline function dispose()
	{
		_next = _first;
		_first = this;
	}
	
	public var index:Int;
	
	public var size:Float;
	
	public var portion:Float;
	
	public var min:Float;
	
	public var max:Float;
	
	public var gridSize:Float;
	
	public function toString()
	{
		return '(' + index + ': ' + size + ', ' + Std.int(portion * 100) + '%, ' + min + '-' + max +
			')';
	}
}