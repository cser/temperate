package temperate.collections;
import flash.utils.TypedDictionary;

class CPriorityList< T:ACPriorityListNode<T> >
{
	public function new() 
	{
	}
	
	public function add(node:T, priority:Int):Void
	{
		node.priority = priority;
		remove(node);
		if (head == null)
		{
			head = node;
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
					break;
				}
				current = current.next;
			}
		}
	}
	
	public function remove(node:T):Void
	{
		if (node == head)
		{
			head = node.next;
		}
		if (node.prev != null)
		{
			node.prev.next = node.next;
		}
		if (node.next != null)
		{
			node.next.prev = node.prev;
		}
		node.prev = null;
		node.next = null;
	}
	
	public function updatePriority(node:T, priority:Int):Void
	{
	}
	
	public var head(default, null):T;
	
	public var tail(default, null):T;
}