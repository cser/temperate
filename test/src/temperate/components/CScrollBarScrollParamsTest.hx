package temperate.components;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.Lib;
import massive.munit.Assert;
import temperate.errors.CArgumentError;
import temperate.raster.Scale3GridDrawer;
import temperate.skins.CNullScrollSkin;
import temperate.skins.CRasterRectSkin;
import temperate.skins.CRasterScrollDrawedSkin;
import temperate.skins.CSkinState;

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
			horizontal, new ACButton(), new ACButton(), new ACButton(),
			CNullScrollSkin.getInstance());
	}
	
	@Test
	public function defaultScrollParameters()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			Assert.areEqual(1, sb.pageSize);
			Assert.areEqual(1, sb.pageScrollSize);
			Assert.areEqual(1, sb.lineScrollSize);
		}
	}
	
	@Test
	public function lineScrollSize_setterNormalCases()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			sb.lineScrollSize = 2;
			Assert.areEqual(2, sb.lineScrollSize);
			sb.lineScrollSize = .1;
			Assert.areEqual(.1, sb.lineScrollSize);
		}
	}
	
	@Test
	public function lineScrollSize_mastBeFiniteAndMoreThanZero()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			try
			{
				sb.lineScrollSize = Math.NaN;
				Assert.fail("Exception mast throws");
			}
			catch (error:CArgumentError)
			{
				Assert.isTrue(Std.string(error.message).indexOf("mast be finite") != -1);
				Assert.areEqual(1, sb.lineScrollSize);
			}
			
			for (value in [0., -.1])
			{
				try
				{
					sb.lineScrollSize = value;
					Assert.fail("Exception mast throws");
				}
				catch (error:CArgumentError)
				{
					Assert.isTrue(Std.string(error.message).indexOf("mast be positive") != -1);
					Assert.areEqual(1, sb.lineScrollSize);
				}
			}
		}
	}
	
	@Test
	public function pageSize_isEqualTo_lineScrollSize_ifItsNotSettedOrSettedNaN()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			sb.lineScrollSize = 2;
			Assert.areEqual(2, sb.pageSize);
			sb.lineScrollSize = .1;
			Assert.areEqual(.1, sb.pageSize);
		}
		
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			sb.lineScrollSize = 2;
			
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
			Assert.areEqual(sb.lineScrollSize, sb.pageSize);
			
			sb.pageSize = Math.POSITIVE_INFINITY;
			Assert.areEqual(sb.lineScrollSize, sb.pageSize);
			
			for (value in [0., -.1])
			{
				try
				{
					sb.pageSize = 1.1;
					sb.pageSize = value;
					Assert.fail("Exception mast throws");
				}
				catch (error:CArgumentError)
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
	public function pageScrollSize_isEqualTo_pageSize_ifItsNotSettedOrSettedNaN()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			sb.lineScrollSize = .1;
			Assert.areEqual(.1, sb.pageScrollSize);
			sb.pageSize = 1.5;
			sb.lineScrollSize = .2;
			Assert.areEqual(1.5, sb.pageScrollSize);
			
			sb.pageScrollSize = 3.1;
			Assert.areEqual(3.1, sb.pageScrollSize);
			sb.pageScrollSize = Math.NaN;
			Assert.areEqual(1.5, sb.pageSize);
		}
	}
	
	@Test
	public function pageScrollSize_canBeSettedOnlyPositiveOrNotFiniteValues()
	{
		for (sb in [newScrollBar(true), newScrollBar(false)])
		{
			sb.pageScrollSize = .1;
			Assert.areEqual(.1, sb.pageScrollSize);
			
			sb.pageScrollSize = Math.NaN;
			Assert.areEqual(sb.pageSize, sb.pageScrollSize);
			
			sb.pageSize = Math.POSITIVE_INFINITY;
			Assert.areEqual(sb.pageSize, sb.pageScrollSize);
			
			for (value in [0., -.1])
			{
				try
				{
					sb.pageScrollSize = 1.1;
					sb.pageScrollSize = value;
					Assert.fail("Exception mast throws");
				}
				catch (error:CArgumentError)
				{
					var text = Std.string(error.message);
					Assert.isTrue(
						text.indexOf("mast be positive") != -1 && text.indexOf("NaN") != -1
					);
					Assert.areEqual(1.1, sb.pageScrollSize);
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
			
			sb.addEventListener(Event.SCROLL, onScroll);
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
		
		var skin = new CRasterScrollDrawedSkin(bd, new Scale3GridDrawer(horizontal), 10);
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
			
			sb.addEventListener(Event.SCROLL, onScroll);
			_log = [];
			{
				var object =
					Lib.current.getObjectsUnderPoint(new Point(sb.width * .5, sb.height * .5))[0];
				
				object.dispatchEvent(
					new MouseEvent(
						MouseEvent.MOUSE_WHEEL, true, false, 0, 0, null, false, false, false, false, 3
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