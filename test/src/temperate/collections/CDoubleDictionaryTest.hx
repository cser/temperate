package temperate.collections;

import massive.munit.Assert;

class CDoubleDictionaryTest
{
	public function new()
	{
	}
	
	@Test
	public function addCases()
	{
		var dictionary = new CDoubleDictionary<Int, Int>();
		
		dictionary.set(1, 2);
		
		Assert.areEqual(2, dictionary.getValue(1));
		Assert.areEqual(1, dictionary.getKey(2));
		Assert.areEqual(true, dictionary.existsKey(1));
		Assert.areEqual(false, dictionary.existsKey(2));
		Assert.areEqual(true, dictionary.existsValue(2));
		Assert.areEqual(false, dictionary.existsValue(1));
		
		dictionary.set(3, 5);
		
		Assert.areEqual(2, dictionary.getValue(1));
		Assert.areEqual(1, dictionary.getKey(2));
		Assert.areEqual(5, dictionary.getValue(3));
		Assert.areEqual(3, dictionary.getKey(5));
		Assert.areEqual(true, dictionary.existsKey(3));
		Assert.areEqual(false, dictionary.existsKey(5));
		Assert.areEqual(true, dictionary.existsValue(5));
		Assert.areEqual(false, dictionary.existsValue(3));
		
		ArrayAssert.equalToArrayIgnoringOrder([1, 3], dictionary.keys());
		ArrayAssert.equalToArrayIgnoringOrder([2, 5], dictionary.values());
	}
	
	@Test
	public function addStringCases()
	{
		var dictionary = new CDoubleDictionary<String, Int>();
		
		dictionary.set("abc", 2);
		
		Assert.areEqual(2, dictionary.getValue("abc"));
		Assert.areEqual("abc", dictionary.getKey(2));
		Assert.areEqual(true, dictionary.existsKey("abc"));
		Assert.areEqual(true, dictionary.existsValue(2));
		
		ArrayAssert.equalToArrayIgnoringOrder(["abc"], dictionary.keys());
		ArrayAssert.equalToArrayIgnoringOrder([2], dictionary.values());
	}
	
	@Test
	public function gettingMissingValuesCases()
	{
		var dictionary = new CDoubleDictionary<String, Int>();
		dictionary.set("a", 1);
		
		Assert.areEqual(1, dictionary.getValue("a"));
		Assert.areEqual(null, dictionary.getValue("b"));
		Assert.areEqual("a", dictionary.getKey(1));
		Assert.areEqual(null, dictionary.getKey(2));
	}
	
	@Test
	public function rewriteValuesCases()
	{
		var dictionary = new CDoubleDictionary<String, Int>();
		
		dictionary.set("a", 1);
		Assert.areEqual(1, dictionary.getValue("a"));
		Assert.areEqual("a", dictionary.getKey(1));
		
		dictionary.set("a", 2);
		Assert.areEqual(2, dictionary.getValue("a"));
		Assert.areEqual("a", dictionary.getKey(2));
		Assert.areEqual(null, dictionary.getKey(1));
		ArrayAssert.equalToArrayIgnoringOrder(["a"], dictionary.keys());
		ArrayAssert.equalToArrayIgnoringOrder([2], dictionary.values());
		
		dictionary.set("b", 2);
		Assert.areEqual(2, dictionary.getValue("b"));
		Assert.areEqual("b", dictionary.getKey(2));
		Assert.areEqual(null, dictionary.getValue("a"));
		ArrayAssert.equalToArrayIgnoringOrder(["b"], dictionary.keys());
		ArrayAssert.equalToArrayIgnoringOrder([2], dictionary.values());
	}
	
	@Test
	public function intersectiosInMonotypeDictionaryCases()
	{
		var dictionary = new CDoubleDictionary<Int, Int>();
		dictionary.set(0, 1);
		dictionary.set(1, 2);
		dictionary.set(2, 0);
		Assert.areEqual(1, dictionary.getValue(0));
		Assert.areEqual(2, dictionary.getValue(1));
		Assert.areEqual(0, dictionary.getValue(2));
		Assert.areEqual(2, dictionary.getKey(0));
		Assert.areEqual(0, dictionary.getKey(1));
		Assert.areEqual(1, dictionary.getKey(2));
	}
	
	@Test
	public function deleteCases()
	{
		var dictionary = new CDoubleDictionary<Int, String>();
		dictionary.set(0, "a");
		dictionary.set(1, "b");
		
		dictionary.deleteByKey(10);
		ArrayAssert.equalToArrayIgnoringOrder([0, 1], dictionary.keys());
		
		dictionary.deleteByValue("c");
		ArrayAssert.equalToArrayIgnoringOrder(["a", "b"], dictionary.values());
		
		dictionary.deleteByKey(0);
		Assert.areEqual(false, dictionary.existsKey(0));
		Assert.areEqual(true, dictionary.existsKey(1));
		Assert.areEqual(false, dictionary.existsValue("a"));
		Assert.areEqual(true, dictionary.existsValue("b"));
		
		dictionary.deleteByValue("b");
		Assert.areEqual(false, dictionary.existsKey(0));
		Assert.areEqual(false, dictionary.existsKey(1));
		Assert.areEqual(false, dictionary.existsValue("a"));
		Assert.areEqual(false, dictionary.existsValue("b"));
		ArrayAssert.equalToArrayIgnoringOrder([], dictionary.keys());
		ArrayAssert.equalToArrayIgnoringOrder([], dictionary.values());
	}
	
	@Test
	public function iterator()
	{
		var dictionary = new CDoubleDictionary<String, Int>();
		dictionary.set("a", 1);
		dictionary.set("b", 2);
		var keys = [];
		for (key in dictionary)
		{
			keys.push(key);
		}
		ArrayAssert.equalToArrayIgnoringOrder(["a", "b"], keys);
	}
}