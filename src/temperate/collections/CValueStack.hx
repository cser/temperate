package temperate.collections;

class CValueStack< T >
{
	public function new(changeCallback:Void->Void = null)
	{
		_changeCallback = changeCallback;
	}
	
	var _changeCallback:Void->Void;
	var _head:CValueStackNode<T>;
	
	public var value(default, null):T;
	
	public function newSwitcher(priority:Int = 0):ICValueSwitcher<T>
	{
		return new CValueStackNode(add, remove, priority);
	}
	
	function add(node:CValueStackNode<T>)
	{
		if (_head != null)
		{
			_head.changeCallback = null;
		}
		
		removeFromList(node);
		if (_head == null)
		{
			_head = node;
		}
		else
		{
			var current = _head;
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
					if (current == _head)
					{
						_head = node;
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
		
		_head.changeCallback = on_headChange;
		var newValue = _head.value;
		if (newValue != value)
		{
			value = newValue;
			if (_changeCallback != null)
			{
				_changeCallback();
			}
		}
	}
	
	function remove(node:CValueStackNode<T>)
	{
		if (_head != null)
		{
			_head.changeCallback = null;
		}
		
		removeFromList(node);
		
		var newValue;
		if (_head != null)
		{
			newValue = _head.value;
			_head.changeCallback = on_headChange;
		}
		else
		{
			newValue = null;
		}
		if (newValue != value)
		{
			value = newValue;
			if (_changeCallback != null)
			{
				_changeCallback();
			}
		}
	}
	
	inline function removeFromList(node:CValueStackNode<T>)
	{
		if (node == _head)
		{
			_head = node.next;
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
	
	function on_headChange()
	{
		var newValue = _head.value;
		if (newValue != value)
		{
			value = _head.value;
			if (_changeCallback != null)
			{
				_changeCallback();
			}
		}
	}
}