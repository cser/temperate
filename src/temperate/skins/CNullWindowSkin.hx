package temperate.skins;

class CNullWindowSkin extends ACWindowSkin
{
	private static var _instance:CNullWindowSkin;
	public static function getInstance()
	{
		if (_instance == null)
		{
			_instance = new CNullWindowSkin();
		}
		return _instance;
	}
	
	function new() 
	{
		super();
	}
}