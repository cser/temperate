package temperate.windows;

import flash.display.Sprite;
import flash.errors.ArgumentError;
import flash.events.Event;
import flash.utils.RegExp;
import haxe.PosInfos;
import massive.munit.Assert;
using massive.munit.Assert;
using ArrayAssert;

class CPopUpManagerTest
{
	public function new()
	{
	}
	
	var _manager:CPopUpManager;
	var _container:Sprite;
	var _log:Array<String>;
	
	@Before
	public function setUp()
	{
		_log = [];
		_container = new Sprite();
		_manager = new CPopUpManager(_container);
		_manager.setArea(0, 0, 500, 400);
	}
	
	@Test
	public function addPopUp()
	{
		var popUp = new FakePopUp();
		_manager.add(popUp, false);
		popUp.view.parent.areEqual(_container);
	}
	
	@Test
	public function removePopUp()
	{
		var popUp = new FakePopUp();
		_manager.add(popUp, false);
		_manager.remove(popUp);
		popUp.view.parent.isNull();
	}
		
	@Test
	public function modalChanging()
	{
		var popUp = new FakePopUp();
		_manager.modal.isFalse();
		_manager.add(popUp, true);
		_manager.modal.isTrue();
		_manager.remove(popUp);
		_manager.modal.isFalse();
	}
	
	@Test
	public function changeEventDispatchedOnlyIfChangesExists()
	{
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
		
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
	public function isLockedChangeByUpperModalPopUp()
	{
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
		
		_manager.add(popUp0, false);
		_manager.add(popUp1, true);
		
		popUp0.isLocked.isTrue();
		popUp1.isLocked.isFalse();
		
		_manager.remove(popUp1);
		
		popUp0.isLocked.isFalse();
		popUp1.isLocked.isFalse();
	}
	
	@Test
	public function topPopUpIsNotLockedByBottomModalPopUp()
	{
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
		var popUp2 = new FakePopUp();
		
		_manager.add(popUp0, false);
		_manager.add(popUp1, true);
		_manager.add(popUp2, false);
		
		popUp0.isLocked.isTrue();
		popUp1.isLocked.isFalse();
		popUp2.isLocked.isFalse();
		
		var popUp3 = new FakePopUp();
		_manager.add(popUp3, true);
		popUp2.isLocked.isTrue();
		_manager.remove(popUp3);
		popUp2.isLocked.isFalse();
	}
	
	@Test
	public function onRemovePopUpOldLockedRecovery()
	{
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
		var popUp2 = new FakePopUp();
		
		_manager.add(popUp0, false);
		_manager.add(popUp1, true);
		_manager.add(popUp2, false);
		_manager.remove(popUp1);
		
		popUp0.isLocked.isFalse();
		popUp2.isLocked.isFalse();
	}
	
	@Test
	public function evenWindowGetsEventIfContainerSizeIsChanged()
	{
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
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
	public function oneAddedPopUpIsActive()
	{
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
		
		_manager.add(popUp0, false);
		popUp0.isActive.isTrue();
		
		_manager.remove(popUp0);
		
		_manager.add(popUp1, true);
		popUp1.isActive.isTrue();
	}
	
	@Test
	public function topPopUpIsActive()
	{
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
		
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
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
		
		_manager.add(popUp0, false);
		_manager.add(popUp0, true);
		
		_container.getChildAt(0).areEqual(popUp0.view);
		[popUp0].equalToArray(getPopUps());
		popUp0.isLocked.isFalse();
		
		_manager.add(popUp1, true);
		_container.getChildAt(0).areEqual(popUp0.view);
		_container.getChildAt(1).areEqual(popUp1.view);
		[popUp0, popUp1].equalToArray(getPopUps());
		popUp0.isLocked.isTrue();
		popUp1.isLocked.isFalse();
		
		_manager.add(popUp0, true);
		_container.getChildAt(0).areEqual(popUp1.view);
		_container.getChildAt(1).areEqual(popUp0.view);
		[popUp1, popUp0].equalToArray(getPopUps());
		popUp1.isLocked.isTrue();
		popUp0.isLocked.isFalse();
	}
	
	@Test
	public function repeatRemoving()
	{
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
		
		_manager.add(popUp0, false);
		_manager.remove(popUp0);
		_manager.remove(popUp0);
		
		_container.numChildren.areEqual(0);
		[].equalToArray(getPopUps());		
		
		_manager.add(popUp0, true);
		_manager.add(popUp1, true);
		_manager.remove(popUp1);
		_manager.remove(popUp1);
		_container.numChildren.areEqual(1);
		_container.getChildAt(0).areEqual(popUp0.view);
		[popUp0].equalToArray(getPopUps());
		popUp0.isLocked.isFalse();
	}
	
	@Test
	public function moteToTopForMissingPopUpIsThrowsError()
	{
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
		var popUp2 = new FakePopUp();
		
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
		[popUp0, popUp1].equalToArray(getPopUps());
		popUp0.isActive.isFalse();
		popUp1.isActive.isTrue();
	}
	
	@Test
	public function moveToTop()
	{
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
		var popUp2 = new FakePopUp();
		
		_manager.add(popUp0, true);
		_manager.add(popUp1, true);
		_manager.add(popUp2, true);
		
		_manager.moveToTop(popUp2);
		[popUp0, popUp1, popUp2].equalToArray(getPopUps());
		popUp0.isActive.isFalse();
		popUp1.isActive.isFalse();
		popUp2.isActive.isTrue();
		
		_manager.moveToTop(popUp1);
		[popUp0, popUp2, popUp1].equalToArray(getPopUps());
		popUp0.isActive.isFalse();
		popUp2.isActive.isFalse();
		popUp1.isActive.isTrue();
	}
	
	@Test
	public function moveTo()
	{
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
		var popUp2 = new FakePopUp();
		
		_manager.add(popUp0, true);
		_manager.add(popUp1, true);
		_manager.add(popUp2, true);
		
		_manager.moveTo(popUp1, 0);
		[popUp1, popUp0, popUp2].equalToArray(getPopUps());
		popUp1.isActive.isFalse();
		popUp0.isActive.isFalse();
		popUp2.isActive.isTrue();
		
		_manager.moveTo(popUp1, 2);
		[popUp0, popUp2, popUp1].equalToArray(getPopUps());
		popUp0.isActive.isFalse();
		popUp2.isActive.isFalse();
		popUp1.isActive.isTrue();
	}
	
	@Test
	public function popUpsIteration()
	{
		var popUp0 = new FakePopUp();
		var popUp1 = new FakePopUp();
		var popUp2 = new FakePopUp();
		
		0.areEqual(_manager.numPopUps);
		assertPopUpIteration([]);
		
		_manager.add(popUp0, true);
		1.areEqual(_manager.numPopUps);
		popUp0.areEqual(_manager.getPopUpAt(0));
		assertPopUpIteration([popUp0]);
		
		_manager.add(popUp1, true);
		_manager.add(popUp2, true);
		3.areEqual(_manager.numPopUps);
		popUp1.areEqual(_manager.getPopUpAt(1));
		popUp2.areEqual(_manager.getPopUpAt(2));
		assertPopUpIteration([popUp0, popUp1, popUp2]);
	}
	
	function assertPopUpIteration(expected:Array<Dynamic>, ?info:PosInfos)
	{
		var array = [];
		for (popUp in _manager)
		{
			array.push(popUp);
		}
		expected.equalToArray(array);
	}
	
	function getPopUps()
	{
		var array = [];
		for (popUp in _manager)
		{
			array.push(popUp);
		}
		return array;
	}
}