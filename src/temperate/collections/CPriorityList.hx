package temperate.collections;

/**
 * Works incorrect if added or checked node that exists in other list.
 * For safely work remove node before added to other list
 */
class CPriorityList< T:ACPriorityListNode<T> >
{
	public function new() 
	{
	}
	
	/**
	 * Adds node or move to highest position with new priority.
	 * Note! Expected that you remove node from another list before addition.
	 * But method works correctly if node exists
	 * @param	node
	 * @param	priority
	 */
	public function add(node:T, priority:Null<Int> = null):Void
	{
		if (priority != null)
		{
			node.priority = priority;
		}
		remove(node);
		if (head == null)
		{
			head = node;
			tail = node;
		}
		else
		{
			var current = head;
			while (true)
			{
				if (node.priority >= current.priority)
				{
					node.prev = current.prev;
					node.next = current;
					if (current.prev != null)
					{
						current.prev.next = node;
					}
					current.prev = node;
					if (current == head)
					{
						head = node;
					}
					break;
				}
				if (current.next == null)
				{
					current.next = node;
					node.prev = current;
					tail = node;
					break;
				}
				current = current.next;
			}
		}
	}
	
	/**
	 * Removes node.
	 * Note! If node is not exists do nothing.
	 * I.e. you can call this method even if you don't no exists node or not
	 * @param	node
	 */
	public function remove(node:T):Void
	{
		if (node == head)
		{
			head = node.next;
		}
		if (node == tail)
		{
			tail = node.prev;
		}
		if (node.next != null)
		{
			node.next.prev = node.prev;
		}
		if (node.prev != null)
		{
			node.prev.next = node.next;
		}
		node.prev = null;
		node.next = null;
	}
	
	/**
	 * Move existent node to nearest place where new priority is correct.
	 * Note! Works incorrectly if node is not exists
	 * @param	node
	 * @param	priority
	 */
	public function setPriority(node:T, priority:Int):Void
	{
		node.priority = priority;
		var prev = node.prev;
		var next = node.next;
		if (prev != null && prev.priority < priority)
		{
			remove(node);
			var current = prev;
			while (true)
			{
				if (priority <= current.priority)
				{
					node.prev = current;
					node.next = current.next;
					if (current.next != null)
					{
						current.next.prev = node;
					}
					current.next = node;
					break;
				}
				if (current.prev == null)
				{
					current.prev = node;
					node.next = current;
					head = node;
					break;
				}
				current = current.prev;
			}
		}
		else if (next != null && next.priority > priority)
		{
			remove(node);
			var current = next;
			while (true)
			{
				if (node.priority >= current.priority)
				{
					node.prev = current.prev;
					node.next = current;
					if (current.prev != null)
					{
						current.prev.next = node;
					}
					current.prev = node;
					break;
				}
				if (current.next == null)
				{
					current.next = node;
					node.prev = current;
					tail = node;
					break;
				}
				current = current.next;
			}
		}
	}
	
	/**
	 * Note! Works incorrectly if node exists in another list. It's makes for performance
	 * @param	node
	 * @return
	 */
	inline public function exists(node:T):Bool
	{
		return node.prev != null || node.next != null || node == head;
	}
	
	/**
	 * Node with max priority
	 */
	public var head(default, null):T;
	
	/**
	 * Node with min priority
	 */
	public var tail(default, null):T;
	
	public function iterator():Iterator<T>
	{
		return new CPriorityListIterator<T>(head);
	}
}