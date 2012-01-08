package temperate.minimal.windows;

class MButtonInfo< T >
{
	public function new(data:T, name:String, selected:Bool = false)
	{
		this.data = data;
		this.name = name;
		this.selected = selected;
	}
	
	public var data(default, null):T;
	
	public var name(default, null):String;
	
	public var selected(default, null):Bool;
}