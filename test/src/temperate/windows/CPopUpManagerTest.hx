package temperate.windows;

import flash.display.Sprite;
import massive.munit.Assert;
using massive.munit.Assert;

class CPopUpManagerTest
{
	public function new()
	{
	}
	
	var _manager:CPopUpManager;
	var _container:Sprite;
	
	@Before
	public function setUp():Void
	{
		_container = new Sprite();
		_manager = new CPopUpManager(_container);
	}
	
	@Test
	public function addPopUp()
	{
		var popUp = new FakePopUp();
		_manager.add(popUp, false);
		popUp.view.parent.areEqual(_container);
	}
	
	@Test
	public function removePopUp()
	{
		var popUp = new FakePopUp();
		_manager.add(popUp, false);
		_manager.remove(popUp);
		popUp.view.parent.isNull();
	}
}