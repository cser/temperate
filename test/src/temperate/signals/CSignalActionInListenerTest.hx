package temperate.signals;

import massive.munit.Assert;

class CSignalActionInListenerTest
{
	public function new()
	{
	}
	
	var _log:Array<String>;
	var _signal:CSignal<String->Void>;
	
	@Before
	public function setUp():Void
	{
		_log = null;
		_signal = new CSignal();
	}
	
	@After
	public function tearDown():Void
	{
		
	}
	
	@Test
	public function listenerRemovingInSelf()
	{
		_log = [];
		_signal.add(listener_once);
		_signal.dispatch("*");
		_signal.dispatch("**");
		ArrayAssert.areEqualIgnoringOrder(["*_once"], _log);
		
		_log = [];
		_signal.add(listener_once);
		_signal.add(listener1);
		_signal.dispatch("*");
		ArrayAssert.areEqualIgnoringOrder(["*_once", "*1"], _log);
		
		_log = [];
		_signal.dispatch("&");
		ArrayAssert.areEqualIgnoringOrder(["&1"], _log);
		
		_log = [];
		_signal.remove(listener1);
		ArrayAssert.areEqualIgnoringOrder([], _log);
		
		_log = [];
		_signal.add(listener1);
		_signal.add(listener_once);
		_signal.add(listener2);
		_signal.dispatch("*");
		ArrayAssert.areEqualIgnoringOrder(["*1", "*2", "*_once"], _log);
		
		_log = [];
		_signal.dispatch("&");
		ArrayAssert.areEqualIgnoringOrder(["&1", "&2"], _log);
	}
	
	function listener_once(param:String)
	{
		_signal.remove(listener_once);
		_log.push(param + "_once");
	}
	
	function listener1(param:String)
	{
		_log.push(param + "1");
	}
	
	function listener2(param:String)
	{
		_log.push(param + "2");
	}
	
	@Test
	public function removingAnotherListenerInListener_removingListenerMastBeCalled()
	{
		_log = [];
		_signal.add(listener1);
		_signal.add(listener_remove1And2);
		_signal.add(listener2);
		_signal.dispatch("*");
		ArrayAssert.areEqualIgnoringOrder(["*1", "*2", "*_remove1And2"], _log);
		
		_log = [];
		_signal.dispatch("&");
		ArrayAssert.areEqualIgnoringOrder(["&_remove1And2"], _log);
	}
	
	function listener_remove1And2(param:String)
	{
		_signal.remove(listener1);
		_signal.remove(listener2);
		_log.push(param + "_remove1And2");
	}
	
	@Test
	public function addingListenerDuringDispatch_isNotCallIt()
	{
		_log = [];
		_signal.add(listener_add1);
		_signal.dispatch("*");
		ArrayAssert.areEqualIgnoringOrder(["*_add1"], _log);
		
		_log = [];
		_signal.dispatch("&");
		ArrayAssert.areEqualIgnoringOrder(["&_add1", "&1"], _log);
	}
	
	function listener_add1(param:String)
	{
		_signal.add(listener1);
		_log.push(param + "_add1");
	}
}