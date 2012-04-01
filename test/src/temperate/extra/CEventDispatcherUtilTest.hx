package temperate.extra;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
using temperate.extra.CEventDispatcherUtil;

class CEventDispatcherUtilTest
{
	public function new()
	{
	}
	
	private var _dispatcher:EventDispatcher;
	private var _log:Array<String>;
	
	@Before
	public function setUp():Void
	{
		_dispatcher = new EventDispatcher();
	}
	
	@Test
	public function subscribeShortSingaxCases():Void
	{
		_log = [];
		_dispatcher._(++Event.CHANGE, onChange);
		_dispatcher.dispatchEvent(new Event(Event.CHANGE));
		ArrayAssert.equalToArray(["change"], _log);
		
		_log = [];
		_dispatcher._(--Event.CHANGE, onChange);
		_dispatcher.dispatchEvent(new Event(Event.CHANGE));
		ArrayAssert.equalToArray([], _log);
		
		//_dispatcher._(++Event.CHANGE, onMouseEvent);// Mast show compile error
		//_dispatcher._(--Event.CHANGE, onMouseEvent);// Mast show compile error
		_dispatcher._(++MouseEvent.CLICK, onChange);
		_dispatcher._(++MouseEvent.CLICK, onMouseEvent);
		_dispatcher._(++MouseEvent.CLICK, onMouseEvent, true, 10, true);
		//_dispatcher._(--MouseEvent.CLICK, onMouseEvent, true, 10, true);// Mast show compile error
		//_dispatcher._(--MouseEvent.CLICK, onMouseEvent, true, 10);// Mast show compile error
		_dispatcher._(--MouseEvent.CLICK, onMouseEvent, false);
	}
	
	private function onChange(event:Event):Void
	{
		_log.push("change");
	}
	
	private function onMouseEvent(event:MouseEvent):Void
	{
		_log.push("mouseEvent");
	}
}