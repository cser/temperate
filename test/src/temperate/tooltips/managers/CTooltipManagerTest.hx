package temperate.tooltips.managers;

import flash.utils.Timer;
import massive.munit.Assert;

class CTooltipManagerTest
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
	public function tooltipsShowingsWithoutDelay()
	{
		var manager = new CTooltipManager();
		manager.showDelay = 0;
		manager.hideDelay = 0;
		manager.secondShowDelay = 0;
		manager.secondShowTimeout = 0;
		
		var tooltiper = new FakeTooltiper();
		manager.show(tooltiper);
		ArrayAssert.areEqual(["show"], tooltiper.log);
		manager.hide(tooltiper);
		ArrayAssert.areEqual(["show", "hide"], tooltiper.log);
		
		tooltiper.log = [];
		
		var tooltiper2 = new FakeTooltiper();
		manager.show(tooltiper2);
		ArrayAssert.areEqual(["show"], tooltiper2.log);
		
		manager.show(tooltiper);
		ArrayAssert.areEqual(["show", "hide"], tooltiper2.log);
		ArrayAssert.areEqual(["show"], tooltiper.log);
	}
	
	@Test
	public function firstOpenDelayed_at_showDelay()
	{
		var manager = new ExtendedTooltipManager();
		manager.showDelay = 8;
		manager.hideDelay = 0;
		manager.secondShowDelay = 0;
		manager.secondShowTimeout = 0;
		
		var tooltiper = new FakeTooltiper();
		manager.show(tooltiper);
		ArrayAssert.areEqual([], tooltiper.log);
		manager.factory.currentTime += 7;
		ArrayAssert.areEqual([], tooltiper.log);
		manager.factory.currentTime += 1;
		ArrayAssert.areEqual(["show"], tooltiper.log);
		manager.factory.currentTime += 1;
		ArrayAssert.areEqual(["show"], tooltiper.log);
	}
	
	@Test
	public function hideWithDelay()
	{
		var manager = new ExtendedTooltipManager();
		manager.showDelay = 0;
		manager.hideDelay = 8;
		manager.secondShowDelay = 0;
		manager.secondShowTimeout = 0;
		
		var tooltiper = new FakeTooltiper();
		manager.show(tooltiper);
		ArrayAssert.areEqual(["show"], tooltiper.log);
		manager.hide(tooltiper);
		ArrayAssert.areEqual(["show"], tooltiper.log);
		manager.factory.currentTime += 7;
		ArrayAssert.areEqual(["show"], tooltiper.log);
		manager.factory.currentTime += 1;
		ArrayAssert.areEqual(["show", "hide"], tooltiper.log);
		manager.factory.currentTime += 20;
		ArrayAssert.areEqual(["show", "hide"], tooltiper.log);
	}
	
	
	//@Test Not realized
	public function secondShowWithDelay()
	{
		var manager = new ExtendedTooltipManager();
		manager.showDelay = 8;
		manager.hideDelay = 2;
		manager.secondShowDelay = 5;
		manager.secondShowTimeout = 10;
		
		var tooltiper = new FakeTooltiper();
		
		manager.show(tooltiper);
		manager.factory.currentTime += 7;
		ArrayAssert.areEqual([], tooltiper.log);
		manager.factory.currentTime += 1;
		ArrayAssert.areEqual(["show"], tooltiper.log);
		
		var tooltiper2 = new FakeTooltiper();
		
		manager.hide(tooltiper);
		manager.show(tooltiper2);
		manager.factory.currentTime += 1;
		ArrayAssert.areEqual([], tooltiper2.log);
		ArrayAssert.areEqual(["show"], tooltiper.log);
		manager.factory.currentTime += 1;
		ArrayAssert.areEqual([], tooltiper2.log);
		ArrayAssert.areEqual(["show", "hide"], tooltiper.log);
		manager.factory.currentTime += 2;
		ArrayAssert.areEqual([], tooltiper2.log);
		ArrayAssert.areEqual(["show", "hide"], tooltiper.log);
		manager.factory.currentTime += 1;
		ArrayAssert.areEqual(["show"], tooltiper2.log);
		ArrayAssert.areEqual(["show", "hide"], tooltiper.log);
	}
}

class ExtendedTooltipManager extends CTooltipManager
{
	public function new()
	{
		factory = new FakeTimerFactory();
		super();
	}
	
	override function newTimer():Timer
	{
		return factory.newTimer(1, 1);
	}
	
	public var factory(default, null):FakeTimerFactory;
}

import temperate.tooltips.tooltipers.ICTooltiper;
class FakeTooltiper implements ICTooltiper
{
	public var log:Array<String>;
	
	public function new()
	{
		log = [];
	}
	
	public function internalShow(fast:Bool)
	{
		log.push("show");
	}
	
	public function internalHide(fast:Bool)
	{
		log.push("hide");
	}
	
	public var showDelay:Null<Int>;
	
	public var secondShowDelay:Null<Int>;
	
	public var hideDelay:Null<Int>;
	
	public var secondShowTimeout:Null<Int>;
}