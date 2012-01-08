package temperate.core;

class ArrayUtil 
{	
	public static inline function exists<T>(array:Array<T>, x:T):Bool
	{
		return untyped array.indexOf(x) != -1;
	}
}