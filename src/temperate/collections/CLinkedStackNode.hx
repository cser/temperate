package temperate.collections;

class CLinkedStackNode< T > implements ICValueSwitcher<T>
{
	private var _add:CLinkedStackNode<T>->Void;
	private var _remove:CLinkedStackNode<T>->Void;
	
	public function new(
		add:CLinkedStackNode<T>->Void, remove:CLinkedStackNode<T>->Void, priority:Int) 
	{
		_add = add;
		_remove = remove;
		this.priority = priority;
	}
	
	public var priority(default, null):Int;
	
	public var value(default, set_value):T;
	function set_value(value:T)
	{
		if (this.value != value)
		{
			this.value = value;
			if (changeCallback != null)
			{
				changeCallback();
			}
		}
		return this.value;
	}
	
	public function setValue(value:T):ICValueSwitcher<T>
	{
		this.value = value;
		return this;
	}
	
	public var prev:CLinkedStackNode<T>;
	public var next:CLinkedStackNode<T>;
	
	public var changeCallback:Void->Void;
	
	public function on()
	{
		_add(this);
	}
	
	public function off()
	{
		_remove(this);
	}
}