package temperate.minimal.windows;

class MButtonInfo< T >
{
	public function new(data:T, name:String)
	{
		this.data = data;
		this.name = name;
	}
	
	public var data(default, null):T;
	
	public var name(default, null):String;
}