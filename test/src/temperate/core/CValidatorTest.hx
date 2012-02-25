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
	
	private function newSprite(name:String):FakeSprite
	{
		return new FakeSprite(name, _validator);
	}
	
	@Test
	public function postponedSizeIsValidated():Void
	{
		var sprite0 = newSprite("0");
		_validator.postponeSize(sprite0);
		ArrayAssert.equalToArray([], sprite0.log);
		_validator.dispatchExitFrame();
		ArrayAssert.equalToArray(["doValidateSize"], sprite0.log);
	}
}