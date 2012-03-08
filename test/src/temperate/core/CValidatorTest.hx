package temperate.core;

import massive.munit.Assert;
import temperate.containers.CHBox;
import temperate.containers.CVBox;

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
		_validator.forseValidate();
		ArrayAssert.equalToArray(["doValidateSize"], sprite0.log);
	}
	
	@Test
	public function bugWithFailureOnSizeValidation():Void
	{
		var parent = new FakeBox("parent", _validator);
		var child = new FakeBox("child", _validator);
		parent.add(child);
		child.invalidate();
		_validator.forseValidate();
		Assert.isTrue(true);// Not failed
	}
	
	@Test
	public function bugWithFailureOnViewValidation():Void
	{
		var parent = new FakeViewChildValidateble("parent", _validator);
		var child = new FakeViewChildValidateble("child", _validator);
		var subchild = new FakeViewChildValidateble("subchild", _validator);
		parent.add(child);
		child.add(subchild);
		subchild.invalidate();
		_validator.forseValidate();
		Assert.isTrue(true);// Not failed
	}
}