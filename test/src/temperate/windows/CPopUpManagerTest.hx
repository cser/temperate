package temperate.windows;

import flash.display.Sprite;
import flash.events.Event;
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
}