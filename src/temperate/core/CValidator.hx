package temperate.core;
import flash.events.Event;
import flash.events.IEventDispatcher;

class CValidator
{
	private static var _instance:CValidator;
	
	public static function getInstance():CValidator
	{
		if (_instance == null)
		{
			_instance = new CValidator();
			_instance.init(
				new ACValidatable(null), new ACValidatable(null),
				new ACValidatable(null), new ACValidatable(null)
			);
		}
		return _instance;
	}
	
	function new()
	{
		_hasExitFrame = false;
	}
	
	function init(
		sizeHead:ACValidatable, sizeTail:ACValidatable,
		viewHead:ACValidatable, viewTail:ACValidatable):Void
	{
		_sizeHead = sizeHead;
		_sizeTail = sizeTail;
		_viewHead = viewHead;
		_viewTail = viewTail;
		_sizeTail.__sp = _sizeHead;
		_sizeHead.__sn = _sizeTail;
		_viewTail.__vp = _viewHead;
		_viewHead.__vn = _viewTail;
		_dispatcher = _sizeHead;
		_testHash = new flash.utils.TypedDictionary();
		_testIndex = 0;
	}
	
	var _sizeHead:ACValidatable;
	var _sizeTail:ACValidatable;
	var _viewHead:ACValidatable;
	var _viewTail:ACValidatable;
	
	var _dispatcher:IEventDispatcher;
	
	var _hasExitFrame:Bool;
	
	var _testIndex:Int;
	var _testHash:flash.utils.TypedDictionary<ACValidatable, String>;
	
	private function getTestName(sprite:ACValidatable):String
	{
		if (_testHash.get(sprite) == null)
		{
			_testHash.set(sprite, "sprite[" + _testIndex + "]" + "/*" + sprite + "*/");
			_testIndex++;
		}
		return _testHash.get(sprite);
	}
	
	inline public function postponeSize(sprite:ACValidatable)
	{
		if (sprite.__sp == null)
		{
			sprite.__sn = _sizeTail;
			sprite.__sp = _sizeTail.__sp;
			_sizeTail.__sp.__sn = sprite;
			_sizeTail.__sp = sprite;
		}
		wait();
	}
	
	inline public function postponeView(sprite:ACValidatable)
	{
		if (sprite.__vp == null)
		{
			sprite.__vn = _viewTail;
			sprite.__vp = _viewTail.__vp;
			_viewTail.__vp.__vn = sprite;
			_viewTail.__vp = sprite;
		}
		wait();
	}
	
	inline public function removeSize(sprite:ACValidatable)
	{
		if (sprite.__sp != null)
		{
			sprite.__sp.__sn = sprite.__sn;
			sprite.__sn.__sp = sprite.__sp;
			sprite.__sn = null;
			sprite.__sp = null;
		}
	}
	
	inline public function removeView(sprite:ACValidatable)
	{
		if (sprite.__vp != null)
		{
			sprite.__vp.__vn = sprite.__vn;
			sprite.__vn.__vp = sprite.__vp;
			sprite.__vn = null;
			sprite.__vp = null;
		}
	}
	
	inline function wait()
	{
		if (!_hasExitFrame)
		{
			_hasExitFrame = true;
			_dispatcher.addEventListener(
				#if flash10 Event.EXIT_FRAME #else Event.ENTER_FRAME #end
				,
				onExitFrame
			);
		}
	}
	
	function onExitFrame(event:Event)
	{
		_dispatcher.removeEventListener(
			#if flash10 Event.EXIT_FRAME #else Event.ENTER_FRAME #end
			,
			onExitFrame
		);
		while (true)
		{
			var sprite:ACValidatable = _sizeHead.__sn;
			if (sprite == _sizeTail)
			{
				break;
			}
			sprite.__sp.__sn = sprite.__sn;
			sprite.__sn.__sp = sprite.__sp;
			sprite.__sn = null;
			sprite.__sp = null;
			sprite.__validateSize();
		}
		
		var sprite;
		var vn = _viewHead.__vn;
		while (true)
		{
			sprite = vn;
			if (sprite == _viewTail)
			{
				break;
			}
			vn = sprite.__vn;
			sprite.__vp.__vn = vn;
			vn.__vp = sprite.__vp;
			sprite.__vn = null;
			sprite.__vp = null;
			sprite.__validateView();
		}
		
		_hasExitFrame = false;
	}
}