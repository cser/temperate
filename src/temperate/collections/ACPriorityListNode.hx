package temperate.collections;

class ACPriorityListNode< T:ACPriorityListNode<T> >
{
	function new()
	{
	}
	
	public var prev:T;
	public var next:T;
	public var priority:Int;
}