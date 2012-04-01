package temperate.text;

import massive.munit.Assert;
import temperate.skins.CNullRectSkin;
import temperate.skins.ICRectSkin;

class CInputFieldTest
{
	public function new()
	{
	}
	
	var _input:ExtendedInputField;
	
	@Before
	public function setUp():Void
	{
		_input = new ExtendedInputField(CNullRectSkin.getInstance());
	}
	
	@Test
	public function heigthIsDeterminesByTextFormat()
	{
		{
			var format = _input.format;
			var measuredTf = format.newAutoSized(false, "text");
			Assert.areEqual(
				_input.textIndentTop + measuredTf.height + _input.textIndentBottom, _input.height);
		}
		
		{
			var format = new CTextFormat("Arial", 30);
			var measuredTf = format.newAutoSized(false, "text");
			_input.format = format;
			Assert.areEqual(
				_input.textIndentTop + measuredTf.height + _input.textIndentBottom, _input.height);
		}
	}
	
	function newSpaceTf(input:CInputField)
	{
		return input.format.newAutoSized(false, " ");
	}
	
	@Test
	public function widthIsNotLessOneSpace()
	{
		var skin = new FakeSkin();
		var input = new ExtendedInputField(skin);
		var measuredTf = newSpaceTf(input);
		
		input.setTextIndents(10, 11, 12, 13);
		
		input.width = 100;
		Assert.areEqual(100, input.width);
		
		input.width = 0;
		Assert.areEqual(10 + measuredTf.width + 11, input.width);
	}
	
	@Test
	public function sizeIsNotLessSkinMinSize()
	{
		{
			var skin = new FakeSkin().setFixedSize(211, Math.NaN);
			var input = new ExtendedInputField(skin);
			var measuredTf = newSpaceTf(input);
			
			input.setTextIndents(10, 11, 12, 13);
			
			input.width = 0;
			Assert.areEqual(211, input.width);
			Assert.areEqual(12 + measuredTf.height + 13, input.height);
		}
		
		{
			var skin = new FakeSkin().setFixedSize(Math.NaN, 111);
			var input = new ExtendedInputField(skin);
			var measuredTf = newSpaceTf(input);
			
			input.setTextIndents(10, 11, 12, 13);
			
			input.width = 0;
			input.height = 0;
			Assert.areEqual(10 + measuredTf.width + 11, input.width);
			Assert.areEqual(111, input.height);
		}
	}
	
	@Test
	public function heigthIsDeterminesByTextIndents_and_tfOffseted()
	{
		var format = _input.format;
		var measuredTf = format.newAutoSized(false, "text");
		
		_input.setTextIndents(10, 11, 12, 13);
		Assert.areEqual(12 + measuredTf.height + 13, _input.height);
		
		_input.validate();
		
		var tf = _input.getTf();
		Assert.areEqual(10, tf.x);
		Assert.areEqual(12, tf.y);
		Assert.areEqual(_input.width - 10 - 11, tf.width);
		Assert.isTrue(_input.height >= _input.height - 12 - 13);
	}
	
	@Test
	public function fieldIsNotFailingOnNullText_and_saveSettedText()
	{
		_input.text = null;
		Assert.areEqual(null, _input.text);
		
		_input.text = "";
		Assert.areEqual("", _input.text);
		
		_input.text = "text";
		Assert.areEqual("text", _input.text);
		
		_input.text = null;
		Assert.areEqual(null, _input.text);
	}
}

class ExtendedInputField extends CInputField
{
	public function new(bg:ICRectSkin)
	{
		super(bg);
	}
	
	public function getTf()
	{
		return _tf;
	}
}

class FakeSkin extends CNullRectSkin
{
	public function new()
	{
		super();
	}
	
	var _fixedWidth:Float;
	var _fixedHeight:Float;
	
	override public function getFixedWidth():Float
	{
		return _fixedWidth;
	}
	
	override public function getFixedHeight():Float
	{
		return _fixedHeight;
	}
	
	public function setFixedSize(width:Float, height:Float)
	{
		_fixedWidth = width;
		_fixedHeight = height;
		return this;
	}
}