package temperate.layouts;

import flash.display.Shape;
import haxe.PosInfos;
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
	
	var _wrapper:CChildWrapper;
	var _layout:CScrollLayout;
	
	@Before
	public function setUp():Void
	{
		resetScrollBars();
		
		_wrapper = new CChildWrapper(new CSpacer());
		
		_layout = new CScrollLayout();
		_layout.showHScrollBar = showH;
		_layout.hideHScrollBar = hideH;
		_layout.showVScrollBar = showV;
		_layout.hideVScrollBar = hideV;
	}
	
	@After
	public function tearDown():Void
	{
		
	}
	
	function resetScrollBars()
	{
		_hScrollBar = null;
		_vScrollBar = null;
		_hideHCalled = false;
		_hideVCalled = false;
	}
	
	var _hScrollBar:H;
	
	function showH()
	{
		if (_hScrollBar == null)
		{
			_hScrollBar = new H();
		}
		return _hScrollBar;
	}
	
	var _vScrollBar:V;
	
	function showV()
	{
		if (_vScrollBar == null)
		{
			_vScrollBar = new V();
		}
		return _vScrollBar;
	}
	
	var _hideHCalled:Bool;
	
	function hideH()
	{
		_hideHCalled = true;
	}
	
	var _hideVCalled:Bool;
	
	function hideV()
	{
		_hideVCalled = true;
	}
	
	function setLayoutSize(width:Int, height:Int)
	{
		_layout.width = width;
		_layout.height = height;
	}
	
	function setLayoutScrollPolicy(hScrollPolicy:CScrollPolicy, vScrollPolicy:CScrollPolicy)
	{
		_layout.hScrollPolicy = hScrollPolicy;
		_layout.vScrollPolicy = vScrollPolicy;
	}
	
	function assertLayoutSize(expectedWidth:Int, exptectedHeight:Int, ?info:PosInfos)
	{
		Assert.areEqual(expectedWidth, _layout.width, info);
		Assert.areEqual(exptectedHeight, _layout.height, info);
	}
	
	function assertWrapperSize(expectedWidth:Int, exptectedHeight:Int, ?info:PosInfos)
	{
		Assert.areEqual(expectedWidth, _wrapper.getWidth(), info);
		Assert.areEqual(exptectedHeight, _wrapper.getHeight(), info);
	}
	
	function assertScrollBarsShowed(hShowed:Bool, vShowed:Bool, ?info:PosInfos)
	{
		Assert.areEqual(_hScrollBar != null, hShowed, info);
		Assert.areEqual(_vScrollBar != null, vShowed, info);
		Assert.areEqual(_hideHCalled, !vShowed, info);
		Assert.areEqual(_hideVCalled, !hShowed, info);
	}
	
	/*
	----------
	|     |  |
	|     |  | V
	|     |  |
	----------
	|     |
	-------
	  H
	*/
	
	@Test
	public function vAndHOff_noWrapper_sizeIsEqualToSettedAndNotLessZero()
	{
		setLayoutScrollPolicy(CScrollPolicy.OFF, CScrollPolicy.OFF);
		
		setLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT + 1, H.MIN_HEIGHT + V.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT + 1, H.MIN_HEIGHT + V.MIN_HEIGHT + 1);
		
		setLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT - 1, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT - 1, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		
		setLayoutSize(10, 0);
		_layout.arrange();
		assertLayoutSize(10, 0);
		
		setLayoutSize(0, 0);
		_layout.arrange();
		assertLayoutSize(0, 0);
		
		setLayoutSize(-1, 0);
		_layout.arrange();
		assertLayoutSize(0, 0);
		
		setLayoutSize(0, -1);
		_layout.arrange();
		assertLayoutSize(0, 0);
		
		setLayoutSize(-100, -10);
		_layout.arrange();
		assertLayoutSize(0, 0);
		
		assertScrollBarsShowed(false, false);
	}
	
	@Test
	public function vAndHOff_sizeIsDeterminedByWrapperSize()
	{
		setLayoutScrollPolicy(CScrollPolicy.OFF, CScrollPolicy.OFF);
		_wrapper.setWidth(1000);
		_wrapper.setHeight(1010);
		_layout.wrapper = _wrapper;
		
		resetScrollBars();
		setLayoutSize(10, 20);
		_layout.arrange();
		assertLayoutSize(1000, 1010);
		assertScrollBarsShowed(false, false);
		
		setLayoutSize(1000 - 1, 1010 - 1);
		_layout.arrange();
		assertLayoutSize(1000, 1010);
		
		setLayoutSize(1000 + 1, 1010 + 1);
		_layout.arrange();
		assertLayoutSize(1000, 1010);
		
		resetScrollBars();
		_wrapper.setPercents(100, 100);
		setLayoutSize(10, 20);
		_layout.arrange();
		assertLayoutSize(10, 20);
		assertWrapperSize(10, 20);
		assertScrollBarsShowed(false, false);
		
		resetScrollBars();
		_wrapper.setWidth(100);
		_wrapper.setHeight(80);
		_wrapper.setPercents(100, -1);
		setLayoutSize(10, 20);
		_layout.arrange();
		assertLayoutSize(10, 80);
		assertWrapperSize(10, 80);
		assertScrollBarsShowed(false, false);
		
		resetScrollBars();
		_wrapper.setWidth(100);
		_wrapper.setHeight(80);
		_wrapper.setPercents(-1, 100);
		setLayoutSize(10, 20);
		_layout.arrange();
		assertLayoutSize(100, 20);
		assertWrapperSize(100, 20);
		assertScrollBarsShowed(false, false);
		
		resetScrollBars();
		_wrapper.setWidth(100);
		_wrapper.setHeight(80);
		_wrapper.setPercents(100, 100);
		_wrapper.setFixedSize(11, 12);
		setLayoutSize(10, 20);
		_layout.arrange();
		assertLayoutSize(11, 12);
		assertWrapperSize(11, 12);
		_wrapper.setFixedSize();
		assertScrollBarsShowed(false, false);
		
		resetScrollBars();
		_wrapper.setWidth(100);
		_wrapper.setHeight(80);
		_wrapper.setContingencies(10, 20, 30, 40);
		
		setLayoutSize(10 - 1, 30 - 1);
		_layout.arrange();
		assertLayoutSize(10, 30);
		assertWrapperSize(10, 30);
		
		setLayoutSize(15, 35);
		_layout.arrange();
		assertLayoutSize(15, 35);
		assertWrapperSize(15, 35);
		
		setLayoutSize(21, 41);
		_layout.arrange();
		assertLayoutSize(20, 40);
		assertWrapperSize(20, 40);
		
		assertScrollBarsShowed(false, false);
	}
	
	@Test
	public function vAndHOn_noWrapper_ifSizeMoreThanMinimal_applySettedSize()
	{
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.ON);
		var settedWidth = H.MIN_WIDHT + V.MIN_WIDHT + 1;
		var settedHeight = H.MIN_HEIGHT + V.MIN_HEIGHT + 1;
		setLayoutSize(settedWidth, settedHeight);
		_layout.arrange();
		assertLayoutSize(settedWidth, settedHeight);
		assertScrollBarsShowed(true, true);
	}
	
	@Test
	public function vAndHOn_noWrapper_ifSizeLessThanMinimal_applyMinimalSize()
	{
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.ON);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT - 1, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertScrollBarsShowed(true, true);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT + 10, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT + 10, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertScrollBarsShowed(true, true);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT - 1, H.MIN_HEIGHT + V.MIN_HEIGHT + 20);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT, H.MIN_HEIGHT + V.MIN_HEIGHT + 20);
		assertScrollBarsShowed(true, true);
	}
	
	@Test
	public function vAndHOn_ifSizeIsMoreThatMinimal_wrapperScalesToInnerOfSettedSize()
	{
		_wrapper.setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.ON);
		var settedWidth = H.MIN_WIDHT + V.MIN_WIDHT + 1;
		var settedHeight = H.MIN_HEIGHT + V.MIN_HEIGHT + 1;
		setLayoutSize(settedWidth, settedHeight);
		_layout.arrange();
		assertLayoutSize(settedWidth, settedHeight);
		assertWrapperSize(settedWidth - V.MIN_WIDHT, settedHeight - H.MIN_HEIGHT);
		assertScrollBarsShowed(true, true);
	}
	
	@Test
	public function vAndHOn_ifSizeIsLessThatMinimal_wrapperScalesToMinimalInnerSize()
	{
		_wrapper.setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.ON);
		setLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT - 1, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDHT, V.MIN_HEIGHT);
		assertScrollBarsShowed(true, true);
	}
	
	@Test
	public function vAndHOn_ifSizeIsLessThatMinimal_andWrapperSizeIsSmall_sizeSetsByMinimal()
	{
		_wrapper.setWidth(H.MIN_WIDHT + V.MIN_WIDHT - 15);
		_wrapper.setHeight(H.MIN_HEIGHT + V.MIN_HEIGHT - 10);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.ON);
		setLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT - 1, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDHT + V.MIN_WIDHT, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDHT + V.MIN_WIDHT - 15, H.MIN_HEIGHT + V.MIN_HEIGHT - 10);
		assertScrollBarsShowed(true, true);
	}
}
/*
AUTO: Если контент вписывается в общую область скроллирования, скроллеры не должны появляться
Зависимость высотры контента от ширины
Появление прокруток при зависимости высотры от ширины
Компактный режим по высоте и ширине
*/


class H extends CSprite
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

class V extends CSprite
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