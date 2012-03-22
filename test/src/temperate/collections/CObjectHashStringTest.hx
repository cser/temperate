package temperate.collections;

import flash.geom.Point;
import massive.munit.Assert;

class CObjectHashStringTest
{
	public function new()
	{
	}
	
	static var _point1:String = "point1";
	
	@Test
	public function string_getAndSet():Void
	{
		var hash = new CObjectHash<String, String>();
		hash.set("point1", "a");
		Assert.areEqual("a", hash.get(_point1));
	}
	
	@Test
	public function string_getAndSetSeveral():Void
	{
		var hash = new CObjectHash<String, String>();
		
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
		var hash = new CObjectHash<String, String>();
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
		var hash = new CObjectHash<Int, Int>(-1);
		
		Assert.areEqual( -1, hash.get(10));
		
		hash.set(10, 0);
		Assert.areEqual(0, hash.get(10));
		
		hash.set(10, 1);
		Assert.areEqual(1, hash.get(10));
		
		hash.delete(10);
		Assert.areEqual(-1, hash.get(10));
	}
	
	@Test
	public function string_exists():Void
	{
		var hash = new CObjectHash < Int, String > ("default");
		
		hash.set(0, "value");
		Assert.areEqual(true, hash.exists(0));
		Assert.areEqual("value", hash.get(0));
		
		hash.set(1, null);
		Assert.areEqual(true, hash.exists(1));
		Assert.areEqual(null, hash.get(1));
		
		hash.delete(1);
		Assert.areEqual(false, hash.exists(1));
		Assert.areEqual("default", hash.get(1));
	}
}