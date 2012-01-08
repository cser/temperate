package temperate.containers;

import flash.Lib;
import haxe.PosInfos;
import massive.munit.Assert;

class CVContainerChangeLayoutByChildManagmentTest
{
	public function new()
	{
	}
	
	var _container:CVBox;
	var _child:Array<FakeSprite>;
	
	@Before
	public function setUp():Void
	{
		_container = new CVBox();
		_container.setCompact(true, true);
		_container.gapY = 2;
		_child = [
			newFakeSprite(100, 10),
			newFakeSprite(110, 20),
			newFakeSprite(90, 30)
		];
	}
	
	public function newFakeSprite(width:Float, height:Float)
	{
		var sprite = new FakeSprite();
		sprite.setSize(width, height);
		return sprite;
	}
	
	@After
	public function tearDown():Void
	{
		_container = null;
	}
	
	function checkSize(width:Int, height:Int, ?info:PosInfos)
	{
		Assert.areEqual(width, _container.width, info);
		Assert.areEqual(height, _container.height, info);
	}
	
	@Test
	public function resizeOnAddAndRemoveChild()
	{
		_container.addChild(_child[0]);
		checkSize(100, 10);
		
		_container.addChild(_child[1]);
		checkSize(110, 32);
		
		_container.addChild(_child[2]);
		checkSize(110, 64);
		
		_container.removeChild(_child[0]);
		checkSize(110, 52);
		
		_container.addChild(_child[0]);
		_container.removeChild(_child[1]);
		checkSize(100, 10 + 2 + 30);
		
		_container.addChild(_child[1]);
		_container.removeChild(_child[2]);
		checkSize(110, 10 + 2 + 20);
		
		_container.removeChild(_child[0]);
		_container.removeChild(_child[1]);
		checkSize(0, 0);
	}
	
	@Test
	public function resizeOnAddAndRemoveChildAt()
	{
		_container.addChildAt(_child[0], 0);
		checkSize(100, 10);
		
		_container.addChildAt(_child[1], 1);
		checkSize(110, 32);
		
		_container.addChildAt(_child[2], 2);
		checkSize(110, 64);
		
		_container.removeChildAt(2);
		checkSize(110, 10 + 2 + 20);
		
		_container.removeChildAt(0);
		checkSize(110, 20);
		
		_container.removeChildAt(0);
		checkSize(0, 0);
	}
	
	/*
	TODO
	- Повторное добавление
	- Позиционирование детей
	- Проверка исключений добавения/удаления (при этом размеры должны оставаться корректными)
	*/
}