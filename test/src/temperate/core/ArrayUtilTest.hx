package temperate.core;

import massive.munit.Assert;

class ArrayUtilTest
{
	public function new()
	{
	}
	
	@Test
	public function exists()
	{
		Assert.areEqual(true, ArrayUtil.exists(["a", "b"], "a"));
		Assert.areEqual(false, ArrayUtil.exists(["a", "b"], "c"));
		Assert.areEqual(true, ArrayUtil.exists(["a", "a"], "a"));
	}
	
}