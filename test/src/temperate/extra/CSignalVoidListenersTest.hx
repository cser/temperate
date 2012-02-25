package temperate.extra;

class CSignalVoidListenersTest
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
		signal.addVoid(onSimple);
		signal.dispatch();
		ArrayAssert.equalToArray(["simple"], _log);
	}
	
	@Test
	public function oneSimpleListenerIsNotCalledAfterRemoving()
	{
		var signal = new CSignal < Void->Void > ();
		signal.addVoid(onSimple);
		signal.removeVoid(onSimple);
		signal.dispatch();
		ArrayAssert.equalToArray([], _log);
	}
	
	@Test
	public function repeatAdditionIsNotRegistersSecondListener()
	{
		var signal = new CSignal < Void->Void > ();
		signal.addVoid(onSimple);
		signal.addVoid(onSimple);
		signal.dispatch();
		ArrayAssert.equalToArray(["simple"], _log);
	}
	
	@Test
	public function repeatRemovingIsNotThrowsException()
	{
		var signal = new CSignal < Void->Void > ();
		signal.addVoid(onSimple);
		signal.removeVoid(onSimple);
		signal.removeVoid(onSimple);
		signal.dispatch();
		ArrayAssert.equalToArray([], _log);
	}
	
	function onSimple()
	{
		_log.push("simple");
	}
	
	function onSimpleWithStar()
	{
		_log.push("simple*");
	}
	
	@Test
	public function severalParamsCases()
	{
		_log = [];
		var signal = new CSignal < String->Void > ();
		signal.add(onOneParam);
		signal.addVoid(onSimple);
		signal.dispatch("param");
		ArrayAssert.equalToArrayIgnoringOrder(["param", "simple"], _log);
		
		_log = [];
		var signal = new CSignal < String->String->Void > ();
		signal.add(onTwoParam);
		signal.addVoid(onSimple);
		signal.dispatch("param0", "param1");
		ArrayAssert.equalToArrayIgnoringOrder(["param0-param1", "simple"], _log);
	}
	
	@Test
	public function dispatchingToSeveralListeners()
	{
		var signal = new CSignal < String->Void > ();
		signal.add(onOneParam);
		signal.add(onOneParamWithStar);
		signal.addVoid(onSimple);
		signal.addVoid(onSimpleWithStar);
		signal.dispatch("text");
		ArrayAssert.equalToArrayIgnoringOrder(["text", "text*", "simple", "simple*"], _log);
	}
	
	@Test
	public function removingOfSeveralListeners()
	{
		_log = [];
		var signal = new CSignal < String->Void > ();
		signal.addVoid(onSimple);
		signal.addVoid(onSimpleWithStar);
		signal.removeVoid(onSimple);
		signal.dispatch("text");
		ArrayAssert.equalToArray(["simple*"], _log);
		
		_log = [];
		signal.removeVoid(onSimpleWithStar);
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