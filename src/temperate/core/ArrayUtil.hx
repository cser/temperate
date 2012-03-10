package temperate.core;

class ArrayUtil 
{	
	public static inline function exists<T>(array:Array<T>, x:T):Bool
	{
		#if flash9
		return untyped array.indexOf(x) != -1;
		#else
		{
			var result = false;
			for (xI in array)
			{
				if (xI == x)
				{
					result = true;
					break;
				}
			}
			return result;
		}
		#end
	}
}