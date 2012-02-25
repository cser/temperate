package temperate.core;

import massive.munit.Assert;

class CValidatorTest
{
	public function new()
	{
	}
	
	private var _validator:TestValidator;
	
	@Before
	public function setUp():Void
	{
		_validator = new TestValidator();
	}
	
	@After
	public function tearDown():Void
	{
		
	}
}