package temperate.core;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.events.Event;
import flash.utils.TypedDictionary;

class CValidator
{
	private static var _instance:CValidator;
	
	public static function getInstance():CValidator
	{
		if (_instance == null)
		{
			_instance = new CValidator();
		}
		return _instance;
	}
	
	function new()
	{
		_shape = new Shape();
		_hasExitFrame = false;
		_sizeListeners = new TypedDictionary();
		_viewListeners = new TypedDictionary();
	}
	
	var _shape:DisplayObject;
	
	var _hasExitFrame:Bool;
	
	var _sizeListeners:TypedDictionary < Void->Dynamic, Bool > ;
	
	var _viewListeners:TypedDictionary < Void->Dynamic, Bool > ;
	
	inline public function postponeSize(listener:Void->Dynamic)
	{
		if (listener != null)
		{
			_sizeListeners.set(listener, true);
			wait();
		}
	}
	
	inline public function postponeView(listener:Void->Dynamic)
	{
		if (listener != null)
		{
			_viewListeners.set(listener, true);
			wait();
		}
	}
	
	inline public function removeSize(listener:Void->Dynamic)
	{
		_sizeListeners.delete(listener);
	}
	
	inline public function removeView(listener:Void->Dynamic)
	{
		_viewListeners.delete(listener);
	}
	
	inline function wait()
	{
		if (!_hasExitFrame)
		{
			_hasExitFrame = true;
			_shape.addEventListener(
				#if flash10 Event.EXIT_FRAME #else Event.ENTER_FRAME #end
				,
				onExitFrame
			);
		}
	}
	
	function onExitFrame(event:Event)
	{
		_shape.removeEventListener(
			#if flash10 Event.EXIT_FRAME #else Event.ENTER_FRAME #end
			,
			onExitFrame
		);
		var sizeListeners = _sizeListeners;
		
		_sizeListeners = new TypedDictionary();
		for (listener in sizeListeners)
		{
			listener();
		}
		
		var viewListeners = _viewListeners;
		_viewListeners = new TypedDictionary();
		for (listener in viewListeners)
		{
			listener();
		}
		
		_hasExitFrame = false;
	}
}