package temperate.collections;

class ACPriorityListNode< T:ACPriorityListNode<T> >
{
	function new()
	{
		priority = 0;
	}
	
	public var prev:T;
	public var next:T;
	public var priority:Int;
}