package oldStyleCalculator;

import haxe.PosInfos;
import massive.munit.Assert;

class ControllerTest
{
	public function new()
	{
	}
	
	var _log:Array<String>;
	var _controller:Controller;
	
	@Before
	public function setUp():Void
	{
		_log = [];
		_controller = new Controller();
		_controller.screenChanged.add(onScreenChanged);
	}
	
	function onScreenChanged()
	{
		_log.push(_controller.screen);
	}
	
	function assertScreen(expected:String, ?info:PosInfos)
	{
		Assert.areEqual(expected, _controller.screen, info);
	}
	
	@Test
	public function initValueIs0()
	{
		Assert.areEqual("0", _controller.screen);
	}
	
	@Test
	public function numberPrinting()
	{
		_controller.addSymbol("1");
		Assert.areEqual("1", _log.shift());
		_controller.addSymbol("3");
		Assert.areEqual("13", _log.shift());
		_controller.addSymbol("5");
		Assert.areEqual("135", _log.shift());
		assertScreen("135");
	}
	
	@Test
	public function numberPlusNumberCalculate()
	{
		_controller.addSymbol("1");
		_controller.addSymbol("3");
		_controller.addSymbol("5");
		assertScreen("135");
		_controller.addOperation(Operation.PLUS);
		assertScreen("135");
		_controller.addSymbol("1");
		_controller.addSymbol("2");
		assertScreen("12");
		_log = [];
		_controller.calculate();
		Assert.areEqual("147", _log.shift());
		assertScreen("147");
	}
	
	@Test
	public function numberMinusNumberPlusNumberCalculate()
	{
		_controller.addSymbol("1");
		assertScreen("1");
		_controller.addOperation(Operation.MINUS);
		assertScreen("1");
		_controller.addSymbol("2");
		assertScreen("2");
		_controller.calculate();
		assertScreen("-1");
		_controller.addOperation(Operation.PLUS);
		assertScreen("-1");
		_controller.addSymbol("2");
		_controller.addSymbol("1");
		assertScreen("21");
		_controller.calculate();
		assertScreen("20");
	}
	
	@Test
	public function resetAll()
	{
		_controller.addSymbol("1");
		assertScreen("1");
		_log = [];
		_controller.resetAll();
		Assert.areEqual("0", _log.shift());
		assertScreen("0");
	}
	
	@Test
	public function backspace()
	{
		_controller.addSymbol("1");
		_controller.addSymbol("2");
		
		_log = [];
		_controller.backspace();
		Assert.areEqual("1", _log.shift());
		assertScreen("1");
		_controller.backspace();
		assertScreen("0");
		_controller.backspace();
		assertScreen("0");
	}
	
	@Test
	public function clearCurrent()
	{
		_controller.addSymbol("1");
		_log = [];
		_controller.clearCurrent();
		Assert.areEqual("0", _log.shift());
		assertScreen("0");
		
		_controller.addSymbol("2");
		_controller.addOperation(Operation.PLUS);
		_controller.addSymbol("3");
		_controller.clearCurrent();
		_controller.addSymbol("8");
		_controller.calculate();
		assertScreen("10");
	}
	
	@Test
	public function operationSequenceWithoutCalculationPressed()
	{
		_controller.addSymbol("1");
		_controller.addOperation(Operation.PLUS);
		_controller.addSymbol("2");
		_controller.addOperation(Operation.PLUS);
		assertScreen("3");
		_controller.addOperation(Operation.PLUS);
		assertScreen("3");
	}
	
	@Test
	public function writeSeveralZeroBeforeNumberIsImpossible()
	{
		_controller.addSymbol("0");
		_controller.addSymbol("0");
		_controller.addSymbol("0");
		assertScreen("0");
		_controller.addSymbol("1");
		assertScreen("1");
	}
	
	@Test
	public function secondPointCantBeWriten()
	{
		_controller.addSymbol("1");
		_controller.addSymbol(".");
		_controller.addSymbol("5");
		_controller.addSymbol(".");
		assertScreen("1.5");
	}
	
	@Test
	public function sumNumberWithItSelf()
	{
		_controller.addSymbol("1");
		_controller.addSymbol("2");
		_controller.addOperation(Operation.PLUS);
		_controller.calculate();
		assertScreen("24");
	}
	
	@Test
	public function otherCases()
	{
		_controller.addSymbol("1");
		_controller.addSymbol("2");
		_controller.addOperation(Operation.PLUS);
		assertScreen("12");
		_controller.addOperation(Operation.PLUS);
		_controller.addOperation(Operation.PLUS);
		_controller.addOperation(Operation.PLUS);
		assertScreen("12");
		_controller.calculate();
		assertScreen("24");
	}
	
	@Test
	public function ignoringCalculateIfOneArgumentOnly()
	{
		_controller.addSymbol("8");
		_controller.calculate();
		assertScreen("8");
		_controller.calculate();
		_controller.calculate();
		assertScreen("8");
	}
	
	@Test
	public function calculationChain()
	{
		_controller.addSymbol("5");
		_controller.addOperation(Operation.PLUS);
		_controller.addSymbol("10");
		_controller.calculate();
		assertScreen("15");
		_controller.calculate();
		assertScreen("25");
		_controller.calculate();
		assertScreen("35");
		_controller.calculate();
		assertScreen("45");
		_controller.addOperation(Operation.PLUS);
		_controller.addSymbol("55");
		_controller.calculate();
		assertScreen("100");
	}
}