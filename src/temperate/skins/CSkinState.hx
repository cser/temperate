package temperate.skins;

class CSkinState 
{
	public static var NORMAL:CSkinState = new CSkinState("normal");
	
	public static var INACTIVE:CSkinState = new CSkinState("inactive");
	
	public static var DISABLED:CSkinState = new CSkinState("disabled");
	
	static var _currentIndex = 0;
	
	function new(name:String)
	{
		index = _currentIndex++;
		_name = name;
	}
	
	public var index(default, null):Int;
	
	var _name:String;
	
	public function toString():String
	{
		return "[CSkinState: " + _name + "]";
	}	
}