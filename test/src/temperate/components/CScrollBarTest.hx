package temperate.components;

import massive.munit.Assert;
import temperate.skins.CNullScrollSkin;

class CScrollBarTest
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
		for (sb in [newScrollBar(true), newScrollBar(true)])
		{
			Assert.areEqual(1, sb.pageSize);
			Assert.areEqual(1, sb.pageScrollSize);
			Assert.areEqual(1, sb.lineScrollSize);
		}
	}
}
/*
Протестировать настройку значения скроллинга по странице (при несовпадении с размером страницы)
*/