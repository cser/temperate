package temperate.collections;

import flash.geom.Point;
import massive.munit.Assert;

class CHashTest
{
	public function new()
	{
	}
	
	@Test
	public function getAndSet():Void
	{
		var hash = new CHash<Point, String>();
		var point1 = new Point();
		hash.set(point1, "a");
		Assert.areEqual("a", hash.get(point1));
	}
	
	@Test
	public function getAndSetSeveral():Void
	{
		var hash = new CHash<Point, String>();
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
		var hash = new CHash<Point, String>();
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
		var hash = new CHash<Point, Int>(-1);
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
		
		var hash = new CHash<Dynamic, Int>(-1);
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
		var hash = new CHash < Point, String > ("default");
		
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
	
	//----------------------------------------------------------------------------------------------
	//
	//  String keys
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function string_getAndSet():Void
	{
		var hash = new CHash<String, String>();
		hash.set("point1", "a");
		Assert.areEqual("a", hash.get("point1"));
	}
	
	@Test
	public function string_getAndSetSeveral():Void
	{
		var hash = new CHash<String, String>();
		
		hash.set("point1", "a");
		Assert.areEqual("a", hash.get("point1"));
		Assert.areEqual(null, hash.get("point2"));
		
		hash.set("point2", "b");
		Assert.areEqual("a", hash.get("point1"));
		Assert.areEqual("b", hash.get("point2"));
	}
	
	@Test
	public function string_iterators():Void
	{
		var hash = new CHash<String, String>();
		hash.set("akey", "a");
		hash.set("bkey", "b");
		hash.set("ckey", "c");
		hash.set("dkey", "d");
		ArrayAssert.equalToArrayIgnoringOrder(["akey", "bkey", "ckey", "dkey"], hash.keys());
		ArrayAssert.equalToArrayIgnoringOrder(["a", "b", "c", "d"], hash.values());
	}
	
	@Test
	public function string_defaultValue():Void
	{
		var hash = new CHash<String, Int>(-1);
		
		Assert.areEqual( -1, hash.get("a"));
		
		hash.set("a", 0);
		Assert.areEqual(0, hash.get("a"));
		
		hash.set("a", 1);
		Assert.areEqual(1, hash.get("a"));
		
		hash.delete("a");
		Assert.areEqual(-1, hash.get("a"));
	}
	
	@Test
	public function string_exists():Void
	{
		var hash = new CHash < String, String > ("default");
		
		hash.set("point0", "value");
		Assert.areEqual(true, hash.exists("point0"));
		Assert.areEqual("value", hash.get("point0"));
		
		hash.set("point1", null);
		Assert.areEqual(true, hash.exists("point1"));
		Assert.areEqual(null, hash.get("point1"));
		
		hash.delete("point1");
		Assert.areEqual(false, hash.exists("point1"));
		Assert.areEqual("default", hash.get("point1"));
	}
}