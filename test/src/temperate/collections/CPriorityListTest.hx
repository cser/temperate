package temperate.collections;
import massive.munit.Assert;
using massive.munit.Assert;

class CPriorityListTest
{
	public function new()
	{
	}
	
	var _list:CPriorityList<FakePriorityNode>;
	
	@Before
	public function setUp():Void
	{
		_list = new CPriorityList();
	}
	
	@After
	public function tearDown():Void
	{
		
	}
	
	@Test
	public function firstComponentIsAddedAsHead()
	{
		var component = new FakePriorityNode("*");
		_list.add(component, 0);
		component.areEqual(_list.head);
		"*".areEqual(_list.head.getValues());
	}
	
	@Test
	public function severalComponentsLinkedByIndexOrder_and_headHasLargestIndex()
	{
		var component0 = new FakePriorityNode("0");
		var component1 = new FakePriorityNode("1");
		var component2 = new FakePriorityNode("2");
		_list.add(component0, 0);
		_list.add(component1, 1);
		_list.add(component2, 2);
		component2.areEqual(_list.head);
		"2&1&0".areEqual(_list.head.getValues());
	}
	
	@Test
	public function insertComponentInAnyPlacesCases()
	{
		var component10 = new FakePriorityNode("10");
		var component1 = new FakePriorityNode("1");
		var component2 = new FakePriorityNode("2");
		var component0 = new FakePriorityNode("0");
		var component11 = new FakePriorityNode("11");
		var component12 = new FakePriorityNode("12");
		
		_list.add(component10, 10);
		component10.areEqual(_list.head);
		"10".areEqual(_list.head.getValues());
		
		_list.add(component1, 1);
		component10.areEqual(_list.head);
		"10&1".areEqual(_list.head.getValues());
		
		_list.add(component2, 2);
		component10.areEqual(_list.head);
		"10&2&1".areEqual(_list.head.getValues());
		
		_list.add(component0, 0);
		component10.areEqual(_list.head);
		"10&2&1&0".areEqual(_list.head.getValues());
		
		_list.add(component11, 11);
		component11.areEqual(_list.head);
		"11&10&2&1&0".areEqual(_list.head.getValues());
		
		_list.add(component12, 12);
		component12.areEqual(_list.head);
		"12&11&10&2&1&0".areEqual(_list.head.getValues());
	}
}
/*
- При добавлени компонента с тем же индексом новый ложится после старого
- При попытке добавить компонент в другой контейнер он удаляется из старого
- При попытке добавить существующий компонент в новый индекс он перемещается в новый индекс
*/