package temperate.collections;
import massive.munit.Assert;
using massive.munit.Assert;

class CIndexedComponentSetTest
{
	public function new()
	{
	}
	
	var _components:CComponentStack<FakeComponent>;
	
	@Before
	public function setUp():Void
	{
		_components = new CComponentStack();
	}
	
	@After
	public function tearDown():Void
	{
		
	}
	
	@Test
	public function firstComponentIsAddedAsHead()
	{
		var component = new FakeComponent("*");
		_components.set(0, component);
		component.areEqual(_components.head);
		"*".areEqual(_components.head.getValues());
	}
	
	@Test
	public function severalComponentsLinkedByIndexOrder_and_headHasLargestIndex()
	{
		var component0 = new FakeComponent("0");
		var component1 = new FakeComponent("1");
		var component2 = new FakeComponent("2");
		_components.set(0, component0);
		_components.set(1, component1);
		_components.set(2, component2);
		component2.areEqual(_components.head);
		"2&1&0".areEqual(_components.head.getValues());
	}
	
	@Test
	public function insertComponentInAnyPlacesCases()
	{
		var component10 = new FakeComponent("10");
		var component1 = new FakeComponent("1");
		var component2 = new FakeComponent("2");
		var component0 = new FakeComponent("0");
		var component11 = new FakeComponent("11");
		var component12 = new FakeComponent("12");
		
		_components.set(10, component10);
		component10.areEqual(_components.head);
		"10".areEqual(_components.head.getValues());
		
		_components.set(1, component1);
		component10.areEqual(_components.head);
		"10&1".areEqual(_components.head.getValues());
		
		_components.set(2, component2);
		component10.areEqual(_components.head);
		"10&2&1".areEqual(_components.head.getValues());
		
		_components.set(0, component0);
		component10.areEqual(_components.head);
		"10&2&1&0".areEqual(_components.head.getValues());
		
		_components.set(11, component11);
		component11.areEqual(_components.head);
		"11&10&2&1&0".areEqual(_components.head.getValues());
		
		_components.set(12, component12);
		component12.areEqual(_components.head);
		"12&11&10&2&1&0".areEqual(_components.head.getValues());
	}
	
	@Ignore("Not realized")
	@Test
	public function nullSettingIsRemoveComponent()
	{
		var component0 = new FakeComponent("0");
		_components.set(0, component0);
		"0".areEqual(_components.head.getValues());
		
		_components.set(0, null);
		_components.head.isNull();
	}
}
/*
- При добавлени компонента с тем же индексом старый перетирается
- При попытке добавить компонент в другой контейнер он удаляется из старого
- При попытке добавить существующий компонент в новый индекс он удаляется из старого
- При попытке добавить компонент в тот же индекс список не изменяется
*/