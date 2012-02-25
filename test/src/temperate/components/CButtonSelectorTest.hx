package temperate.components;

import flash.events.Event;
import flash.events.MouseEvent;
import massive.munit.Assert;

class CButtonSelectorTest
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
	
	var _switcher:CButtonSelector<Int>;
	var _button1:ACButton;
	var _button2:ACButton;
	
	@Test
	public function oneButtonSelectedAfterClickOnIt_andChangeEventDispatched()
	{
		_switcher = new CButtonSelector(0);
		_switcher.addEventListener(Event.CHANGE, test1_onSwitcherChange);
		
		_button1 = new FakeEmptyButton();
		_button2 = new FakeEmptyButton();
		_switcher.add(_button1, 1);
		_switcher.add(_button2, 2);
		Assert.areEqual(0, _switcher.value);
		
		_button2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		
		Assert.areEqual(2, _switcher.value);
		Assert.areEqual(false, _button1.selected);
		Assert.areEqual(true, _button2.selected);
		ArrayAssert.equalToArray([ "change" ], _log);
	}
	
	function test1_onSwitcherChange(event:Event)
	{
		Assert.areEqual(2, _switcher.value);
		Assert.areEqual(false, _button1.selected);
		Assert.areEqual(true, _button2.selected);
		_log.push("change");
	}
	
	@Test
	public function ifUseMouseDownSetted_switchingMakeOnlyByThisEvent_elseOnlyByClick()
	{
		_switcher = new CButtonSelector(0, true);
		_switcher.addEventListener(Event.CHANGE, default_onSwitchChange);
		
		_button1 = new FakeEmptyButton();
		_button2 = new FakeEmptyButton();
		_switcher.add(_button1, 1);
		_switcher.add(_button2, 2);
		Assert.areEqual(0, _switcher.value);
		
		_button2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		Assert.areEqual(0, _switcher.value);
		ArrayAssert.equalToArray([], _log);
		
		_button2.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
		Assert.areEqual(2, _switcher.value);
		ArrayAssert.equalToArray(["change"], _log);
		
		_log = [];
		_switcher = new CButtonSelector(0);
		_switcher.addEventListener(Event.CHANGE, default_onSwitchChange);
		
		_button1 = new FakeEmptyButton();
		_button2 = new FakeEmptyButton();
		_switcher.add(_button1, 1);
		_switcher.add(_button2, 2);
		Assert.areEqual(0, _switcher.value);
		
		_button2.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
		Assert.areEqual(0, _switcher.value);
		ArrayAssert.equalToArray([], _log);
		
		_button2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		Assert.areEqual(2, _switcher.value);
		ArrayAssert.equalToArray(["change"], _log);
	}
	
	function default_onSwitchChange(event:Event)
	{
		_log.push("change");
	}
	
	@Test
	public function ifNoButtonsAndValueNotSetted_itsEqualTo_firstIngectedToConstructorValue()
	{
		var switcher = new CButtonSelector<Int>(0);
		Assert.areEqual(0, switcher.value);
		Assert.areEqual("0", Std.string(switcher.value));
		
		var switcher = new CButtonSelector<Float>(0);
		Assert.areEqual(0, switcher.value);
		Assert.areEqual("0", Std.string(switcher.value));
		
		var switcher = new CButtonSelector<String>(null);
		Assert.areEqual(null, switcher.value);
		Assert.areEqual("null", Std.string(switcher.value));
	}
	
	@Test
	public function ifAddedButtonValue_areEqualTo_firstValue_buttonIsSelected()
	{
		{
			var switcher = new CButtonSelector<String>(null);
			Assert.areEqual(null, switcher.value);
			
			var button = new FakeEmptyButton();
			Assert.areEqual(false, button.selected);
			
			switcher.add(button, null);
			
			Assert.areEqual(true, button.selected);
		}
		
		{
			var switcher = new CButtonSelector<Int>(0);
			Assert.areEqual(0, switcher.value);
			
			var button = new FakeEmptyButton();
			Assert.areEqual(false, button.selected);
			
			switcher.add(button, 0);
			
			Assert.areEqual(true, button.selected);
		}
	}
	
	@Test
	public function atFirst_valueSettedByConstructorParameter()
	{
		var switcher = new CButtonSelector<Int>(10);
		Assert.areEqual(10, switcher.value);
		
		var switcher = new CButtonSelector<String>("Text");
		Assert.areEqual("Text", switcher.value);
		
		var object = { };
		var switcher = new CButtonSelector(object);
		Assert.areEqual(object, switcher.value);
	}
	
	@Test
	public function onValueSetted_selectButtonWithEqualsValue_and_changeEventDispatched()
	{
		var switcher = new CButtonSelector(0);
		switcher.addEventListener(Event.CHANGE, default_onSwitchChange);
		
		var button1 = new FakeEmptyButton();
		var button2 = new FakeEmptyButton();
		switcher.add(button1, 1);
		switcher.add(button2, 2);
		Assert.areEqual(false, button1.selected);
		Assert.areEqual(false, button2.selected);
		ArrayAssert.equalToArray([], _log);
		
		switcher.value = 1;
		
		ArrayAssert.equalToArray(["change"], _log);
		Assert.areEqual(true, button1.selected);
		Assert.areEqual(false, button2.selected);
		
		_log = [];
		
		switcher.value = 2;
		
		ArrayAssert.equalToArray(["change"], _log);
		Assert.areEqual(false, button1.selected);
		Assert.areEqual(true, button2.selected);
	}
	
	@Test
	public function isNoButtonWithValue_selectionRemovesFromAllButtons()
	{
		var switcher = new CButtonSelector(1);
		var button1 = new FakeEmptyButton();
		var button2 = new FakeEmptyButton();
		switcher.add(button1, 1);
		switcher.add(button2, 2);
		Assert.areEqual(true, button1.selected);
		Assert.areEqual(false, button2.selected);
		
		switcher.value = 0;
		
		Assert.areEqual(false, button1.selected);
		Assert.areEqual(false, button2.selected);
	}
	
	@Test
	public function buttonAdditonIsNotChangeValue()
	{
		var switcher = new CButtonSelector(0);
		Assert.areEqual(0, switcher.value);
		
		var button1 = new FakeEmptyButton();
		var button2 = new FakeEmptyButton();
		
		switcher.add(button1, 1);
		Assert.areEqual(0, switcher.value);
		
		switcher.add(button2, 2);
		Assert.areEqual(0, switcher.value);
	}
	
	@Test
	public function ifButtonRemoved_clickIt_isNotChangeValue_andEventsIsNotDispatched()
	{
		var switcher = new CButtonSelector(0);
		switcher.addEventListener(Event.CHANGE, default_onSwitchChange);
		
		var button1 = new FakeEmptyButton();
		var button2 = new FakeEmptyButton();
		switcher.add(button1, 1);
		switcher.add(button2, 2);
		
		switcher.remove(button1);
		
		button1.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		ArrayAssert.equalToArray([], _log);
	}
	
	@Test
	public function ifButtonRemoved_itsSelectionIsNotChangeWhenSwitchValueChanged()
	{
		var switcher = new CButtonSelector(0);
		
		var button1 = new FakeEmptyButton();
		var button2 = new FakeEmptyButton();
		switcher.add(button1, 1);
		switcher.add(button2, 2);
		
		switcher.remove(button1);
		button1.selected = false;
		switcher.value = 1;
		
		Assert.areEqual(false, button1.selected);
	}
	
	@Test
	public function if_button_withEqualsToSelectedValue_removed_valueIsNotChanged()
	{
		var switcher = new CButtonSelector(0);
		var button1 = new FakeEmptyButton();
		var button2 = new FakeEmptyButton();
		switcher.add(button1, 10);
		switcher.add(button2, 1);
		switcher.value = 10;
		
		switcher.remove(button2);
		Assert.areEqual(10, switcher.value);
	}
	
	@Test
	public function ifEqualsValueSetted_changeEventIsNotDispatched()
	{
		var switcher = new CButtonSelector(10);
		switcher.addEventListener(Event.CHANGE, default_onSwitchChange);
		
		switcher.value = 10;
		
		ArrayAssert.equalToArray([], _log);
	}
	
	@Test
	public function ifEqualsValueSettedByButtonClick_changeEventIsNotDispatchedToo()
	{
		var switcher = new CButtonSelector(10);
		switcher.addEventListener(Event.CHANGE, default_onSwitchChange);
		
		var button = new FakeEmptyButton();
		switcher.add(button, 10);
		
		button.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		
		ArrayAssert.equalToArray([], _log);
	}
	
	@Test
	public function ifAddedSelectedButtonWithAnotherValue_selectionRemoves()
	{
		var switcher = new CButtonSelector(101);
		var button = new FakeEmptyButton();
		button.selected = true;
		Assert.areEqual(true, button.selected);
		
		switcher.add(button, 123);
		
		Assert.areEqual(false, button.selected);
	}
	
	@Test
	public function ifAddedButtonWithEqualsValue_itsSelected()
	{
		var switcher = new CButtonSelector(101);
		var button = new FakeEmptyButton();
		Assert.areEqual(false, button.selected);
		
		switcher.add(button, 101);
		
		Assert.areEqual(true, button.selected);
	}
	
	@Test
	public function ifButtonsWithEqualsValuesExist_whileThisValueSelected_theyAllSelected()
	{
		var switcher = new CButtonSelector(0);
		var button1 = new FakeEmptyButton();
		var button2 = new FakeEmptyButton();
		var button3 = new FakeEmptyButton();
		switcher.add(button1, 1);
		switcher.add(button2, 2);
		switcher.add(button3, 1);
		
		switcher.value = 1;
		
		Assert.areEqual(true, button1.selected);
		Assert.areEqual(false, button2.selected);
		Assert.areEqual(true, button3.selected);
	}
}