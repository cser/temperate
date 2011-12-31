package temperate.components;
import flash.display.BitmapData;
import flash.text.TextField;
import massive.munit.Assert;
import temperate.components.CButtonState;
import temperate.text.CTextFormat;

class CRasterScaledButtonTest
{
	
	public function new()
	{
	}
	
	public function LUIScaledButtonTest()
	{
	}
	
	var _button:CRasterScaledButton;
	var _defaultFormat:CTextFormat;
	var _customFormat:CTextFormat;
	var _defaultTextField:TextField;
	var _customTextField:TextField;
	
	@Before
	public function setUp()
	{
		_button = new CRasterScaledButton();
		_button.setCompact(true, true);
		_defaultFormat = new CTextFormat("Arial", 18);
		_customFormat = new CTextFormat("Verdana", 14);
		_defaultTextField = _defaultFormat.newAutoSized();
		_customTextField = _customFormat.newAutoSized();
	}
	
	@Test
	public function sizeDeterminedAsTextSizePlusTextIndents()
	{
		_button.getState(CButtonState.UP).setFormat(_defaultFormat);
		
		var text = "Some text";
		_button.text = text;
		_defaultTextField.text = text;
		
		Assert.areEqual(
			_button.textIndentLeft + _defaultTextField.width + _button.textIndentRight,
			_button.width
		);
		Assert.areEqual(
			_button.textIndentTop + _defaultTextField.height + _button.textIndentBottom,
			_button.height
		);
	}
	
	@Test
	public function buttonNotThrowExceptionOnNullText()
	{
		_button.getState(CButtonState.UP)
			.setBitmapData(new BitmapData(50, 50))
			.setFormat(_defaultFormat);
		_button.text = "Some text";
		_button.text = null;
		Assert.areEqual(null, _button.text);
		
		_defaultTextField.text = " ";
		
		Assert.areEqual(
			_button.textIndentLeft + _defaultTextField.width + _button.textIndentRight,
			_button.width
		);
		Assert.areEqual(
			_button.textIndentTop + _defaultTextField.height + _button.textIndentBottom,
			_button.height
		);
	}
	
	@Test
	public function textAndFormatSetOrderIsNotMetters()
	{
		var text = "Some text";
		_customTextField.text = text;
		_button.setTextIndents(10, 11, 12, 13);
		_button.getState(CButtonState.UP).setFormat(_defaultFormat);
		
		_button.text = text;
		_button.getState(CButtonState.UP).setFormat(_customFormat);
		
		Assert.areEqual(
			_button.textIndentLeft + _customTextField.width + _button.textIndentRight,
			_button.width
		);
		Assert.areEqual(
			_button.textIndentTop + _customTextField.height + _button.textIndentBottom,
			_button.height
		);
	}
	
	@Test
	public function forButtonWithoutTextSizeAreEqualToButtonWithSpace()
	{
		var spaceButton = new CRasterScaledButton();
		spaceButton.text = " ";
		
		Assert.areEqual(spaceButton.width, _button.width);
		Assert.areEqual(spaceButton.height, _button.height);
	}
	
	@Test
	public function textIndentsMastInfluenceToSize()
	{
		_button.getState(CButtonState.UP).setFormat(_defaultFormat);
		
		var text = "Some text";
		_button.text = text;
		_defaultTextField.text = text;
		
		var left = 25;
		var right = 10;
		var top = 10;
		var bottom = 100;
		
		_button.setTextIndents(left, right, top, bottom);
		
		Assert.areEqual(_defaultTextField.width + left + right, _button.width);
		Assert.areEqual(_defaultTextField.height + top + bottom, _button.height);
	}
	
	@Test
	public function buttonMastChangeSizesFreelyIfCompactSetsToFalse()
	{
		var text = "Some text";
		_defaultTextField.text = text;
		_button.getState(CButtonState.UP).setFormat(_defaultFormat);
		_button.text = text;
		
		_button.setCompact(false, false);
		_button.width = 300;
		_button.height = 200;
		Assert.areEqual(300, _button.width);
		Assert.areEqual(200, _button.height);
		
		_button.setCompact(true, false);
		_button.width = 300;
		_button.height = 200;
		Assert.areEqual(
			_button.textIndentLeft + _defaultTextField.width + _button.textIndentRight,
			_button.width
		);
		Assert.areEqual(200, _button.height);
		
		_button.setCompact(false, true);
		_button.width = 300;
		_button.height = 200;
		Assert.areEqual(300, _button.width);
		Assert.areEqual(
			_button.textIndentTop + _defaultTextField.height + _button.textIndentBottom,
			_button.height
		);
	}
	
	@Test
	public function sizesMastDependedJustOnUpTextFormatt()
	{
		var text = "Some text";
		var bd = new BitmapData(50, 20);
		_button.getState(CButtonState.UP).setBitmapData(bd).setFormat(_defaultFormat);
		_button.getState(CButtonState.OVER).setBitmapData(bd).setFormat(_customFormat);
		_button.getState(CButtonState.DOWN).setBitmapData(bd).setFormat(_customFormat);
		_button.getState(CButtonState.DISABLED).setBitmapData(bd).setFormat(_customFormat);
		_button.text = text;
		_defaultTextField.text = text;
		
		var minWidth =
			_button.textIndentLeft + _defaultTextField.width + _button.textIndentRight;
		var minHeight =
			_button.textIndentTop + _defaultTextField.height + _button.textIndentBottom;
		Assert.areEqual(minWidth, _button.width);
		Assert.areEqual(minHeight, _button.height);
	}
	
	@Test
	public function sizeCantBeLessMinEvenComactSetsToFalse()
	{
		var text = "Some text";
		_button.getState(CButtonState.UP)
			.setBitmapData(new BitmapData(50, 50))
			.setFormat(_defaultFormat);
		_button.text = text;
		_defaultTextField.text = text;
		
		_button.setCompact(false, false);
		var minWidth =
			_button.textIndentLeft + _defaultTextField.width + _button.textIndentRight;
		var minHeight =
			_button.textIndentTop + _defaultTextField.height + _button.textIndentBottom;
		checkMinSize(minWidth, minHeight);
	}
	
	function checkMinSize(minWidth:Float, minHeight:Float)
	{
		{
			_button.width = 2;
			_button.height = 500;
			Assert.areEqual(minWidth, _button.width);
			Assert.areEqual(500, _button.height);
			
			_button.width = minWidth - 1;
			_button.height = 500;
			Assert.areEqual(minWidth, _button.width);
			Assert.areEqual(500, _button.height);
			
			_button.width = minWidth + 1;
			_button.height = 500;
			Assert.areEqual(minWidth + 1, _button.width);
			Assert.areEqual(500, _button.height);
		}
		
		{
			_button.width = 510;
			_button.height = 3;
			Assert.areEqual(510, _button.width);
			Assert.areEqual(minHeight, _button.height);
			
			_button.width = 510;
			_button.height = minHeight;
			Assert.areEqual(510, _button.width);
			Assert.areEqual(minHeight, _button.height);
			
			_button.width = 510;
			_button.height = minHeight + 1;
			Assert.areEqual(510, _button.width);
			Assert.areEqual(minHeight + 1, _button.height);
		}
		
		{
			_button.width = 2;
			_button.height = 3;
			Assert.areEqual(minWidth, _button.width);
			Assert.areEqual(minHeight, _button.height);
		}
	}
	
	@Test
	public function previousFormatChangesIsNotChangeFinalSizes()
	{
		var text = "Some text";
		_defaultTextField.text = text;
		_button.text = text;
		_button.setTextIndents(10, 11, 12, 13);
		
		var bd = new BitmapData(50, 50);
		_button.getState(CButtonState.UP).setBitmapData(bd).setFormat(_defaultFormat);
		_button.getState(CButtonState.UP).setBitmapData(bd).setFormat(_customFormat);
		_button.width = _button.width;// Validation by getted
		_button.getState(CButtonState.UP).setBitmapData(bd).setFormat(_defaultFormat);
		
		Assert.areEqual(
			_button.textIndentLeft + _defaultTextField.width + _button.textIndentRight,
			_button.width
		);
		Assert.areEqual(
			_button.textIndentTop + _defaultTextField.height + _button.textIndentBottom,
			_button.height
		);
	}
	
	@Test
	public function labelChangeMakesSizeChange()
	{
		_button.getState(CButtonState.UP)
			.setBitmapData(new BitmapData(10, 10))
			.setFormat(_defaultFormat);
		
		var first = "First text";
		var second = "Second more longer\ntext";
		
		var left = _button.textIndentLeft;
		var right = _button.textIndentRight;
		var top = _button.textIndentTop;
		var bottom = _button.textIndentBottom;
		
		_button.text = first;
		
		var firstTF = _defaultFormat.newAutoSized();
		firstTF.text = first;
		var firstWidth = left + firstTF.width + right;
		var firstHeight = top + firstTF.height + bottom;
		
		Assert.areEqual(firstWidth, _button.width);
		Assert.areEqual(firstHeight, _button.height);
		
		_button.text = second;
		
		Assert.isTrue(firstWidth != _button.width);
		Assert.isTrue(firstHeight != _button.height);
		
		var secondTF = _defaultFormat.newAutoSized();
		secondTF.text = second;
		
		_defaultTextField.text = second;
		
		Assert.areEqual(
			_defaultTextField.width + _button.textIndentLeft + _button.textIndentRight,
			_button.width
		);
		Assert.areEqual(
			_defaultTextField.height + _button.textIndentTop + _button.textIndentBottom,
			_button.height
		);
		
		_button.text = first;
		
		Assert.areEqual(firstWidth, _button.width);
		Assert.areEqual(firstHeight, _button.height);
	}
	
	@Test
	public function labelChangeIsNotMakesSizeChangeIfButtonIsNotComactAndSizeEnough()
	{
		_button.getState(CButtonState.UP)
			.setBitmapData(new BitmapData(10, 10))
			.setFormat(_defaultFormat);
		_button.setCompact(false, false);
		_button.text = "Some text";
		
		var width = 500;
		var height = 300;
		_button.height = height;
		_button.width = width;
		
		_button.text = "Another long text";
		
		Assert.areEqual(width, _button.width);
		Assert.areEqual(height, _button.height);
	}
	
	@Test
	public function settedWidthIsRestoreIfItPossible()
	{
		_button.getState(CButtonState.UP)
			.setBitmapData(new BitmapData(10, 10))
			.setFormat(_defaultFormat);
		_button.setCompact(false, false);
		_button.setTextIndents(0, 0, 0, 0);
		_button.width = 50;
		
		var text = "long long long long long long long long long long long long text";
		_button.text = text;
		_defaultTextField.text = text;
		Assert.areEqual(_defaultTextField.width, _button.width);
		Assert.areEqual(_defaultTextField.height, _button.height);
		
		var text = "short";
		_button.text = text;
		_defaultTextField.text = text;
		Assert.areEqual(50, _button.width);
		Assert.areEqual(_defaultTextField.height, _button.height);
	}
	
	@Test
	public function settedHeightIsRestoreIfItPossible()
	{
		_button.getState(CButtonState.UP)
			.setBitmapData(new BitmapData(10, 10))
			.setFormat(_defaultFormat);
		_button.setCompact(false, false);
		_button.setTextIndents(0, 0, 0, 0);
		_button.height = 50;
		
		var text = "multiline\ntext\ntext\ntext\n\n\n\n\n\n\n\ntext\ntext\ntext\ntext\ntext\ntext";
		_button.text = text;
		_defaultTextField.text = text;
		Assert.areEqual(_defaultTextField.width, _button.width);
		Assert.areEqual(_defaultTextField.height, _button.height);
		
		var text = "short";
		_button.text = text;
		_defaultTextField.text = text;
		Assert.areEqual(_defaultTextField.width, _button.width);
		Assert.areEqual(50, _button.height);
	}
}