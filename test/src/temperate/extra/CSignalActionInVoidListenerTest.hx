package temperate.extra;

import massive.munit.Assert;

class CSignalActionInVoidListenerTest
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
		_signal.addVoid(listener_once);
		_signal.dispatch("*");
		_signal.dispatch("**");
		ArrayAssert.equalToArrayIgnoringOrder(["once"], _log);
		
		_log = [];
		_signal.addVoid(listener_once);
		_signal.addVoid(listener1);
		_signal.dispatch("*");
		ArrayAssert.equalToArrayIgnoringOrder(["once", "1"], _log);
		
		_log = [];
		_signal.dispatch("&");
		ArrayAssert.equalToArrayIgnoringOrder(["1"], _log);
		
		_log = [];
		_signal.removeVoid(listener1);
		ArrayAssert.equalToArrayIgnoringOrder([], _log);
		
		_log = [];
		_signal.addVoid(listener1);
		_signal.addVoid(listener_once);
		_signal.addVoid(listener2);
		_signal.dispatch("*");
		ArrayAssert.equalToArrayIgnoringOrder(["1", "2", "once"], _log);
		
		_log = [];
		_signal.dispatch("&");
		ArrayAssert.equalToArrayIgnoringOrder(["1", "2"], _log);
	}
	
	function listener_once()
	{
		_signal.removeVoid(listener_once);
		_log.push("once");
	}
	
	function listener1()
	{
		_log.push("1");
	}
	
	function listener2()
	{
		_log.push("2");
	}
	
	@Test
	public function removingAnotherListenerInListener_removingListenerMastBeCalled()
	{
		_log = [];
		_signal.addVoid(listener1);
		_signal.addVoid(listener_remove1And2);
		_signal.addVoid(listener2);
		_signal.dispatch("*");
		ArrayAssert.equalToArrayIgnoringOrder(["1", "2", "remove1And2"], _log);
		
		_log = [];
		_signal.dispatch("&");
		ArrayAssert.equalToArrayIgnoringOrder(["remove1And2"], _log);
	}
	
	function listener_remove1And2()
	{
		_signal.removeVoid(listener1);
		_signal.removeVoid(listener2);
		_log.push("remove1And2");
	}
	
	@Test
	public function addingListenerDuringDispatch_isNotCallIt()
	{
		_log = [];
		_signal.addVoid(listener_add1);
		_signal.dispatch("*");
		ArrayAssert.equalToArrayIgnoringOrder(["add1"], _log);
		
		_log = [];
		_signal.dispatch("&");
		ArrayAssert.equalToArrayIgnoringOrder(["add1", "1"], _log);
	}
	
	function listener_add1()
	{
		_signal.addVoid(listener1);
		_log.push("add1");
	}
	
	@Test
	public function removingAnotherVoidListenerInListener_removingVoidListenerMastBeCalled()
	{
		_log = [];
		_signal.addVoid(listener1);
		_signal.add(notVoidListener_remove1And2);
		_signal.addVoid(listener2);
		_signal.dispatch("*");
		ArrayAssert.equalToArrayIgnoringOrder(["1", "2", "*_remove1And2"], _log);
		
		_log = [];
		_signal.dispatch("&");
		ArrayAssert.equalToArrayIgnoringOrder(["&_remove1And2"], _log);
	}
	
	function notVoidListener_remove1And2(arg:String)
	{
		_signal.removeVoid(listener1);
		_signal.removeVoid(listener2);
		_log.push(arg + "_remove1And2");
	}
	
	@Test
	public function removingAnotherListenerInVoidListener_removingListenerMastBeCalled()
	{
		_log = [];
		_signal.add(notVoidListener1);
		_signal.addVoid(listener_removeNotVoid1And2);
		_signal.add(notVoidListener2);
		_signal.dispatch("*");
		ArrayAssert.equalToArrayIgnoringOrder(["*1", "*2", "removeNotVoid1And2"], _log);
		
		_log = [];
		_signal.dispatch("&");
		ArrayAssert.equalToArrayIgnoringOrder(["removeNotVoid1And2"], _log);
	}
	
	function notVoidListener1(arg:String)
	{
		_log.push(arg + "1");
	}
	
	function notVoidListener2(arg:String)
	{
		_log.push(arg + "2");
	}
	
	function listener_removeNotVoid1And2()
	{
		_signal.remove(notVoidListener1);
		_signal.remove(notVoidListener2);
		_log.push("removeNotVoid1And2");
	}
}