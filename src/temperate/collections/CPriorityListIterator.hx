package temperate.collections;

class CPriorityListIterator< T:ACPriorityListNode< T > >
{
	var _current:T;
	
	public function new(head:T)
	{
		_current = head;
	}
	
	public function hasNext():Bool
	{
		return _current != null;
	}
	
    public function next():T
	{
		var result = _current;
		_current = _current.next;
		return result;
	}
}