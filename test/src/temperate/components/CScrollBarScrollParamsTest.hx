package temperate.components;

import massive.munit.Assert;
import temperate.errors.CArgumentError;
import temperate.skins.CNullScrollSkin;

class CScrollBarScrollParamsTest
{
	public function new()
	{
	}
	
	@Before
	public function setUp():Void
	{
		
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
}