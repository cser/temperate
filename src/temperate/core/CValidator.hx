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
			_instance._sizeHead = new CSprite();
			_instance._sizeTail = new CSprite();
			_instance._viewHead = new CSprite();
			_instance._viewTail = new CSprite();
			_instance._sizeTail.__sp = _instance._sizeHead;
			_instance._sizeHead.__sn = _instance._sizeTail;
			_instance._viewTail.__vp = _instance._viewHead;
			_instance._viewHead.__vn = _instance._viewTail;
			_instance._dispatcher = _instance._sizeHead;
		}
		return _instance;
	}
	
	function new()
	{
		_hasExitFrame = false;
	}
	
	var _sizeHead:CSprite;
	var _sizeTail:CSprite;
	var _viewHead:CSprite;
	var _viewTail:CSprite;
	
	var _dispatcher:IEventDispatcher;
	
	var _hasExitFrame:Bool;
	
	inline public function postponeSize(sprite:CSprite)
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
	
	inline public function postponeView(sprite:CSprite)
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
	
	inline public function removeSize(sprite:CSprite)
	{
		if (sprite.__sp != null)
		{
			sprite.__sp.__sn = sprite.__sn;
			sprite.__sn.__sp = sprite.__sp;
			sprite.__sn = null;
			sprite.__sp = null;
		}
	}
	
	inline public function removeView(sprite:CSprite)
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
		var sprite;
		var sn = _sizeHead.__sn;
		while (true)
		{
			sprite = sn;
			if (sprite == _sizeTail)
			{
				break;
			}
			sn = sprite.__sn;
			sprite.__sp.__sn = sn;
			sn.__sp = sprite.__sp;
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