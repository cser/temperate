package temperate.windows;

import flash.display.Sprite;
import flash.errors.ArgumentError;
import flash.events.Event;
import haxe.PosInfos;
import massive.munit.Assert;
using massive.munit.Assert;
using ArrayAssert;

class CWindowManagerTest
{
	public function new()
	{
	}
	
	var _manager:CWindowManager;
	var _container:Sprite;
	var _log:Array<String>;
	
	@Before
	public function setUp()
	{
		_log = [];
		_container = new Sprite();
		_manager = new CWindowManager(_container);
		_manager.setArea(0, 0, 500, 400);
	}
	
	@Test
	public function addWindow()
	{
		var popUp = new FakeWindow();
		_manager.add(popUp, false);
		popUp.view.parent.areEqual(_container);
	}
	
	@Test
	public function removeWindow()
	{
		var popUp = new FakeWindow();
		_manager.add(popUp, false);
		_manager.remove(popUp);
		popUp.view.parent.isNull();
	}
		
	@Test
	public function modalChanging()
	{
		var popUp = new FakeWindow();
		_manager.modal.isFalse();
		_manager.add(popUp, true);
		_manager.modal.isTrue();
		_manager.remove(popUp);
		_manager.modal.isFalse();
	}
	
	@Test
	public function changeEventDispatchedOnlyIfChangesExists()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		
		_log = [];
		
		_manager.addEventListener(Event.CHANGE, onChange);
		_manager.add(popUp0, true);
		_manager.remove(popUp0);
		
		["onChange/true", "onChange/false"].equalToArray(_log);
		
		_log = [];
		_manager.add(popUp0, false);
		_manager.add(popUp1, false);
		
		[].equalToArray(_log);
	}
	
	function onChange(event:Event)
	{
		_log.push("onChange/" + _manager.modal);
	}
	
	@Test
	public function isLockedChangeByUpperModalWindow()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		
		_manager.add(popUp0, false);
		_manager.add(popUp1, true);
		
		popUp0.isEnabled.isFalse();
		popUp1.isEnabled.isTrue();
		
		_manager.remove(popUp1);
		
		popUp0.isEnabled.isTrue();
		popUp1.isEnabled.isTrue();
	}
	
	@Test
	public function topWindowIsNotLockedByBottomModalWindow()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		var popUp2 = new FakeWindow();
		
		_manager.add(popUp0, false);
		_manager.add(popUp1, true);
		_manager.add(popUp2, false);
		
		popUp0.isEnabled.isFalse();
		popUp1.isEnabled.isTrue();
		popUp2.isEnabled.isTrue();
		
		var popUp3 = new FakeWindow();
		_manager.add(popUp3, true);
		popUp2.isEnabled.isFalse();
		_manager.remove(popUp3);
		popUp2.isEnabled.isTrue();
	}
	
	@Test
	public function onRemoveWindowOldLockedRecovery()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		var popUp2 = new FakeWindow();
		
		_manager.add(popUp0, false);
		_manager.add(popUp1, true);
		_manager.add(popUp2, false);
		_manager.remove(popUp1);
		
		popUp0.isEnabled.isTrue();
		popUp2.isEnabled.isTrue();
	}
	
	@Test
	public function evenWindowGetsEventIfContainerSizeIsChanged()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		popUp0.innerDispatcher.addEventListener(Event.RESIZE, onResize0);
		popUp1.innerDispatcher.addEventListener(Event.RESIZE, onResize1);
		
		_manager.add(popUp0, false);
		_manager.add(popUp1, true);
		
		[].equalToArray(_log);
		_manager.setArea(0, 0, 100, 150);
		["onResize0", "onResize1"].equalToArray(_log);
		
		_log = [];
		_manager.setArea(0, 0, 100, 150);
		[].equalToArray(_log);
	}
	
	function onResize0(event:Event)
	{
		_log.push("onResize0");
	}
	
	function onResize1(event:Event)
	{
		_log.push("onResize1");
	}
	
	@Test
	public function oneAddedWindowIsActive()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		
		_manager.add(popUp0, false);
		popUp0.isActive.isTrue();
		
		_manager.remove(popUp0);
		
		_manager.add(popUp1, true);
		popUp1.isActive.isTrue();
	}
	
	@Test
	public function topWindowIsActive()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		
		_manager.add(popUp0, false);
		_manager.add(popUp1, false);
		popUp0.isActive.isFalse();
		popUp1.isActive.isTrue();
		
		_manager.remove(popUp0);
		popUp1.isActive.isTrue();
		
		_manager.add(popUp0, false);
		popUp1.isActive.isFalse();
		popUp0.isActive.isTrue();
	}
	
	@Test
	public function repeatAddition()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		
		_manager.add(popUp0, false);
		_manager.add(popUp0, true);
		
		_container.getChildAt(0).areEqual(popUp0.view);
		[popUp0].equalToArray(getWindows());
		popUp0.isEnabled.isTrue();
		
		_manager.add(popUp1, true);
		_container.getChildAt(0).areEqual(popUp0.view);
		_container.getChildAt(1).areEqual(popUp1.view);
		[popUp0, popUp1].equalToArray(getWindows());
		popUp0.isEnabled.isFalse();
		popUp1.isEnabled.isTrue();
		
		_manager.add(popUp0, true);
		_container.getChildAt(0).areEqual(popUp1.view);
		_container.getChildAt(1).areEqual(popUp0.view);
		[popUp1, popUp0].equalToArray(getWindows());
		popUp1.isEnabled.isFalse();
		popUp0.isEnabled.isTrue();
	}
	
	@Test
	public function repeatRemoving()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		
		_manager.add(popUp0, false);
		_manager.remove(popUp0);
		_manager.remove(popUp0);
		
		_container.numChildren.areEqual(0);
		[].equalToArray(getWindows());		
		
		_manager.add(popUp0, true);
		_manager.add(popUp1, true);
		_manager.remove(popUp1);
		_manager.remove(popUp1);
		_container.numChildren.areEqual(1);
		_container.getChildAt(0).areEqual(popUp0.view);
		[popUp0].equalToArray(getWindows());
		popUp0.isEnabled.isTrue();
	}
	
	@Test
	public function moteToTopForMissingWindowIsThrowsError()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		var popUp2 = new FakeWindow();
		
		_manager.add(popUp0, true);
		_manager.add(popUp1, true);
		try
		{
			_manager.moveToTop(popUp2);
			"Mast throws error".fail();
		}
		catch (error:ArgumentError)
		{
		}
		[popUp0, popUp1].equalToArray(getWindows());
		popUp0.isActive.isFalse();
		popUp1.isActive.isTrue();
	}
	
	@Test
	public function moveToTop()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		var popUp2 = new FakeWindow();
		
		_manager.add(popUp0, true);
		_manager.add(popUp1, true);
		_manager.add(popUp2, true);
		
		_manager.moveToTop(popUp2);
		[popUp0, popUp1, popUp2].equalToArray(getWindows());
		popUp0.isActive.isFalse();
		popUp1.isActive.isFalse();
		popUp2.isActive.isTrue();
		
		_manager.moveToTop(popUp1);
		[popUp0, popUp2, popUp1].equalToArray(getWindows());
		popUp0.isActive.isFalse();
		popUp2.isActive.isFalse();
		popUp1.isActive.isTrue();
	}
	
	@Test
	public function moveTo()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		var popUp2 = new FakeWindow();
		
		_manager.add(popUp0, true);
		_manager.add(popUp1, true);
		_manager.add(popUp2, true);
		
		_manager.moveTo(popUp1, 0);
		[popUp1, popUp0, popUp2].equalToArray(getWindows());
		popUp1.isActive.isFalse();
		popUp0.isActive.isFalse();
		popUp2.isActive.isTrue();
		
		_manager.moveTo(popUp1, 2);
		[popUp0, popUp2, popUp1].equalToArray(getWindows());
		popUp0.isActive.isFalse();
		popUp2.isActive.isFalse();
		popUp1.isActive.isTrue();
	}
	
	@Test
	public function popUpsIteration()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		var popUp2 = new FakeWindow();
		
		0.areEqual(_manager.numWindows);
		assertWindowIteration([]);
		
		_manager.add(popUp0, true);
		1.areEqual(_manager.numWindows);
		Assert.isTrue(popUp0 == _manager.getWindowAt(0));
		assertWindowIteration([popUp0]);
		
		_manager.add(popUp1, true);
		_manager.add(popUp2, true);
		3.areEqual(_manager.numWindows);
		Assert.isTrue(popUp1 == _manager.getWindowAt(1));
		Assert.isTrue(popUp2 == _manager.getWindowAt(2));
		assertWindowIteration([popUp0, popUp1, popUp2]);
	}
	
	function assertWindowIteration(expected:Array<Dynamic>, ?info:PosInfos)
	{
		expected.equalToArray(getWindows());
	}
	
	function getWindows()
	{
		var array = [];
		for (popUp in _manager)
		{
			array.push(popUp);
		}
		return array;
	}
	
	@Test
	public function topWindowChange()
	{
		var popUp0 = new FakeWindow();
		var popUp1 = new FakeWindow();
		_manager.addEventListener(Event.SELECT, onManagerSelect);
		
		Assert.areEqual(null, _manager.topWindow);
		
		_log = [];
		_manager.add(popUp0, false);
		Assert.isTrue(popUp0 == _manager.topWindow);
		ArrayAssert.equalToArray([Event.SELECT], _log);
		
		_log = [];
		_manager.remove(popUp0);
		Assert.isNull(_manager.topWindow);
		ArrayAssert.equalToArray([Event.SELECT], _log);
		
		_log = [];
		_manager.add(popUp0, false);
		_manager.add(popUp1, false);
		Assert.isTrue(popUp1 == _manager.topWindow);
	}
	
	function onManagerSelect(event:Event)
	{
		_log.push(event.type);
	}
}