package temperate.collections;
import flash.utils.TypedDictionary;

class CComponentStack< T:ICComponent<T> >
{
	public function new() 
	{
		_indexByComponent = new TypedDictionary();
	}
	
	var _indexByComponent:TypedDictionary<T, Int>;
	
	public function set(index:Int, component:T):Void
	{
		_indexByComponent.set(component, index);
		if (head == null)
		{
			head = component;
		}
		else
		{
			var prev = null;
			var next = head;
			while (true)
			{
				if (_indexByComponent.get(next) < index)
				{
					if (prev != null)
					{
						prev.next = component;
					}
					component.next = next;
					if (next == head)
					{
						head = component;
					}
					break;
				}
				prev = next;
				next = next.next;
				if (next == null)
				{
					prev.next = component;
					break;
				}
			}
		}
	}
	
	public var head(default, null):T;
}