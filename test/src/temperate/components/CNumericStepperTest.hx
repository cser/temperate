package temperate.components;

import flash.events.Event;
import massive.munit.Assert;
import temperate.skins.CRaster9GridRectSkin;

class CNumericStepperTest
{
	public function new()
	{
	}
	
	@Before
	public function setUp():Void
	{
	}
	
	@After
	public function tearDown():Void
	{
	}
	
	@Test
	public function dontDispatchChangeDuringInstantination()
	{
		var stepper = new ExtendedTestNumericStepper();
		ArrayAssert.equalToArray([], stepper.eventLog);
		
		stepper.validate();
		ArrayAssert.equalToArray([], stepper.eventLog);
	}
	
	@Test
	public function dontDispatchChangeIfEqualValueSetted()
	{
		var stepper = new ExtendedTestNumericStepper();
		Assert.areEqual(0, stepper.value);
		stepper.value = 0;
		ArrayAssert.equalToArray([], stepper.eventLog);
		
		stepper.value = 1;
		stepper.eventLog = [];
		stepper.value = 1;
		ArrayAssert.equalToArray([], stepper.eventLog);
	}
	
	@Test
	public function dispatchChangeIfNewValueSetted()
	{
		var stepper = new ExtendedTestNumericStepper();
		Assert.areEqual(0, stepper.value);
		stepper.value = 1;
		ArrayAssert.equalToArray([ Event.CHANGE ], stepper.eventLog);
		
		stepper.eventLog = [];
		stepper.value = 0;
		ArrayAssert.equalToArray([ Event.CHANGE ], stepper.eventLog);
	}
	
	@Test
	public function ifOutOfRangeValueSetted_setBoundariesValues()
	{
		var stepper = new ExtendedTestNumericStepper();
		stepper.minValue = -20;
		stepper.maxValue = 10;
		Assert.areEqual(0, stepper.value);
		
		stepper.eventLog = [];
		stepper.value = 11;
		Assert.areEqual(10, stepper.value);
		ArrayAssert.equalToArray([ Event.CHANGE ], stepper.eventLog);
		
		stepper.eventLog = [];
		stepper.value = 12;
		Assert.areEqual(10, stepper.value);
		ArrayAssert.equalToArray([], stepper.eventLog);
		
		stepper.eventLog = [];
		stepper.value = -21;
		Assert.areEqual( -20, stepper.value);
		ArrayAssert.equalToArray([ Event.CHANGE ], stepper.eventLog);
		
		stepper.eventLog = [];
		stepper.value = -22;
		Assert.areEqual( -20, stepper.value);
		ArrayAssert.equalToArray([], stepper.eventLog);
	}
	
	@Test
	public function boundariesValuesSettingChangeValueIfNeed()
	{
		var stepper = new ExtendedTestNumericStepper();
		stepper.minValue = 0;
		stepper.maxValue = 100;
		Assert.areEqual(0, stepper.value);
		
		stepper.eventLog = [];
		stepper.minValue = 1;
		Assert.areEqual(1, stepper.value);
		ArrayAssert.equalToArray([ Event.CHANGE ], stepper.eventLog);
		
		stepper.value = 50;
		stepper.eventLog = [];
		stepper.maxValue = 49;
		Assert.areEqual(49, stepper.value);
		ArrayAssert.equalToArray([ Event.CHANGE ], stepper.eventLog);
	}
	
	@Test
	public function changeMinValueIsNotChangeMaxValueAndViceVersa()
	{
		var stepper = new ExtendedTestNumericStepper();
		stepper.minValue = 0;
		stepper.maxValue = 100;
		Assert.areEqual(0, stepper.value);
		
		stepper.minValue = 200;
		stepper.minValue = 50;
		Assert.areEqual(100, stepper.maxValue);
		
		stepper.maxValue = -100;
		stepper.maxValue = 100;
		Assert.areEqual(50, stepper.minValue);
	}
	
	@Test
	public function cantSetValueOutOfBoundaries()
	{
		var stepper = new ExtendedTestNumericStepper();
		stepper.minValue = 0;
		stepper.maxValue = 100;
		Assert.areEqual(0, stepper.value);
		
		stepper.value = 100;
		Assert.areEqual(100, stepper.value);
		
		stepper.value = 101;
		Assert.areEqual(100, stepper.value);
		
		stepper.value = 0;
		Assert.areEqual(0, stepper.value);
		
		stepper.value = -1;
		Assert.areEqual(0, stepper.value);
	}
}

class ExtendedTestNumericStepper extends CNumericStepper
{
	public function new()
	{
		eventLog = [];
		addEventListener(Event.CHANGE, onChange);
		super(new FakeEmptyButton(), new FakeEmptyButton(), new CRaster9GridRectSkin());
	}
	
	public var eventLog:Array<String>;
	
	function onChange(event:Event)
	{
		eventLog.push(event.type);
	}
}