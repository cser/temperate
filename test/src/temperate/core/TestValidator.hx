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
		sizeHead = new ACValidatable(null);
		sizeTail = new ACValidatable(null);
		viewHead = new ACValidatable(null);
		viewTail = new ACValidatable(null);
		_dispatcher = new EventDispatcher();
		init(sizeHead, sizeTail, viewHead, viewTail);
	}
	
	public var sizeHead(default, null):ACValidatable;
	public var sizeTail(default, null):ACValidatable;
	public var viewHead(default, null):ACValidatable;
	public var viewTail(default, null):ACValidatable;
	
	public function dispatchExitFrame():Void
	{
		_dispatcher.dispatchEvent(new Event(Event.EXIT_FRAME));
	}
}