package temperate.collections;

class CValueStackNode< T > implements ICValueSwitcher<T>
{
	private var _add:CValueStackNode<T>->Void;
	private var _remove:CValueStackNode<T>->Void;
	
	public function new(
		add:CValueStackNode<T>->Void, remove:CValueStackNode<T>->Void, priority:Int) 
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
	
	public var prev:CValueStackNode<T>;
	public var next:CValueStackNode<T>;
	
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