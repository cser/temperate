package ;

import massive.munit.Assert;

class ArrayAssertTest
{
	public function new()
	{
	}
	
	var _assert: {
		private function checkEqualIgnoringOrder(
			expected:Array<Dynamic>, actual:Array<Dynamic>):String;
	};
	
	@Before
	public function setUp():Void
	{
		_assert = ArrayAssert;
	}
	
	@After
	public function tearDown():Void
	{
		
	}
	
	@Test
	public function cases()
	{
		Assert.isNull(_assert.checkEqualIgnoringOrder([], []));
		Assert.isNull(_assert.checkEqualIgnoringOrder(null, null));
		Assert.isNull(_assert.checkEqualIgnoringOrder([1], [1]));
		Assert.isNull(_assert.checkEqualIgnoringOrder([1, 2], [2, 1]));
		Assert.isNull(_assert.checkEqualIgnoringOrder([1, 2, 2], [2, 1, 2]));
		
		Assert.isNotNull(_assert.checkEqualIgnoringOrder([], null));
		Assert.isNotNull(_assert.checkEqualIgnoringOrder(null, []));
		Assert.isNotNull(_assert.checkEqualIgnoringOrder([], [1]));
		Assert.isNotNull(_assert.checkEqualIgnoringOrder([1, 2], [3, 2]));
		Assert.isNotNull(_assert.checkEqualIgnoringOrder([1, 2, 1], [2, 1, 2]));
	}
}