package temperate.collections;

import flash.geom.Point;
import massive.munit.Assert;

class CObjectSetTest
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
	public function additionCases()
	{
		var a = new Point();
		var b = new Point();
		var set = new CObjectSet<Point>();
		Assert.areEqual(false, set.exists(a));
		set.add(a);
		Assert.areEqual(true, set.exists(a));
		Assert.areEqual(false, set.exists(b));
		set.add(b);
		Assert.areEqual(true, set.exists(a));
		Assert.areEqual(true, set.exists(b));
	}
	
	@Test
	public function removingCases()
	{
		var a = new Point();
		var b = new Point();
		var set = new CObjectSet<Point>();
		set.add(a);
		set.add(b);
		set.delete(a);
		Assert.areEqual(false, set.exists(a));
		Assert.areEqual(true, set.exists(b));
		set.delete(b);
		Assert.areEqual(false, set.exists(a));
		Assert.areEqual(false, set.exists(b));
	}
	
	@Test
	public function iteration()
	{
		var a = new Point();
		var b = new Point();
		var set = new CObjectSet<Point>();
		
		ArrayAssert.equalToArrayIgnoringOrder([], set.values());
		
		set.add(a);
		ArrayAssert.equalToArrayIgnoringOrder([a], set.values());
		
		set.add(b);
		ArrayAssert.equalToArrayIgnoringOrder([a, b], set.values());
		
		set.add(b);
		ArrayAssert.equalToArrayIgnoringOrder([a, b], set.values());
		
		set.delete(a);
		ArrayAssert.equalToArrayIgnoringOrder([b], set.values());
		
		set.delete(b);
		ArrayAssert.equalToArrayIgnoringOrder([], set.values());
		
		set.delete(b);
		ArrayAssert.equalToArrayIgnoringOrder([], set.values());
	}
}