package temperate.skins;
import flash.display.DisplayObject;
import flash.display.Graphics;

class CNullScrollSkin implements ICScrollSkin
{
	static var _instance:CNullScrollSkin;
	
	public static function getInstance()
	{
		if (_instance == null)
		{
			_instance = new CNullScrollSkin();
		}
		return _instance;
	}
	
	function new() 
	{
	}
	
	public function link(
		horizontal:Bool, addChildAt0:DisplayObject->Dynamic, removeChild:DisplayObject->Dynamic,
		graphics:Graphics
	):Void
	{
	}
	
	public function unlink():Void
	{
	}
	
	public function setSize(scrollLeft:Int, scrollSize:Int, size:Int):Void
	{
	}
	
	public function redrawUp():Void
	{
	}
	
	public function redrawDown(isLeft:Bool, thumbCenter:Int):Void
	{
	}
}