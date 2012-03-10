package temperate.containers;

import flash.display.Shape;
import flash.errors.ArgumentError;
import flash.errors.RangeError;
import massive.munit.Assert;

class CHContainerChildManagmentTest
{
	public function new()
	{
	}
	
	var _container:CVBox;
	
	@Before
	public function setUp():Void
	{
		_container = new CVBox();
	}
	
	@After
	public function tearDown():Void
	{
		_container = null;
	}
	
	@Test
	public function addChild():Void
	{
		var child = new Shape();
		_container.addChild(child);
		Assert.areEqual(_container, child.parent);
		
		var child = new Shape();
		_container.addChild(child);
		Assert.areEqual(_container, child.parent);
		Assert.areEqual(1, _container.getChildIndex(child));
	}
	
	@Test
	public function removeChild():Void
	{
		var child:Array<Shape> = [new Shape(), new Shape()];
		
		_container.addChild(child[0]);
		Assert.areEqual(0, _container.getChildIndex(child[0]));
		
		_container.removeChild(child[0]);
		Assert.areEqual(null, child[0].parent);
		
		_container.addChild(child[0]);
		_container.addChild(child[1]);
		Assert.areEqual(0, _container.getChildIndex(child[0]));
		Assert.areEqual(1, _container.getChildIndex(child[1]));
		
		_container.removeChild(child[0]);
		Assert.areEqual(null, child[0].parent);
		Assert.areEqual(_container, child[1].parent);
	}
	
	@Test
	public function addChildAt():Void
	{
		var child:Array<Shape> = [new Shape(), new Shape(), new Shape()];
		
		_container.addChildAt(child[0], 0);
		Assert.areEqual(child[0], _container.getChildAt(0));
		
		_container.addChildAt(child[1], 1);
		Assert.areEqual(child[1], _container.getChildAt(1));
		
		_container.addChildAt(child[2], 0);
		Assert.areEqual(child[2], _container.getChildAt(0));
		
		Assert.areEqual(1, _container.getChildIndex(child[0]));
		Assert.areEqual(2, _container.getChildIndex(child[1]));
		Assert.areEqual(0, _container.getChildIndex(child[2]));
		
		Assert.areEqual(_container, child[0].parent);
		Assert.areEqual(_container, child[1].parent);
		Assert.areEqual(_container, child[2].parent);
	}
	
	@Test
	public function removeChildAt():Void
	{
		var child:Array<Shape> = [new Shape(), new Shape(), new Shape()];
		
		_container.addChildAt(child[0], 0);
		_container.addChildAt(child[1], 1);
		_container.addChildAt(child[2], 2);
		
		_container.removeChildAt(2);
		Assert.areEqual(_container, child[0].parent);
		Assert.areEqual(_container, child[1].parent);
		Assert.areEqual(null, child[2].parent);
		
		_container.removeChildAt(0);
		Assert.areEqual(null, child[0].parent);
		Assert.areEqual(_container, child[1].parent);
		Assert.areEqual(null, child[2].parent);
		
		_container.removeChildAt(0);
		Assert.areEqual(null, child[0].parent);
		Assert.areEqual(null, child[1].parent);
		Assert.areEqual(null, child[2].parent);
	}
	
	@Test
	public function repeatAddChild():Void
	{
		var child:Array<Shape> = [new Shape(), new Shape(), new Shape()];
		
		_container.addChild(child[0]);
		_container.addChild(child[0]);
		
		Assert.areEqual(_container, child[0].parent);
		Assert.areEqual(1, _container.numChildren);
		Assert.areEqual(0, _container.getChildIndex(child[0]));
		
		_container.addChild(child[1]);
		Assert.areEqual(_container, child[1].parent);
		Assert.areEqual(2, _container.numChildren);
		_container.addChild(child[1]);
		Assert.areEqual(1, _container.getChildIndex(child[1]));
		
		_container.addChild(child[0]);
		Assert.areEqual(1, _container.getChildIndex(child[0]));
	}
	
	@Test
	public function repeatRemoveChildThrowsError():Void
	{
		var child:Array<Shape> = [new Shape(), new Shape(), new Shape()];
		
		_container.addChild(child[0]);
		
		_container.removeChild(child[0]);
		try
		{
			_container.removeChild(child[0]);
			Assert.fail("Mast throws exception");
		}
		catch (error:ArgumentError)
		{
			//
		}
		Assert.areEqual(null, child[0].parent);
		Assert.areEqual(0, _container.numChildren);
		
		_container.addChild(child[0]);
		_container.addChild(child[1]);
		_container.removeChild(child[1]);
		try
		{
			_container.removeChild(child[1]);
			Assert.fail("Mast throws exception");
		}
		catch (error:ArgumentError)
		{
			//
		}
		Assert.areEqual(_container, child[0].parent);
		Assert.areEqual(null, child[1].parent);
		Assert.areEqual(0, _container.getChildIndex(child[0]));
		Assert.areEqual(1, _container.numChildren);
		
		_container.addChild(child[1]);
		_container.removeChild(child[0]);
		
		try
		{
			_container.removeChild(child[0]);
			Assert.fail("Mast throws exception");
		}
		catch (error:ArgumentError)
		{
			//
		}
		
		Assert.areEqual(null, child[0].parent);
		Assert.areEqual(_container, child[1].parent);
		Assert.areEqual(0, _container.getChildIndex(child[1]));
		Assert.areEqual(1, _container.numChildren);
	}
	
	@Test
	public function repeatRemoveChildAtThrowsError():Void
	{
		var child:Array<Shape> = [new Shape(), new Shape(), new Shape()];
		
		_container.addChild(child[0]);
		
		_container.removeChild(child[0]);
		try
		{
			_container.removeChildAt(0);
			Assert.fail("Mast throws exception");
		}
		catch (error:RangeError)
		{
			//
		}
		Assert.areEqual(null, child[0].parent);
		Assert.areEqual(0, _container.numChildren);
		
		_container.addChild(child[0]);
		_container.addChild(child[1]);
		_container.removeChild(child[1]);
		try
		{
			_container.removeChildAt(1);
			Assert.fail("Mast throws exception");
		}
		catch (error:RangeError)
		{
			//
		}
		Assert.areEqual(_container, child[0].parent);
		Assert.areEqual(null, child[1].parent);
		Assert.areEqual(0, _container.getChildIndex(child[0]));
		Assert.areEqual(1, _container.numChildren);
	}
	
	@Test
	public function repeatAddChildAt():Void
	{
		var child:Array<Shape> = [new Shape(), new Shape(), new Shape()];
		
		_container.addChildAt(child[0], 0);
		_container.addChildAt(child[0], 0);
		
		Assert.areEqual(_container, child[0].parent);
		Assert.areEqual(1, _container.numChildren);
		Assert.areEqual(0, _container.getChildIndex(child[0]));
		
		_container.addChildAt(child[1], 1);
		Assert.areEqual(_container, child[1].parent);
		Assert.areEqual(2, _container.numChildren);
		_container.addChildAt(child[1], 0);
		Assert.areEqual(0, _container.getChildIndex(child[1]));
		
		_container.addChildAt(child[0], 1);
		Assert.areEqual(1, _container.getChildIndex(child[0]));
	}
}