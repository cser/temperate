package temperate.collections;

class FakePriorityNode extends ACPriorityListNode<FakePriorityNode>
{
	public function new(value:String) 
	{
		super();
		_value = value;
	}
	
	var _value:String;
	
	public function getValues():String
	{
		if (next != null)
		{
			return _value + "&" + next.getValues();
		}
		return _value;
	}
	
	public function toString():String
	{
		return "FakeComponent(" + _value + ")";
	}
}