package temperate.collections;

class FakeComponent implements ICComponent<FakeComponent>
{
	public function new(value:String) 
	{
		_value = value;
	}
	
	var _value:String;
	
	public var next:FakeComponent;
	
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