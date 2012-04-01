package temperate.text;

import flash.text.TextField;
import massive.munit.Assert;

class CLabelTest
{
	public function new()
	{
	}
	
	var _objectMother:ObjectMother;
	
	@Before
	public function setUp():Void
	{
		_objectMother = new ObjectMother();
	}
	
	@Test
	public function textIsEqualsToNullByDefault()
	{
		var label = new TestLabel();
		Assert.areEqual(null, label.text);
	}
	
	@Test
	public function compactMode_ifNoText_sizeEqualToTextSizeWithSpace()
	{
		var label = new TestLabel();
		label.setCompact(true, true);
		
		var measured = label.format.newAutoSized();
		measured.text = " ";
		
		Assert.areEqual(measured.width, label.width);
		Assert.areEqual(measured.height, label.height);
	}
	
	@Test
	public function selectableSettedToFalseByDefault()
	{
		var label = new TestLabel();
		
		Assert.areEqual(false, label.selectable);
		Assert.areEqual(false, label.getTf().selectable);
	}
	
	@Test
	public function textSelectableChangeWhenLabelSelectableSetted()
	{
		var label = new TestLabel();
		
		label.selectable = true;
		Assert.areEqual(true, label.getTf().selectable);
		
		label.selectable = false;
		Assert.areEqual(false, label.getTf().selectable);
	}
	
	@Test
	public function compactMode_ifTextChangeToSmallerSizeIsChanged()
	{
		var label = _objectMother.newLabel();
		label.setCompact(true, true);
		
		var measured = _objectMother.newMeasuredTf();
		
		label.text = "long text\nnext line";
		measured.text = "long text\nnext line";
		Assert.areEqual(measured.width, label.width);
		Assert.areEqual(measured.height, label.height);
		
		label.text = "short";
		measured.text = "short";
		Assert.areEqual(measured.width, label.width);
		Assert.areEqual(measured.height, label.height);
	}
	
	@Test
	public function compactMode_ifFormatChangeSizeChangeToo()
	{
		var label = _objectMother.newLabel();
		label.setCompact(true, true);
		label.text = "Some text";
		
		{
			var measured = _objectMother.newBigMeasuredTf();
			measured.text = "Some text";
			
			label.format = _objectMother.bigFormat;
			
			Assert.areEqual(measured.width, label.width);
			Assert.areEqual(measured.height, label.height);
		}
		
		{
			var measured = _objectMother.newMeasuredTf();
			measured.text = "Some text";
			
			label.format = _objectMother.format;
			
			Assert.areEqual(measured.width, label.width);
			Assert.areEqual(measured.height, label.height);
		}
	}
	
	@Test
	public function allowNullAndEmptyStringSetToText_inThisCaseSizeAreEqualLabelWithSpace()
	{
		var label = _objectMother.newLabel();
		var measured = _objectMother.newMeasuredTf();
		measured.text = " ";
		
		label.text = "";
		Assert.areEqual(measured.width, label.width);
		Assert.areEqual(measured.height, label.height);
		
		label.text = null;
		Assert.areEqual(measured.width, label.width);
		Assert.areEqual(measured.height, label.height);
	}
	
	@Test
	public function nonCompactMode_settingSizeMoreThanMinimalIsPossible()
	{
		var label = _objectMother.newLabel();
		var measured = _objectMother.newMeasuredTf();
		label.text = "Some text";
		measured.text = "Some text";
		
		label.setCompact(false, true);
		label.width = measured.width + 1;
		label.height = 500;
		Assert.areEqual(measured.width + 1, label.width);
		Assert.areEqual(measured.height, label.height);
		
		label.setCompact(true, false);
		label.width = 500;
		label.height = measured.height + 1;
		Assert.areEqual(measured.width, label.width);
		Assert.areEqual(measured.height + 1, label.height);
	}
	
	@Test
	public function nonCompactMode_settingSizeLessThanMinimalIsImpossible()
	{
		var label = _objectMother.newLabel();
		var measured = _objectMother.newMeasuredTf();
		label.text = "Some text";
		measured.text = "Some text";
		
		label.setCompact(false, false);
		label.width = measured.width - 1;
		label.height = measured.height - 1;
		Assert.areEqual(measured.width, label.width);
		Assert.areEqual(measured.height, label.height);
	}
	
	@Test
	public function nonCompactMode_ifTextSizeEncrease_and_textSizeMoreLabelSize_labelIncrease()
	{
		var label = _objectMother.newLabel();
		var measured = _objectMother.newMeasuredTf();
		label.setCompact(false, false);
		label.text = "Some text";
		measured.text = "Some text";
		
		label.width = measured.width + 10;
		label.text = "Long long long long long long long text";
		measured.text = "Long long long long long long long text";
		Assert.areEqual(measured.width, label.width);
		
		label.height = measured.height + 1;
		label.text = "Multiline\ntext";
		measured.text = "Multiline\ntext";
		Assert.areEqual(measured.height, label.height);
	}
	
	@Test
	public function nonCompactMode_ifTextSizeEncreae_and_textSizeNotMoreLabelSize_itsNotChanged()
	{
		var label = _objectMother.newLabel();
		var measured = _objectMother.newMeasuredTf();
		label.setCompact(false, false);
		label.text = "Some text";
		measured.text = "Some text";
		
		label.width = 500;
		label.text = "Long long long text";
		measured.text = "Long long long text";
		Assert.areEqual(500, label.width);
		
		label.height = 500;
		label.text = "Multiline\ntext";
		measured.text = "Multiline\ntext";
		Assert.areEqual(500, label.height);
	}
	
	@Test
	public function onAlignChange_textPositionIsCorrectedByAlign()
	{
		var label = _objectMother.newLabel();
		var measured = _objectMother.newMeasuredTf();
		label.setCompact(false, false);
		label.text = "Some text";
		measured.text = "Some text";
		
		label.width = 500;
		label.height = 200;
		
		label.setTextAlign(0, 0);
		label.validate();
		Assert.areEqual(0, label.getTf().x);
		Assert.areEqual(0, label.getTf().y);
		
		label.setTextAlign(1, 0);
		label.validate();
		Assert.areEqual(500 - measured.width, label.getTf().x);
		Assert.areEqual(0, label.getTf().y);
		
		label.setTextAlign(0, 1);
		label.validate();
		Assert.areEqual(0, label.getTf().x);
		Assert.areEqual(200 - measured.height, label.getTf().y);
	}
	
	@Test
	public function onTextChange_textPositionIsCorrectedByAlign()
	{
		var label = _objectMother.newLabel();
		var measured = _objectMother.newMeasuredTf();
		label.setCompact(false, false);
		label.setTextAlign(1, 1);
		
		label.width = 500;
		label.height = 200;
		
		measured.text = "Some text";
		label.text = "Some text";
		label.validate();
		Assert.areEqual(500 - measured.width, label.getTf().x);
		Assert.areEqual(200 - measured.height, label.getTf().y);
		
		measured.text = "Some long text";
		label.text = "Some long text";
		label.validate();
		Assert.areEqual(500 - measured.width, label.getTf().x);
		Assert.areEqual(200 - measured.height, label.getTf().y);
	}
	
	@Test
	public function onFormatChange_textPositionIsCorrectedByAlign()
	{
		var label = new TestLabel();
		label.setCompact(false, false);
		label.setTextAlign(1, 1);
		label.text = "Some text";
		label.width = 500;
		label.height = 200;
		
		{
			var measured = _objectMother.newMeasuredTf();
			measured.text = "Some text";
			label.format = _objectMother.format;
			label.validate();
			Assert.areEqual(500 - measured.width, label.getTf().x);
			Assert.areEqual(200 - measured.height, label.getTf().y);
		}
		
		{
			var measured = _objectMother.newBigMeasuredTf();
			measured.text = "Some text";
			label.format = _objectMother.bigFormat;
			label.validate();
			Assert.areEqual(500 - measured.width, label.getTf().x);
			Assert.areEqual(200 - measured.height, label.getTf().y);
		}
	}
	
	@Test
	public function widthIsReturnToSetted_ifNotCompact()
	{
		var label = _objectMother.newLabel();
		var measured = _objectMother.newMeasuredTf();
		var longText = "some long long long text long long long text";
		label.setCompact(false, false);
		label.width = 50;
		
		label.text = longText;
		measured.text = longText;
		
		Assert.areEqual(measured.width, label.width);
		Assert.areEqual(measured.height, label.height);
		
		label.text = "short";
		Assert.areEqual(50, label.width);
		Assert.areEqual(measured.height, label.height);
	}
	
	@Test
	public function heightIsReturnToSetted_ifNotCompact()
	{
		var label = _objectMother.newLabel();
		var measured = _objectMother.newMeasuredTf();
		var longText = "some\nlong\nlong\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\ntext";
		label.setCompact(false, false);
		label.height = 40;
		
		label.text = longText;
		measured.text = longText;
		
		Assert.areEqual(measured.height, label.height);
		
		label.text = "short";
		Assert.areEqual(40, label.height);
	}
	
	@Test
	public function widthIsReturnToMinFromSetted_ifSwitchedToCompact()
	{
		var label = _objectMother.newLabel();
		var measured = _objectMother.newMeasuredTf();
		label.setCompact(false, false);
		label.width = 100;
		
		label.text = "text";
		measured.text = "text";
		
		Assert.areEqual(100, label.width);
		Assert.areEqual(measured.height, label.height);
		
		label.setCompact(true, false);
		
		Assert.areEqual(measured.width, label.width);
		Assert.areEqual(measured.height, label.height);
	}
	
	@Test
	public function htmlSetting_and_sizeWithHtml()
	{
		var label = _objectMother.newLabel();
		var measuredTf = _objectMother.newMeasuredTf();
		
		var text = "<font size=\"30\">some text</font>";
		measuredTf.htmlText = text;
		
		label.setCompact(true, true);
		label.html = true;
		label.text = text;
		Assert.areEqual("<font size=\"30\">some text</font>", label.text);
		Assert.areEqual(measuredTf.width, label.width);
		Assert.areEqual(measuredTf.height, label.height);
	}
}
class TestLabel extends CLabel
{
	public function new()
	{
		super();
	}
	
	public function getTf():TextField
	{
		return _tf;
	}
}
class ObjectMother
{
	public function new()
	{
		format = new CTextFormat("Arial", 16);
		bigFormat = new CTextFormat("Arial", 20);
	}
	
	public var format(default, null):CTextFormat;
	public var bigFormat(default, null):CTextFormat;
	
	public function newLabel()
	{
		var label = new TestLabel();
		label.format = format;
		return label;
	}
	
	public function newMeasuredTf()
	{
		return format.newAutoSized();
	}
	
	public function newBigMeasuredTf()
	{
		return bigFormat.newAutoSized();
	}
}