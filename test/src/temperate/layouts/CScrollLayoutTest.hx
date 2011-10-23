package temperate.layouts;

import haxe.PosInfos;
import massive.munit.Assert;
import temperate.components.CScrollPolicy;
import temperate.components.CSpacer;
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
		_hidedH = false;
		_hidedV = false;
	}
	
	var _hScrollBar:H;
	
	function showH()
	{
		_hidedH = false;
		if (_hScrollBar == null)
		{
			_hScrollBar = new H();
		}
		return _hScrollBar;
	}
	
	var _vScrollBar:V;
	
	function showV()
	{
		_hidedV = false;
		if (_vScrollBar == null)
		{
			_vScrollBar = new V();
		}
		return _vScrollBar;
	}
	
	var _hidedH:Bool;
	
	function hideH()
	{
		_hidedH = true;
	}
	
	var _hidedV:Bool;
	
	function hideV()
	{
		_hidedV = true;
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
	
	function setWrapperSize(width:Int, height:Int)
	{
		_wrapper.setWidth(width);
		_wrapper.setHeight(height);
	}
	
	function assertLayoutSize(expectedWidth:Int, expectedHeight:Int, ?info:PosInfos)
	{
		Assert.isTrue(true);
		if (expectedWidth != _layout.width)
		{
			Assert.fail("getted width " + _layout.width + ", expected " + expectedWidth, info);
		}
		if (expectedHeight != _layout.height)
		{
			Assert.fail("getted height " + _layout.height + ", expected " + expectedHeight, info);
		}
	}
	
	function assertWrapperSize(expectedWidth:Int, expectedHeight:Int, ?info:PosInfos)
	{
		Assert.isTrue(true);
		var width = _wrapper.getWidth();
		var height = _wrapper.getHeight();
		if (expectedWidth != width)
		{
			Assert.fail("getted width " + width + ", expected " + expectedWidth, info);
		}
		if (expectedHeight != height)
		{
			Assert.fail("getted height " + height + ", expected " + expectedHeight, info);
		}
	}
	
	function assertScrollBarsShowed(hShowed:Bool, vShowed:Bool, ?info:PosInfos)
	{
		Assert.areEqual(_hScrollBar != null, hShowed, info);
		Assert.areEqual(_vScrollBar != null, vShowed, info);
		Assert.areEqual(!_hidedH, hShowed, info);
		Assert.areEqual(!_hidedV, vShowed, info);
	}
	
	function assertScrollBarsShowedSoft(hShowed:Bool, vShowed:Bool, ?info:PosInfos)
	{
		if (hShowed)
		{
			Assert.isTrue(!_hidedH && _hScrollBar != null, info);
		}
		else
		{
			Assert.isFalse(!_hidedH, info);
		}
		if (vShowed)
		{
			Assert.isTrue(!_hidedV && _vScrollBar != null, info);
		}
		else
		{
			Assert.isFalse(!_hidedV, info);
		}
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
	
	//----------------------------------------------------------------------------------------------
	//
	//  Compact size
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function comactSize_someCases()
	{
		_layout.wrapper = _wrapper.setPercents(100, 100);
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.AUTO);
		
		resetScrollBars();
		_layout.isCompactWidth = true;
		_layout.isCompactHeight = false;
		setLayoutSize(100, 200);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, 200);
		assertWrapperSize(H.MIN_WIDTH + V.MIN_WIDTH, 200);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		_layout.isCompactWidth = false;
		_layout.isCompactHeight = true;
		setLayoutSize(100, 200);
		_layout.arrange();
		assertLayoutSize(100, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertWrapperSize(100, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		_layout.isCompactWidth = true;
		_layout.isCompactHeight = true;
		setLayoutSize(100, 200);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH + V.MIN_WIDTH, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertScrollBarsShowedSoft(false, false);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  CScrollPolicy.OFF, CScrollPolicy.OFF
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function vAndHOff_noWrapper_sizeIsEqualToSettedAndNotLessZero()
	{
		setLayoutScrollPolicy(CScrollPolicy.OFF, CScrollPolicy.OFF);
		
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, H.MIN_HEIGHT + V.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, H.MIN_HEIGHT + V.MIN_HEIGHT + 1);
		
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		
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
	
	//----------------------------------------------------------------------------------------------
	//
	//  CScrollPolicy.ON, CScrollPolicy.ON
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function vAndHOn_noWrapper_ifSizeMoreThanMinimal_applySettedSize()
	{
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.ON);
		var settedWidth = H.MIN_WIDTH + V.MIN_WIDTH + 1;
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
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertScrollBarsShowed(true, true);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 10, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 10, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertScrollBarsShowed(true, true);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, H.MIN_HEIGHT + V.MIN_HEIGHT + 20);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, H.MIN_HEIGHT + V.MIN_HEIGHT + 20);
		assertScrollBarsShowed(true, true);
	}
	
	@Test
	public function vAndHOn_ifSizeIsMoreThatMinimal_wrapperScalesToInnerOfSettedSize()
	{
		_wrapper.setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.ON);
		var settedWidth = H.MIN_WIDTH + V.MIN_WIDTH + 1;
		var settedHeight = H.MIN_HEIGHT + V.MIN_HEIGHT + 1;
		setLayoutSize(settedWidth, settedHeight);
		_layout.arrange();
		assertLayoutSize(settedWidth, settedHeight);
		assertWrapperSize(settedWidth - V.MIN_WIDTH, settedHeight - H.MIN_HEIGHT);
		assertScrollBarsShowed(true, true);
	}
	
	@Test
	public function vAndHOn_ifSizeIsLessThatMinimal_wrapperScalesToMinimalInnerSize()
	{
		_wrapper.setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.ON);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH, V.MIN_HEIGHT);
		assertScrollBarsShowed(true, true);
	}
	
	@Test
	public function vAndHOn_ifSizeIsLessThatMinimal_andWrapperSizeIsSmall_sizeSetsByMinimal()
	{
		_wrapper.setWidth(5);
		_wrapper.setHeight(10);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.ON);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertWrapperSize(5, 10);
		assertScrollBarsShowed(true, true);
	}
	
	@Test
	public function vAndHOn_scale_heightIsDependentByWidth()
	{
		_wrapper = new CChildWrapper(new HeightByWidthSprite()).setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.ON);
		
		setLayoutSize(300 + V.MIN_WIDTH, 500);
		_layout.arrange();
		assertLayoutSize(300 + V.MIN_WIDTH, 500);
		assertWrapperSize(300, HeightByWidthSprite.getHeight(300));
		
		assertScrollBarsShowed(true, true);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  CScrollPolicy.ON, CScrollPolicy.OFF
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function hOnVOff_noScale_cases()
	{
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.OFF);
		
		resetScrollBars();
		_wrapper.setWidth(5);
		_wrapper.setHeight(10);
		setLayoutSize(H.MIN_WIDTH - 1, 4);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, 10 + H.MIN_HEIGHT);
		assertWrapperSize(5, 10);
		assertScrollBarsShowed(true, false);
		
		resetScrollBars();
		_wrapper.setWidth(5);
		_wrapper.setHeight(10);
		setLayoutSize(H.MIN_WIDTH + 1, 4);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + 1, 10 + H.MIN_HEIGHT);
		assertWrapperSize(5, 10);
		assertScrollBarsShowed(true, false);
		
		resetScrollBars();
		_wrapper.setWidth(200);
		_wrapper.setHeight(100);
		setLayoutSize(H.MIN_WIDTH + 10, 500);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + 10, 100 + H.MIN_HEIGHT);
		assertWrapperSize(200, 100);
		assertScrollBarsShowed(true, false);
	}
	
	@Test
	public function hOnVOff_scale_cases()
	{
		_wrapper.setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.OFF);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH - 1, 2);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, H.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH, 0);
		assertScrollBarsShowed(true, false);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH - 10, 200);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, 200);
		assertWrapperSize(H.MIN_WIDTH, 200 - H.MIN_HEIGHT);
		assertScrollBarsShowed(true, false);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + 1, 200);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + 1, 200);
		assertWrapperSize(H.MIN_WIDTH + 1, 200 - H.MIN_HEIGHT);
		assertScrollBarsShowed(true, false);
	}
	
	@Test
	public function hOnVOff_scaleWithConstraints_cases()
	{
		_wrapper.setPercents(100, 100).setContingencies(100, 150, 200, 250);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.OFF);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH - 1, 200 + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, 200 + H.MIN_HEIGHT);
		assertWrapperSize(100, 200);
		assertScrollBarsShowed(true, false);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH - 1, 200 + H.MIN_HEIGHT + 10);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, 200 + H.MIN_HEIGHT + 10);
		assertWrapperSize(100, 200 + 10);
		assertScrollBarsShowed(true, false);
		
		resetScrollBars();
		setLayoutSize(150 + 200, 250 + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(150 + 200, 250 + H.MIN_HEIGHT);
		assertWrapperSize(150, 250);
		assertScrollBarsShowed(true, false);
		
		resetScrollBars();
		setLayoutSize(100 + 10, 250 + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(100 + 10, 250 + H.MIN_HEIGHT);
		assertWrapperSize(100 + 10, 250);
		assertScrollBarsShowed(true, false);
	}
	
	@Test
	public function hOnVOff_scale_heightIsDependentByWidth()
	{
		_wrapper = new CChildWrapper(new HeightByWidthSprite()).setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.OFF);
		
		setLayoutSize(300, 250 + H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(300, HeightByWidthSprite.getHeight(300) + H.MIN_HEIGHT);
		assertWrapperSize(300, HeightByWidthSprite.getHeight(300));
		
		assertScrollBarsShowed(true, false);
	}
	
	@Test
	public function hOnVOff_noWrapper_cases()
	{
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.OFF);
		
		setLayoutSize(H.MIN_WIDTH - 1, H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, H.MIN_HEIGHT);
		
		setLayoutSize(H.MIN_WIDTH, H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, H.MIN_HEIGHT);
		
		setLayoutSize(H.MIN_WIDTH + 1, H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + 1, H.MIN_HEIGHT);
		
		setLayoutSize(H.MIN_WIDTH, H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, H.MIN_HEIGHT + 1);
		
		assertScrollBarsShowed(true, false);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  CScrollPolicy.OFF, CScrollPolicy.ON
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function hOffVOn_noScale_cases()
	{
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.OFF, CScrollPolicy.ON);
		
		resetScrollBars();
		_wrapper.setWidth(5);
		_wrapper.setHeight(10);
		setLayoutSize(2, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(5 + V.MIN_WIDTH, V.MIN_HEIGHT);
		assertWrapperSize(5, 10);
		assertScrollBarsShowed(false, true);
		
		resetScrollBars();
		_wrapper.setWidth(5);
		_wrapper.setHeight(10);
		setLayoutSize(2, V.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(5 + V.MIN_WIDTH, V.MIN_HEIGHT + 1);
		assertWrapperSize(5, 10);
		assertScrollBarsShowed(false, true);
		
		resetScrollBars();
		_wrapper.setWidth(200);
		_wrapper.setHeight(100);
		setLayoutSize(500, V.MIN_HEIGHT + 10);
		_layout.arrange();
		assertLayoutSize(200 + V.MIN_WIDTH, V.MIN_HEIGHT + 10);
		assertWrapperSize(200, 100);
		assertScrollBarsShowed(false, true);
	}
	
	@Test
	public function hOffVOn_scale_cases()
	{
		_wrapper.setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.OFF, CScrollPolicy.ON);
		
		resetScrollBars();
		setLayoutSize(2, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH, V.MIN_HEIGHT);
		assertWrapperSize(0, V.MIN_HEIGHT);
		assertScrollBarsShowed(false, true);
		
		resetScrollBars();
		setLayoutSize(200, V.MIN_HEIGHT - 10);
		_layout.arrange();
		assertLayoutSize(200, V.MIN_HEIGHT);
		assertWrapperSize(200 - V.MIN_WIDTH, V.MIN_HEIGHT);
		assertScrollBarsShowed(false, true);
		
		resetScrollBars();
		setLayoutSize(200, V.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(200, V.MIN_HEIGHT + 1);
		assertWrapperSize(200 - V.MIN_WIDTH, V.MIN_HEIGHT + 1);
		assertScrollBarsShowed(false, true);
	}
	
	@Test
	public function hOffVOn_scale_heightIsDependentByWidth()
	{
		_wrapper = new CChildWrapper(new HeightByWidthSprite()).setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.OFF, CScrollPolicy.ON);
		
		setLayoutSize(250 + V.MIN_WIDTH, 300);
		_layout.arrange();
		assertLayoutSize(250 + V.MIN_WIDTH, 300);
		assertWrapperSize(250, HeightByWidthSprite.getHeight(250));
		
		assertScrollBarsShowed(false, true);
	}
	
	@Test
	public function hOffVOn_noWrapper_cases()
	{
		setLayoutScrollPolicy(CScrollPolicy.OFF, CScrollPolicy.ON);
		
		setLayoutSize(V.MIN_WIDTH - 1, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH, V.MIN_HEIGHT);
		
		setLayoutSize(V.MIN_WIDTH, V.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH, V.MIN_HEIGHT);
		
		setLayoutSize(V.MIN_WIDTH + 1, V.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH + 1, V.MIN_HEIGHT);
		
		setLayoutSize(V.MIN_WIDTH, V.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH, V.MIN_HEIGHT + 1);
		
		assertScrollBarsShowed(false, true);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  CScrollPolicy.AUTO, CScrollPolicy.OFF
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function hAutoVOff_noScale_cases()
	{
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.OFF);
		
		resetScrollBars();
		_wrapper.setWidth(5);
		_wrapper.setHeight(8);
		setLayoutSize(H.MIN_WIDTH - 1, 8 - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, 8);
		assertWrapperSize(5, 8);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		_wrapper.setWidth(5);
		_wrapper.setHeight(8);
		setLayoutSize(H.MIN_WIDTH + 1, 8 - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + 1, 8);
		assertWrapperSize(5, 8);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		_wrapper.setWidth(5);
		_wrapper.setHeight(8);
		setLayoutSize(H.MIN_WIDTH, 8 - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, 8);
		assertWrapperSize(5, 8);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		_wrapper.setWidth(H.MIN_WIDTH + 2);
		_wrapper.setHeight(8);
		setLayoutSize(H.MIN_WIDTH + 1, 8 - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + 1, 8 + H.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH + 2, 8);
		assertScrollBarsShowedSoft(true, false);
	}
	
	@Test
	public function hAutoVOff_noWrapper()
	{
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.OFF);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH - 1, 8);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, 8);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + 1, 100);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + 1, 100);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH, -1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, 0);
		assertScrollBarsShowedSoft(false, false);
	}
	
	@Test
	public function hAutoVOff_scale_cases()
	{
		_wrapper.setHeight(8);
		_layout.wrapper = _wrapper.setPercents(100, -1);
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.OFF);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH - 1, 8 - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, 8);
		assertWrapperSize(H.MIN_WIDTH, 8);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + 1, 8 - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + 1, 8);
		assertWrapperSize(H.MIN_WIDTH + 1, 8);
		assertScrollBarsShowedSoft(false, false);
		
		_wrapper.setWidth(9);
		_wrapper.setHeight(2);
		_layout.wrapper = _wrapper.setPercents(-1, 100);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH - 1, 10);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, 10);
		assertWrapperSize(9, 10);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + 1, 10);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + 1, 10);
		assertWrapperSize(9, 10);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		_wrapper.setWidth(H.MIN_WIDTH + 2);
		setLayoutSize(H.MIN_WIDTH + 2, H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + 2, H.MIN_HEIGHT - 1);
		assertWrapperSize(H.MIN_WIDTH + 2, H.MIN_HEIGHT - 1);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		_wrapper.setWidth(H.MIN_WIDTH + 2);
		setLayoutSize(H.MIN_WIDTH + 1, H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + 1, H.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH + 2, 0);
		assertScrollBarsShowedSoft(true, false);
		
		_wrapper.setHeight(2);
		_wrapper.setHeight(3);
		_layout.wrapper = _wrapper.setPercents(100, 100);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH - 1, 10);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, 10);
		assertWrapperSize(H.MIN_WIDTH, 10);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + 10, 200);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + 10, 200);
		assertWrapperSize(H.MIN_WIDTH + 10, 200);
		assertScrollBarsShowedSoft(false, false);
	}
	
	@Test
	public function hAutoVOff_constrainedScale_cases()
	{
		_wrapper.setHeight(8);
		_layout.wrapper = _wrapper.setPercents(100, 100).setContingencies(100, 150, 200, 250);
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.OFF);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH - 1, 8 - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH, 200 + H.MIN_HEIGHT);
		assertWrapperSize(100, 200);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setLayoutSize(100 - 1, 250 + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(100 - 1, 250 + H.MIN_HEIGHT);
		assertWrapperSize(100, 250);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setLayoutSize(150 + 1, 200 - 1);
		_layout.arrange();
		assertLayoutSize(150 + 1, 200);
		assertWrapperSize(150, 200);
		assertScrollBarsShowedSoft(false, false);
		
		setLayoutSize(150, 250);
		_layout.arrange();
		assertLayoutSize(150, 250);
		assertWrapperSize(150, 250);
		assertScrollBarsShowedSoft(false, false);
	}
	
	@Test
	public function hAutoVOff_widthForHeight()
	{
		_wrapper = new CChildWrapper(new HeightByWidthSprite()).setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.OFF);
		
		resetScrollBars();
		setLayoutSize(100, 10);
		_layout.arrange();
		assertLayoutSize(100, HeightByWidthSprite.getHeight(100));
		assertWrapperSize(100, HeightByWidthSprite.getHeight(100));
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		_wrapper.setPercents(100, -1);
		_wrapper.setWidth(20);
		setLayoutSize(100, 10);
		_layout.arrange();
		assertLayoutSize(100, HeightByWidthSprite.getHeight(100));
		assertWrapperSize(100, HeightByWidthSprite.getHeight(100));
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		_wrapper.setContingencies(150);
		_wrapper.setPercents(100, 100);
		setLayoutSize(150, 10);
		_layout.arrange();
		assertLayoutSize(150, HeightByWidthSprite.getHeight(150));
		assertWrapperSize(150, HeightByWidthSprite.getHeight(150));
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		_wrapper.setContingencies(150);
		_wrapper.setPercents(100, 100);
		setLayoutSize(150 - 1, 10);
		_layout.arrange();
		assertLayoutSize(150 - 1, HeightByWidthSprite.getHeight(150) + H.MIN_HEIGHT);
		assertWrapperSize(150, HeightByWidthSprite.getHeight(150));
		assertScrollBarsShowedSoft(true, false);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  CScrollPolicy.AUTO, CScrollPolicy.ON
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function hAutoVOn_noScale_cases()
	{
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.ON);
		
		resetScrollBars();
		_wrapper.setWidth(5);
		_wrapper.setHeight(8);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT);
		assertWrapperSize(5, 8);
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		_wrapper.setWidth(5);
		_wrapper.setHeight(8);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT);
		assertWrapperSize(5, 8);
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		_wrapper.setWidth(H.MIN_WIDTH + 2);
		_wrapper.setHeight(8);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH + 2, 8);
		assertScrollBarsShowedSoft(true, true);
		
		resetScrollBars();
		_wrapper.setWidth(H.MIN_WIDTH);
		_wrapper.setHeight(V.MIN_HEIGHT + 1);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH, V.MIN_HEIGHT + 1);
		assertScrollBarsShowedSoft(false, true);
	}
	
	@Test
	public function hAutoVOn_noWrapper()
	{
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.ON);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT);
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT);
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT);
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT + 1);
		assertScrollBarsShowedSoft(false, true);
	}
	
	@Test
	public function hAutoVOn_scale_cases()
	{
		_wrapper.setHeight(8);
		_layout.wrapper = _wrapper.setPercents(100, -1);
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.ON);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, 8 - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH, 8);
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT + 1);
		assertWrapperSize(H.MIN_WIDTH + 1, 8);
		assertScrollBarsShowedSoft(false, true);
		
		_wrapper.setPercents( -1, 100);
		
		resetScrollBars();
		_wrapper.setWidth(H.MIN_WIDTH + 1);
		_wrapper.setHeight(2);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		assertWrapperSize(H.MIN_WIDTH + 1, V.MIN_HEIGHT + 1);
		assertScrollBarsShowedSoft(true, true);
		
		resetScrollBars();
		_wrapper.setWidth(H.MIN_WIDTH);
		_wrapper.setHeight(2);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		assertWrapperSize(H.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		assertScrollBarsShowedSoft(false, true);
	}
	
	@Test
	public function hAutoVOn_constrainedScale_cases()
	{
		_wrapper.setHeight(8);
		_layout.wrapper = _wrapper.setPercents(100, 100).setContingencies(100, 150, 200, 250);
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.ON);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, H.MIN_HEIGHT + V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, H.MIN_HEIGHT + V.MIN_HEIGHT);
		assertWrapperSize(100, 200);
		assertScrollBarsShowedSoft(true, true);
		
		resetScrollBars();
		setLayoutSize(150 + V.MIN_WIDTH + 1, 250 + V.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(150 + V.MIN_WIDTH + 1, 250 + V.MIN_HEIGHT + 1);
		assertWrapperSize(150, 250);
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		setLayoutSize(150 + V.MIN_WIDTH, 250 + V.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(150 + V.MIN_WIDTH, 250 + V.MIN_HEIGHT);
		assertWrapperSize(150, 250);
		assertScrollBarsShowedSoft(false, true);
	}
	
	@Test
	public function hAutoVOn_widthForHeight()
	{
		_wrapper = new CChildWrapper(new HeightByWidthSprite()).setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.ON);
		
		resetScrollBars();
		setLayoutSize(100 + V.MIN_WIDTH, 200);
		_layout.arrange();
		assertLayoutSize(100 + V.MIN_WIDTH, 200);
		assertWrapperSize(100, HeightByWidthSprite.getHeight(100));
		assertScrollBarsShowedSoft(false, true);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  CScrollPolicy.OFF, CScrollPolicy.AUTO
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function hOffVAuto_noScale_cases()
	{
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.OFF, CScrollPolicy.AUTO);
		
		resetScrollBars();
		setWrapperSize(5, 8);
		setLayoutSize(5 + V.MIN_WIDTH - 1, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(5 + V.MIN_WIDTH, V.MIN_HEIGHT);
		assertWrapperSize(5, 8);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setWrapperSize(5, 8);
		setLayoutSize(5 + V.MIN_WIDTH + 1, V.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(5 + V.MIN_WIDTH, V.MIN_HEIGHT + 1);
		assertWrapperSize(5, 8);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setWrapperSize(5, V.MIN_HEIGHT + 2);
		setLayoutSize(100, V.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(5 + V.MIN_WIDTH, V.MIN_HEIGHT + 1);
		assertWrapperSize(5, V.MIN_HEIGHT + 2);
		assertScrollBarsShowedSoft(false, true);
	}
	
	@Test
	public function hOffVAuto_noWrapper()
	{
		setLayoutScrollPolicy(CScrollPolicy.OFF, CScrollPolicy.AUTO);
		
		resetScrollBars();
		setLayoutSize(V.MIN_WIDTH - 1, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH, V.MIN_HEIGHT);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(V.MIN_WIDTH + 1, V.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH + 1, V.MIN_HEIGHT + 1);
		assertScrollBarsShowedSoft(false, false);
	}
	
	@Test
	public function hOffVAuto_scale_cases()
	{
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.OFF, CScrollPolicy.AUTO);
		
		_wrapper.setWidth(8);
		_wrapper.setPercents(-1, 100);
		
		resetScrollBars();
		setLayoutSize(8 + V.MIN_WIDTH - 1, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(8 + V.MIN_WIDTH, V.MIN_HEIGHT);
		assertWrapperSize(8, V.MIN_HEIGHT);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(8 + V.MIN_WIDTH + 1, V.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(8 + V.MIN_WIDTH, V.MIN_HEIGHT + 1);
		assertWrapperSize(8, V.MIN_HEIGHT + 1);
		assertScrollBarsShowedSoft(false, false);
		
		_wrapper.setPercents(100, -1);
		
		resetScrollBars();
		setWrapperSize(2, 9);
		setLayoutSize(V.MIN_WIDTH - 1, V.MIN_HEIGHT + 10);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH, V.MIN_HEIGHT + 10);
		assertWrapperSize(V.MIN_WIDTH, 9);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setWrapperSize(2, V.MIN_HEIGHT + 10 + 1);
		setLayoutSize(V.MIN_WIDTH - 1, V.MIN_HEIGHT + 10);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH, V.MIN_HEIGHT + 10);
		assertWrapperSize(0, V.MIN_HEIGHT + 10 + 1);
		assertScrollBarsShowedSoft(false, true);
	}
	
	@Test
	public function vOffHAuto_constrainedScale_cases()
	{
		_layout.wrapper = _wrapper.setPercents(100, 100).setContingencies(100, 150, 200, 250);
		setLayoutScrollPolicy(CScrollPolicy.OFF, CScrollPolicy.AUTO);
		
		resetScrollBars();
		setLayoutSize(100 + V.MIN_WIDTH - 1, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(100 + V.MIN_WIDTH, V.MIN_HEIGHT);
		assertWrapperSize(100, 200);
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		setLayoutSize(100 + V.MIN_WIDTH - 1, 200);
		_layout.arrange();
		assertLayoutSize(100 + V.MIN_WIDTH, 200);
		assertWrapperSize(100 + V.MIN_WIDTH, 200);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(150 + V.MIN_WIDTH + 1, V.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(150 + V.MIN_WIDTH, V.MIN_HEIGHT);
		assertWrapperSize(150, 200);
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		setLayoutSize(150 + V.MIN_WIDTH + 1, 250 + 1);
		_layout.arrange();
		assertLayoutSize(150 + V.MIN_WIDTH, 250 + 1);
		assertWrapperSize(150, 250);
		assertScrollBarsShowedSoft(false, false);
	}
	
	@Test
	public function vOffHAuto_widthForHeight()
	{
		_wrapper = new CChildWrapper(new HeightByWidthSprite()).setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.OFF, CScrollPolicy.AUTO);
		
		/*
		                14
		               |--|
		               |  |
		               |  | 20
		               |  |
		   |-----------|--|
		10 |-----------| 
		        22
		*/
		
		resetScrollBars();
		setLayoutSize(14, HeightByWidthSprite.getHeight(14) + 1);
		_layout.arrange();
		assertLayoutSize(14, HeightByWidthSprite.getHeight(14) + 1);
		assertWrapperSize(14, HeightByWidthSprite.getHeight(14));
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(15, HeightByWidthSprite.getHeight(15) - 1);
		_layout.arrange();
		assertLayoutSize(15, HeightByWidthSprite.getHeight(15) - 1);
		assertWrapperSize(1, HeightByWidthSprite.getHeight(1));
		assertScrollBarsShowedSoft(false, true);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  CScrollPolicy.ON, CScrollPolicy.AUTO
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function hOnVAuto_noScale_cases()
	{
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.AUTO);
		
		setWrapperSize(5, 8);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		assertWrapperSize(5, 8);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT + H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT + H.MIN_HEIGHT);
		assertWrapperSize(5, 8);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		assertWrapperSize(5, 8);
		assertScrollBarsShowedSoft(true, false);
		
		setWrapperSize(5, V.MIN_HEIGHT + 2);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 10, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 10, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		assertWrapperSize(5, V.MIN_HEIGHT + 2);
		assertScrollBarsShowedSoft(true, true);
		
		resetScrollBars();
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 10, V.MIN_HEIGHT + H.MIN_HEIGHT + 2);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 10, V.MIN_HEIGHT + H.MIN_HEIGHT + 2);
		assertWrapperSize(5, V.MIN_HEIGHT + 2);
		assertScrollBarsShowedSoft(true, false);
	}
	
	@Test
	public function hOnVAuto_noWrapper()
	{
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.AUTO);
		
		resetScrollBars();
		setLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH + 1, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH + 1, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		assertScrollBarsShowedSoft(true, false);
	}
	
	@Test
	public function hOnVAuto_scale_cases()
	{
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.AUTO);
		
		_wrapper.setPercents(-1, 100);
		
		resetScrollBars();
		setWrapperSize(H.MIN_WIDTH - 2, 0);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH - 2, V.MIN_HEIGHT);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setWrapperSize(H.MIN_WIDTH + 2, 0);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH + 1, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		assertWrapperSize(H.MIN_WIDTH + 2, V.MIN_HEIGHT + 1);
		assertScrollBarsShowedSoft(true, false);
		
		_wrapper.setPercents(100, -1);
		
		resetScrollBars();
		setWrapperSize(0, V.MIN_HEIGHT - 2);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		assertWrapperSize(V.MIN_WIDTH + H.MIN_WIDTH, V.MIN_HEIGHT - 2);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setWrapperSize(0, V.MIN_HEIGHT + 1);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH, V.MIN_HEIGHT + 1);
		assertScrollBarsShowedSoft(true, true);
		
		resetScrollBars();
		setWrapperSize(0, V.MIN_HEIGHT + 2);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		assertWrapperSize(H.MIN_WIDTH, V.MIN_HEIGHT + 2);
		assertScrollBarsShowedSoft(true, true);
	}
	
	@Test
	public function vOnHAuto_constrainedScale_cases()
	{
		_layout.wrapper = _wrapper.setPercents(100, 100).setContingencies(100, 150, 200, 250);
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.AUTO);
		
		resetScrollBars();
		setLayoutSize(100 + V.MIN_WIDTH - 1, 200 + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(100 + V.MIN_WIDTH - 1, 200 + H.MIN_HEIGHT - 1);
		assertWrapperSize(100, 200);
		assertScrollBarsShowedSoft(true, true);
		
		resetScrollBars();
		setLayoutSize(100 + V.MIN_WIDTH - 1, 200 + H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(100 + V.MIN_WIDTH - 1, 200 + H.MIN_HEIGHT);
		assertWrapperSize(100 + V.MIN_WIDTH - 1, 200);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setLayoutSize(100 + V.MIN_WIDTH - 1, 200 + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(100 + V.MIN_WIDTH - 1, 200 + H.MIN_HEIGHT + 1);
		assertWrapperSize(100 + V.MIN_WIDTH - 1, 200 + 1);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setLayoutSize(150 + V.MIN_WIDTH - 1, 200 + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(150 + V.MIN_WIDTH - 1, 200 + H.MIN_HEIGHT - 1);
		assertWrapperSize(150 - 1, 200);
		assertScrollBarsShowedSoft(true, true);
		
		resetScrollBars();
		setLayoutSize(150 + 1, 200 + H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(150 + 1, 200 + H.MIN_HEIGHT);
		assertWrapperSize(150, 200);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setLayoutSize(125, 250 + H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(125, 250 + H.MIN_HEIGHT);
		assertWrapperSize(125, 250);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setLayoutSize(125, 250 + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(125, 250 + H.MIN_HEIGHT + 1);
		assertWrapperSize(125, 250);
		assertScrollBarsShowedSoft(true, false);
	}
	
	@Test
	public function vOnHAuto_widthForHeight()
	{
		_wrapper = new CChildWrapper(new BigHeightByWidthSprite()).setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.ON, CScrollPolicy.AUTO);
		
		resetScrollBars();
		setLayoutSize(100, BigHeightByWidthSprite.getHeight(100) + H.MIN_WIDTH + 1);
		_layout.arrange();
		assertLayoutSize(100, BigHeightByWidthSprite.getHeight(100) + H.MIN_WIDTH + 1);
		assertWrapperSize(100, BigHeightByWidthSprite.getHeight(100));
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setLayoutSize(100, BigHeightByWidthSprite.getHeight(100) + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(100, BigHeightByWidthSprite.getHeight(100) + H.MIN_HEIGHT - 1);
		assertWrapperSize(100 - V.MIN_WIDTH, BigHeightByWidthSprite.getHeight(100 - V.MIN_WIDTH));
		assertScrollBarsShowedSoft(true, true);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  CScrollPolicy.AUTO, CScrollPolicy.AUTO
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function hAutoVAuto_noWrapper()
	{
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.AUTO);
		
		resetScrollBars();
		setLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH + 1, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		_layout.arrange();
		assertLayoutSize(V.MIN_WIDTH + H.MIN_WIDTH + 1, V.MIN_HEIGHT + H.MIN_HEIGHT + 1);
		assertScrollBarsShowedSoft(false, false);
	}
	
	@Test
	public function hAutoVAuto_noScale_cases()
	{
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.AUTO);
		
		resetScrollBars();
		setWrapperSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT - 1);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT - 1);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setWrapperSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH - 1, V.MIN_HEIGHT + H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setWrapperSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setWrapperSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT + 1);
		setLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(H.MIN_WIDTH + V.MIN_WIDTH, V.MIN_HEIGHT + H.MIN_HEIGHT);
		assertWrapperSize(H.MIN_WIDTH + V.MIN_WIDTH + 1, V.MIN_HEIGHT + 1);
		assertScrollBarsShowedSoft(true, true);
		
		resetScrollBars();
		setWrapperSize(100 + 1, 200);
		setLayoutSize(100, 200 + H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(100, 200 + H.MIN_HEIGHT);
		assertWrapperSize(100 + 1, 200);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setWrapperSize(100 + 1, 200);
		setLayoutSize(100, 200 + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(100, 200 + H.MIN_HEIGHT - 1);
		assertWrapperSize(100 + 1, 200);
		assertScrollBarsShowedSoft(true, true);
		
		resetScrollBars();
		setWrapperSize(100, 200 + 1);
		setLayoutSize(100 + V.MIN_WIDTH, 200);
		_layout.arrange();
		assertLayoutSize(100 + V.MIN_WIDTH, 200);
		assertWrapperSize(100, 200 + 1);
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		setWrapperSize(100, 200 + 1);
		setLayoutSize(100 + V.MIN_WIDTH - 1, 200);
		_layout.arrange();
		assertLayoutSize(100 + V.MIN_WIDTH - 1, 200);
		assertWrapperSize(100, 200 + 1);
		assertScrollBarsShowedSoft(true, true);
	}
	
	@Test
	public function hAutoVAuto_scale_cases()
	{
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.AUTO);
		
		_wrapper.setPercents(-1, 100);
		
		resetScrollBars();
		setWrapperSize(100 - 1, 0);
		setLayoutSize(100, 200);
		_layout.arrange();
		assertLayoutSize(100, 200);
		assertWrapperSize(100 - 1, 200);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setWrapperSize(100, 0);
		setLayoutSize(100, 200);
		_layout.arrange();
		assertLayoutSize(100, 200);
		assertWrapperSize(100, 200);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setWrapperSize(100 + 1, 0);
		setLayoutSize(100, 200);
		_layout.arrange();
		assertLayoutSize(100, 200);
		assertWrapperSize(100 + 1, 200 - H.MIN_HEIGHT);
		assertScrollBarsShowedSoft(true, false);
	}
	
	@Test
	public function hAutoVAuto_constrainedScale_minimal_cases()
	{
		_layout.wrapper = _wrapper.setPercents(100, 100).setContingencies(100, 150, 200, 250);
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.AUTO);
		
		resetScrollBars();
		setLayoutSize(100 - 1, 200 + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(100 - 1, 200 + H.MIN_HEIGHT - 1);
		assertWrapperSize(100, 200);
		assertScrollBarsShowedSoft(true, true);
		
		resetScrollBars();
		setLayoutSize(100 + V.MIN_WIDTH - 1, 200 - 1);
		_layout.arrange();
		assertLayoutSize(100 + V.MIN_WIDTH - 1, 200 - 1);
		assertWrapperSize(100, 200);
		assertScrollBarsShowedSoft(true, true);
		
		resetScrollBars();
		setLayoutSize(100, 200);
		_layout.arrange();
		assertLayoutSize(100, 200);
		assertWrapperSize(100, 200);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(100 - 1, 200 + H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(100 - 1, 200 + H.MIN_HEIGHT);
		assertWrapperSize(100, 200);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setLayoutSize(100 + V.MIN_WIDTH, 200 - 1);
		_layout.arrange();
		assertLayoutSize(100 + V.MIN_WIDTH, 200 - 1);
		assertWrapperSize(100, 200);
		assertScrollBarsShowedSoft(false, true);
	}
	
	@Test
	public function hAutoVAuto_constrainedScale_maximal_cases()
	{
		_layout.wrapper = _wrapper.setPercents(100, 100).setContingencies(100, 150, 200, 250);
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.AUTO);
		
		resetScrollBars();
		setLayoutSize(150 + 1, 210);
		_layout.arrange();
		assertLayoutSize(150 + 1, 210);
		assertWrapperSize(150, 210);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(150 + V.MIN_WIDTH, 200 - 1);
		_layout.arrange();
		assertLayoutSize(150 + V.MIN_WIDTH, 200 - 1);
		assertWrapperSize(150, 200);
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		setLayoutSize(150 + V.MIN_WIDTH - 1, 200 - 1);
		_layout.arrange();
		assertLayoutSize(150 + V.MIN_WIDTH - 1, 200 - 1);
		assertWrapperSize(150 - 1, 200);
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		setLayoutSize(120, 250 + 1);
		_layout.arrange();
		assertLayoutSize(120, 250 + 1);
		assertWrapperSize(120, 250);
		assertScrollBarsShowedSoft(false, false);
		
		resetScrollBars();
		setLayoutSize(100 - 1, 250 + H.MIN_HEIGHT);
		_layout.arrange();
		assertLayoutSize(100 - 1, 250 + H.MIN_HEIGHT);
		assertWrapperSize(100, 250);
		assertScrollBarsShowedSoft(true, false);
		
		resetScrollBars();
		setLayoutSize(100 - 1, 250 + H.MIN_HEIGHT - 1);
		_layout.arrange();
		assertLayoutSize(100 - 1, 250 + H.MIN_HEIGHT - 1);
		assertWrapperSize(100, 250 - 1);
		assertScrollBarsShowedSoft(true, false);
	}
	
	@Test
	public function hAutoVAuto_widthForHeight()
	{
		_wrapper = new CChildWrapper(new BigHeightByWidthSprite()).setPercents(100, 100);
		_layout.wrapper = _wrapper;
		setLayoutScrollPolicy(CScrollPolicy.AUTO, CScrollPolicy.AUTO);
		
		resetScrollBars();
		setLayoutSize(100, BigHeightByWidthSprite.getHeight(100) - 1);
		_layout.arrange();
		assertLayoutSize(100, BigHeightByWidthSprite.getHeight(100) - 1);
		assertWrapperSize(100 - V.MIN_WIDTH, BigHeightByWidthSprite.getHeight(100 - V.MIN_WIDTH));
		assertScrollBarsShowedSoft(false, true);
		
		resetScrollBars();
		setLayoutSize(100, BigHeightByWidthSprite.getHeight(100));
		_layout.arrange();
		assertLayoutSize(100, BigHeightByWidthSprite.getHeight(100));
		assertWrapperSize(100, BigHeightByWidthSprite.getHeight(100));
		assertScrollBarsShowedSoft(false, false);
	}
}
/*
Автоматический режим при отсутствии контента

AUTO: Если контент вписывается в общую область скроллирования, скроллеры не должны появляться
Зависимость высотры контента от ширины
Появление прокруток при зависимости высотры от ширины
Компактный режим по высоте и ширине
*/