package temperate.extra;

import massive.munit.Assert;

class CSignalTest
{
	public function new()
	{
	}
	
	var _log:Array<String>;
	
	@Before
	public function setUp():Void
	{
		_log = [];
	}
	
	@After
	public function tearDown():Void
	{
		
	}
	
	@Test
	public function oneAddedSimpleListenerIsCalledDuringDispatching()
	{
		var signal = new CSignal < Void->Void > ();
		signal.add(onSimple);
		signal.dispatch();
		ArrayAssert.equalToArray(["simple"], _log);
	}
	
	@Test
	public function oneSimpleListenerIsNotCalledAfterRemoving()
	{
		var signal = new CSignal < Void->Void > ();
		signal.add(onSimple);
		signal.remove(onSimple);
		signal.dispatch();
		ArrayAssert.equalToArray([], _log);
	}
	
	@Test
	public function repeatAdditionIsNotRegistersSecondListener()
	{
		var signal = new CSignal < Void->Void > ();
		signal.add(onSimple);
		signal.add(onSimple);
		signal.dispatch();
		ArrayAssert.equalToArray(["simple"], _log);
	}
	
	@Test
	public function repeatRemovingIsNotThrowsException()
	{
		var signal = new CSignal < Void->Void > ();
		signal.add(onSimple);
		signal.remove(onSimple);
		signal.remove(onSimple);
		signal.dispatch();
		ArrayAssert.equalToArray([], _log);
	}
	
	function onSimple()
	{
		_log.push("simple");
	}
	
	@Test
	public function severalParametersCases()
	{
		_log = [];
		var signal = new CSignal < String->Void > ();
		signal.add(onOneParam);
		signal.dispatch("param");
		ArrayAssert.equalToArray(["param"], _log);
		
		_log = [];
		var signal = new CSignal < String->String->Void > ();
		signal.add(onTwoParam);
		signal.dispatch("param0", "param1");
		ArrayAssert.equalToArray(["param0-param1"], _log);
	}
	
	@Test
	public function dispatchingToSeveralListeners()
	{
		var signal = new CSignal < String->Void > ();
		signal.add(onOneParam);
		signal.add(onOneParamWithStar);
		signal.dispatch("text");
		ArrayAssert.equalToArrayIgnoringOrder(["text", "text*"], _log);
	}
	
	@Test
	public function removingOfSeveralListeners()
	{
		_log = [];
		var signal = new CSignal < String->Void > ();
		signal.add(onOneParam);
		signal.add(onOneParamWithStar);
		signal.remove(onOneParam);
		signal.dispatch("text");
		ArrayAssert.equalToArray(["text*"], _log);
		
		_log = [];
		signal.remove(onOneParamWithStar);
		signal.dispatch("text");
		ArrayAssert.equalToArray([], _log);
	}
	
	function onOneParam(arg:String)
	{
		_log.push(arg);
	}
	
	function onOneParamWithStar(arg:String)
	{
		_log.push(arg + "*");
	}
	
	function onTwoParam(arg0:String, arg1:String)
	{
		_log.push(arg0 + "-" + arg1);
	}
}