package temperate.layouts;

import flash.display.Shape;
import massive.munit.Assert;
import temperate.components.CScrollPolicy;
import temperate.components.CSpacer;
import temperate.core.CMath;
import temperate.core.CSprite;
import temperate.layouts.parametrization.CChildWrapper;

class CScrollLayoutTest
{
	public function new()
	{
	}
	
	@Before
	public function setUp():Void
	{
		resetScrollBars();
	}
	
	@After
	public function tearDown():Void
	{
		
	}
	
	function resetScrollBars()
	{
		_hScrollBar = null;
		_vScrollBar = null;
	}
	
	var _hScrollBar:HScrollBar;
	
	function showHScrollBar()
	{
		if (_hScrollBar == null)
		{
			_hScrollBar = new HScrollBar();
		}
		return _hScrollBar;
	}
	
	var _vScrollBar:VScrollBar;
	
	function showVScrollBar()
	{
		if (_vScrollBar == null)
		{
			_vScrollBar = new VScrollBar();
		}
		return _vScrollBar;
	}
	
	function hideScrollBar()
	{
	}
	
	/*
	----------
	|     |  |
	|     |  | VScrollBar
	|     |  |
	----------
	|     |
	-------
	  HScrollBar
	*/
	
	@Test
	public function vAndHOn_noWrapper_ifSizeMoreThanMinimal_applySettedSize()
	{
		resetScrollBars();
		var layout = new CScrollLayout();
		layout.vScrollPolicy = CScrollPolicy.ON;
		layout.hScrollPolicy = CScrollPolicy.ON;
		layout.width = HScrollBar.MIN_WIDHT + VScrollBar.MIN_WIDHT + 1;
		layout.height = HScrollBar.MIN_HEIGHT + VScrollBar.MIN_HEIGHT + 1;
		layout.arrange(showHScrollBar, hideScrollBar, showVScrollBar, hideScrollBar);
		Assert.areEqual(HScrollBar.MIN_WIDHT + VScrollBar.MIN_WIDHT + 1, layout.width);
		Assert.areEqual(HScrollBar.MIN_HEIGHT + VScrollBar.MIN_HEIGHT + 1, layout.height);
	}
	
	@Test
	public function vAndHOn_cases()
	{
		resetScrollBars();
		var wrapper = new CChildWrapper(new CSpacer()).setPercents(100, 100);
		var layout = new CScrollLayout();
		layout.wrapper = wrapper;
		layout.vScrollPolicy = CScrollPolicy.ON;
		layout.hScrollPolicy = CScrollPolicy.ON;
		var settedWidth = HScrollBar.MIN_WIDHT + VScrollBar.MIN_WIDHT + 1;
		var settedHeight = HScrollBar.MIN_HEIGHT + VScrollBar.MIN_HEIGHT + 1;
		layout.width = settedWidth;
		layout.height = settedHeight;
		layout.arrange(showHScrollBar, hideScrollBar, showVScrollBar, hideScrollBar);
		Assert.areEqual(settedWidth, layout.width);
		Assert.areEqual(settedHeight, layout.height);
		Assert.areEqual(settedWidth - VScrollBar.MIN_WIDHT, wrapper.getWidth());
		Assert.areEqual(settedHeight - HScrollBar.MIN_HEIGHT, wrapper.getHeight());
	}
}
class HScrollBar extends CSprite
{
	public static var MIN_WIDHT = 22;
	public static var MIN_HEIGHT = 10;
	
	public function new()
	{
		super();
	}
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_width = CMath.max(MIN_WIDHT, _settedWidth);
			_height = MIN_HEIGHT;
		}
	}
}

class VScrollBar extends CSprite
{
	public static var MIN_WIDHT = 14;
	public static var MIN_HEIGHT = 20;
	
	public function new()
	{
		super();
	}
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_width = MIN_WIDHT;
			_height = CMath.max(MIN_HEIGHT, _settedWidth);
		}
	}
}