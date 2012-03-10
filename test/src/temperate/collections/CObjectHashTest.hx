package temperate.collections;

import massive.munit.Assert;
import flash.geom.Point;

class CObjectHashTest
{
	public function new()
	{
	}
	
	@Test
	public function getAndSet():Void
	{
		var hash = new CObjectHash<Point, String>();
		var point1 = new Point();
		hash.set(point1, "a");
		Assert.areEqual("a", hash.get(point1));
	}
	
	@Test
	public function getAndSetSeveral():Void
	{
		var hash = new CObjectHash<Point, String>();
		var point1 = new Point();
		var point2 = new Point();
		
		hash.set(point1, "a");
		Assert.areEqual("a", hash.get(point1));
		Assert.areEqual(null, hash.get(point2));
		
		hash.set(point2, "b");
		Assert.areEqual("a", hash.get(point1));
		Assert.areEqual("b", hash.get(point2));
	}
	
	@Test
	public function iterators():Void
	{
		var hash = new CObjectHash<Point, String>();
		var a = new Point();
		var b = new Point();
		var c = new Point();
		var d = new Point();
		hash.set(a, "a");
		hash.set(b, "b");
		hash.set(c, "c");
		hash.set(d, "d");
		ArrayAssert.equalToArrayIgnoringOrder([a, b, c, d], hash.keys());
		ArrayAssert.equalToArrayIgnoringOrder(["a", "b", "c", "d"], hash.values());
	}
	
	@Test
	public function defaultValue():Void
	{
		var hash = new CObjectHash<Point, Int>(-1);
		var a = new Point();
		
		Assert.areEqual( -1, hash.get(a));
		
		hash.set(a, 0);
		Assert.areEqual(0, hash.get(a));
		
		hash.set(a, 1);
		Assert.areEqual(1, hash.get(a));
		
		hash.delete(a);
		Assert.areEqual(-1, hash.get(a));
	}
	
	@Test
	public function defaultValueObjects():Void
	{
		var a = {};
		
		var hash = new CObjectHash<Dynamic, Int>(-1);
		Assert.areEqual( -1, hash.get(a));
		
		hash.set(a, 0);
		Assert.areEqual(0, hash.get(a));
		
		hash.set(a, 1);
		Assert.areEqual(1, hash.get(a));
		
		hash.delete(a);
		Assert.areEqual(-1, hash.get(a));
	}
	
	@Test
	public function exists():Void
	{
		var hash = new CObjectHash < Point, String > ("default");
		
		var point0 = new Point();
		hash.set(point0, "value");
		Assert.areEqual(true, hash.exists(point0));
		Assert.areEqual("value", hash.get(point0));
		
		var point1 = new Point();
		hash.set(point1, null);
		Assert.areEqual(true, hash.exists(point1));
		Assert.areEqual(null, hash.get(point1));
		
		hash.delete(point1);
		Assert.areEqual(false, hash.exists(point1));
		Assert.areEqual("default", hash.get(point1));
	}
}