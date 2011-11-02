package temperate.extra;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;
import flash.Lib;

class Key 
{
	private static inline var INT_MAX_VALUE:Int = 0x7fffffff;
	
	private static var _instance:Key;
	
	public static function getInstance():Key
	{
		if (_instance == null)
		{
			_instance = new Key();
		}
		return _instance;
	}
	
	var _hash:IntHash<Bool>;
	
	function new() 
	{
		_hash = new IntHash();
	}
	
	function init(eventSource:IEventDispatcher):Void
	{
		eventSource.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, INT_MAX_VALUE);
		eventSource.addEventListener(KeyboardEvent.KEY_UP, onKeyUp, false, INT_MAX_VALUE);
	}
	
	public function isDown(keyCode:Int):Bool
	{
		return _hash.exists(keyCode);
	}
	
	function onKeyDown(event:KeyboardEvent):Void
	{
		_hash.set(event.keyCode, true);
	}
	
	function onKeyUp(event:KeyboardEvent):Void
	{
		_hash.remove(event.keyCode);
	}
	
	static function __init__():Void
	{
		getInstance().init(Lib.current.stage);
	}
}