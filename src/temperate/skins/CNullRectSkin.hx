package temperate.skins;
import flash.display.DisplayObject;
import flash.display.Graphics;

class CNullRectSkin implements ICRectSkin
{
	static var _instance:CNullRectSkin;
	
	public static function getInstance()
	{
		if (_instance == null)
		{
			_instance = new CNullRectSkin();
		}
		return _instance;
	}
	
	function new() 
	{
	}
	
	public function link(
		addChildAt0:DisplayObject->Dynamic, removeChild:DisplayObject->Dynamic, graphics:Graphics
	):Void
	{
	}
	
	public function unlink():Void
	{
	}
	
	public var minWidth(default, null):Int;
	
	public var minHeight(default, null):Int;
	
	public var state:CSkinState;
	
	public function setBounds(x:Int, y:Int, width:Int, height:Int):Void
	{
	}
	
	public function redraw():Void
	{
	}
}