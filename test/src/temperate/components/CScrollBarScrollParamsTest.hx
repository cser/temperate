package temperate.components;

import flash.display.BitmapData;
import flash.errors.ArgumentError;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.Lib;
import massive.munit.Assert;
import temperate.raster.CScale3GridDrawer;
import temperate.skins.CNullScrollSkin;
import temperate.skins.CRasterScrollDrawedSkin;

class CScrollBarScrollParamsTest
{
	public function new()
	{
	}
	
	var _log:Array<String>;
	
	@Before
	public function setUp():Void
	{
		_log = [];
	}
	
	@After
	public function tearDown():Void
	{
		
	}
	
	function newScrollBar(horizontal:Bool)
	{
		return new CScrollBar(
			horizontal, new FakeEmptyButton(), new FakeEmptyButton(), new FakeEmptyButton(),
			CNullScrollSkin.getInstance());
	}
	
	@Test
	public function defaultScrollParameters()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			Assert.areEqual(1, sb.pageSize);
			Assert.areEqual(1, sb.pageStep);
			Assert.areEqual(1, sb.step);
		}
	}
	
	@Test
	public function step_setterNormalCases()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			sb.step = 2;
			Assert.areEqual(2, sb.step);
			sb.step = .1;
			Assert.areEqual(.1, sb.step);
		}
	}
	
	@Test
	public function step_mastBeFiniteAndMoreThanZero()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			try
			{
				sb.step = Math.NaN;
				Assert.fail("Exception mast throws");
			}
			catch (error:ArgumentError)
			{
				Assert.isTrue(Std.string(error.message).indexOf("mast be finite") != -1);
				Assert.areEqual(1, sb.step);
			}
			
			for (value in [0., -.1])
			{
				try
				{
					sb.step = value;
					Assert.fail("Exception mast throws");
				}
				catch (error:ArgumentError)
				{
					Assert.isTrue(Std.string(error.message).indexOf("mast be positive") != -1);
					Assert.areEqual(1, sb.step);
				}
			}
		}
	}
	
	@Test
	public function pageSize_isEqualTo_step_ifItsNotSettedOrSettedNaN()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			sb.step = 2;
			Assert.areEqual(2, sb.pageSize);
			sb.step = .1;
			Assert.areEqual(.1, sb.pageSize);
		}
		
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			sb.step = 2;
			
			sb.pageSize = 1;
			Assert.areEqual(1, sb.pageSize);
			sb.pageSize = .5;
			Assert.areEqual(.5, sb.pageSize);
			
			sb.pageSize = Math.NaN;
			Assert.areEqual(2, sb.pageSize);
		}
	}
	
	@Test
	public function pageSize_canBeSettedOnlyPositiveOrNotFiniteValues()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			sb.pageSize = .1;
			Assert.areEqual(.1, sb.pageSize);
			
			sb.pageSize = Math.NaN;
			Assert.areEqual(sb.step, sb.pageSize);
			
			sb.pageSize = Math.POSITIVE_INFINITY;
			Assert.areEqual(sb.step, sb.pageSize);
			
			for (value in [0., -.1])
			{
				try
				{
					sb.pageSize = 1.1;
					sb.pageSize = value;
					Assert.fail("Exception mast throws");
				}
				catch (error:ArgumentError)
				{
					var text = Std.string(error.message);
					Assert.isTrue(
						text.indexOf("mast be positive") != -1 && text.indexOf("NaN") != -1
					);
					Assert.areEqual(1.1, sb.pageSize);
				}
			}
		}
	}
	
	@Test
	public function pageStep_isEqualTo_pageSize_ifItsNotSettedOrSettedNaN()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			sb.step = .1;
			Assert.areEqual(.1, sb.pageStep);
			sb.pageSize = 1.5;
			sb.step = .2;
			Assert.areEqual(1.5, sb.pageStep);
			
			sb.pageStep = 3.1;
			Assert.areEqual(3.1, sb.pageStep);
			sb.pageStep = Math.NaN;
			Assert.areEqual(1.5, sb.pageSize);
		}
	}
	
	@Test
	public function pageStep_canBeSettedOnlyPositiveOrNotFiniteValues()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			sb.pageStep = .1;
			Assert.areEqual(.1, sb.pageStep);
			
			sb.pageStep = Math.NaN;
			Assert.areEqual(sb.pageSize, sb.pageStep);
			
			sb.pageSize = Math.POSITIVE_INFINITY;
			Assert.areEqual(sb.pageSize, sb.pageStep);
			
			for (value in [0., -.1])
			{
				try
				{
					sb.pageStep = 1.1;
					sb.pageStep = value;
					Assert.fail("Exception mast throws");
				}
				catch (error:ArgumentError)
				{
					var text = Std.string(error.message);
					Assert.isTrue(
						text.indexOf("mast be positive") != -1 && text.indexOf("NaN") != -1
					);
					Assert.areEqual(1.1, sb.pageStep);
				}
			}
		}
	}
	
	@Test
	public function whenValueSetted_eventIsNotDispatched()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			_log = [];
			
			sb.addEventListener(Event.CHANGE, onScroll);
			sb.minValue = 10;
			sb.maxValue = 100;
			Assert.areEqual(10, sb.value);
			
			sb.value = 20;
			Assert.areEqual(20, sb.value);
			ArrayAssert.areEqual([], _log);
			
			sb.minValue = 21;
			Assert.areEqual(21, sb.value);
			ArrayAssert.areEqual([], _log);
			
			sb.value = 100;
			sb.maxValue = 80;
			Assert.areEqual(80, sb.value);
			ArrayAssert.areEqual([], _log);
		}
	}
	
	function newVisualScrollBar(horizontal:Bool)
	{
		var bd = new BitmapData(10, 10, true, 0xff808080);
		
		var left = new CRasterFixedButton();
		left.getState(CButtonState.UP).setBitmapData(bd);
		
		var right = new CRasterFixedButton();
		right.getState(CButtonState.UP).setBitmapData(bd);
		
		var thumb = new CRasterFixedButton();
		thumb.getState(CButtonState.UP).setBitmapData(bd);
		
		var skin = new CRasterScrollDrawedSkin(bd, new CScale3GridDrawer(horizontal), 10);
		return new CScrollBar(horizontal, left, right, thumb, skin);
	}
	
	function getTopObject(globalX:Float, globalY:Float)
	{
		var objects = Lib.current.getObjectsUnderPoint(new Point(globalX, globalY));
		return objects[objects.length - 1];
	}
	
	@Test
	
	/*
	All user's action is dificult to test, paticulary testing
	*/
	public function whenValueChangedByUser_eventIsDispatched()
	{
		for (horizontal in [ true, false ])
		{
			var sb = newVisualScrollBar(horizontal);
			
			Lib.current.addChild(sb);
			
			sb.minValue = 10;
			sb.maxValue = 100;
			sb.value = 45;
			sb.validate();
			
			sb.addEventListener(Event.CHANGE, onScroll);
			_log = [];
			{
				var object =
					Lib.current.getObjectsUnderPoint(new Point(sb.width * .5, sb.height * .5))[0];
				
				object.dispatchEvent(
					new MouseEvent(
						MouseEvent.MOUSE_WHEEL, true, false, 0, 0, null, false, false, false, false,
						3
					)
				);
				ArrayAssert.areEqual(["scroll"], _log);
			}
			{
				// Left button point
				var object = getTopObject(5, 5);
				object.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, true));
				object.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true));
				ArrayAssert.areEqual(["scroll", "scroll"], _log);
			}
			{
				// Right button point
				var object = horizontal ?
					getTopObject(sb.width - 5, 5) :
					getTopObject(5, sb.height - 5);
				object.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, true));
				object.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true));
				ArrayAssert.areEqual(["scroll", "scroll", "scroll"], _log);
			}
			
			Lib.current.removeChild(sb);
		}
	}
	
	function onScroll(event:Event)
	{
		_log.push("scroll");
	}
}