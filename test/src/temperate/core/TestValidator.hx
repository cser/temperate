package temperate.core;
import flash.events.Event;
import flash.events.EventDispatcher;
import temperate.core.CSprite;
import temperate.core.CValidator;

class TestValidator extends CValidator
{
	public function new() 
	{
		super();
		sizeHead = new CSprite();
		sizeTail = new CSprite();
		viewHead = new CSprite();
		viewTail = new CSprite();
		_dispatcher = new EventDispatcher();
	}
	
	public var sizeHead(default, null):CSprite;
	public var sizeTail(default, null):CSprite;
	public var viewHead(default, null):CSprite;
	public var viewTail(default, null):CSprite;
	
	public function dispatchExitFrame():Void
	{
		_dispatcher.dispatchEvent(new Event(Event.EXIT_FRAME));
	}
}