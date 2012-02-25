package temperate.extra;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;
import flash.Lib;

/**
 * Uses for checking key downed in concrete moment
 * (ActionScript3 API is not provide it, insteard of ActionScript1/2 API)
 */
class CKey 
{
	private static inline var INT_MAX_VALUE:Int = 0x7fffffff;
	
	private static var _instance:CKey;
	
	public static function getInstance():CKey
	{
		if (_instance == null)
		{
			_instance = new CKey();
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