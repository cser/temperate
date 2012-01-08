package temperate.collections;

class FakePriorityNode extends ACPriorityListNode<FakePriorityNode>
{
	public function new(value:String) 
	{
		super();
		_value = value;
	}
	
	var _value:String;
	
	public function getHeadValues():String
	{
		if (next != null)
		{
			return _value + "&" + next.getHeadValues();
		}
		return _value;
	}
	
	public function getTailValues():String
	{
		if (prev != null)
		{
			return prev.getTailValues() + "&" + _value;
		}
		return _value;
	}
	
	public function toString():String
	{
		return "FakeComponent(" + _value + ")";
	}
}