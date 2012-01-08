package temperate.core;
import flash.events.Event;
import flash.events.EventDispatcher;

class CTypedDispatcher< T:Event >
{
	public function new(dispatcher:EventDispatcher)
	{
		_dispatcher = dispatcher;
	}
	
	var _dispatcher:EventDispatcher;
	
	inline public function addTypedListener(
		type:String, listener:T->Void, useCapture:Bool = false,
		priority:Int = 0, useWeakReference:Bool = false):Void
	{
		_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
	}
	
	inline public function removeTypedListener(
		type:String, listener:T->Void, useCapture:Bool = false):Void
	{
		_dispatcher.removeEventListener(type, listener, useCapture);
	}
	
	inline public function dispatchTyped(event:T):Bool
	{
		return _dispatcher.dispatchEvent(event);
	}
	
	inline function hasTypedListener(type:String):Bool
	{
		return _dispatcher.hasEventListener(type);
	}
	
	inline function willTypedTrigger(type:String):Bool
	{
		return _dispatcher.willTrigger(type);
	}
}