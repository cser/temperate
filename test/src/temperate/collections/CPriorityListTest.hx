package temperate.collections;
import haxe.PosInfos;
import massive.munit.Assert;

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
	
	function assertLinking(expectedLength:Int, ?info:PosInfos)
	{
		if (expectedLength == 0)
		{
			ExtendedAssert.areEqual(null, _list.head, "head is not null for length 0", info);
			ExtendedAssert.areEqual(null, _list.tail, "tail is not null for length 0", info);
		}
		if (_list.head == null && _list.tail == null)
		{
			ExtendedAssert.areEqual(expectedLength, 0, "incorrect length", info);
			return;
		}
		else if (_list.head == null)
		{
			Assert.fail("head is null, but tail is [" + _list.tail + "]", info);
		}
		else if (_list.tail == null)
		{
			Assert.fail("tail is null, but head is [" + _list.head + "]", info);
		}
		ExtendedAssert.areEqual(null, _list.head.prev, "head has prev", info);
		ExtendedAssert.areEqual(null, _list.tail.next, "tail has next", info);
		var next = _list.head;
		var prev = null;
		var length = 0;
		while (true)
		{
			length++;
			ExtendedAssert.areEqual(prev, next.prev, "prev incorrect", info);
			if (prev != null && prev.priority < next.priority)
			{
				Assert.fail(
					"priority order incorrect " + prev.priority + ", " + next.priority,
					info
				);
			}
			if (next.next == null)
			{
				ExtendedAssert.areEqual(_list.tail, next, "list end is not tail", info);
				break;
			}
			prev = next;
			next = next.next;
		}
		ExtendedAssert.areEqual(expectedLength, length, "incorrect length", info);
	}
	
	function assertHeadAndTail(
		expectedHead:FakePriorityNode, expectedTail:FakePriorityNode, ?info:PosInfos)
	{
		ExtendedAssert.areEqual(expectedHead, _list.head, "head incorrect", info);
		ExtendedAssert.areEqual(expectedTail, _list.tail, "tail incorrect", info);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  List
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function addAndRemoveOneNode()
	{
		var node = new FakePriorityNode("node");
		_list.add(node, 0);
		assertHeadAndTail(node, node);
		assertLinking(1);
		_list.remove(node);
		assertLinking(0);
	}
	
	@Test
	public function twoNodesCases()
	{
		var node = [new FakePriorityNode("0"), new FakePriorityNode("1")];
		
		_list.add(node[0], 0);
		_list.add(node[1], -1);
		assertHeadAndTail(node[0], node[1]);
		assertLinking(2);
		
		_list.remove(node[1]);
		assertHeadAndTail(node[0], node[0]);
		assertLinking(1);
		
		_list.add(node[1], -1);
		assertHeadAndTail(node[0], node[1]);
		assertLinking(2);
		
		_list.remove(node[0]);
		assertHeadAndTail(node[1], node[1]);
		assertLinking(1);
		
		_list.remove(node[1]);
		assertLinking(0);
		
		_list.add(node[0], 0);
		_list.add(node[1], 1);
		assertHeadAndTail(node[1], node[0]);
		assertLinking(2);
	}
	
	@Test
	public function threeNodesCases()
	{
		var node =
			[new FakePriorityNode("0"), new FakePriorityNode("1"), new FakePriorityNode("2")];
		
		_list.add(node[0], 0);
		_list.add(node[1], -1);
		_list.add(node[2], -2);
		assertHeadAndTail(node[0], node[2]);
		assertLinking(3);
		
		_list.remove(node[2]);
		assertHeadAndTail(node[0], node[1]);
		assertLinking(2);
		
		_list.remove(node[1]);
		assertHeadAndTail(node[0], node[0]);
		assertLinking(1);
		
		_list.remove(node[0]);
		assertLinking(0);
		
		_list.add(node[2], -2);
		_list.add(node[1], -1);
		_list.add(node[0], 0);
		assertHeadAndTail(node[0], node[2]);
		assertLinking(3);
		
		_list.remove(node[1]);
		assertHeadAndTail(node[0], node[2]);
		assertLinking(2);
		_list.add(node[1], -1);
		assertHeadAndTail(node[0], node[2]);
		assertLinking(3);
		
		_list.remove(node[0]);
		assertHeadAndTail(node[1], node[2]);
		assertLinking(2);
	}
	
	@Test
	public function massiveNodesAddAndRemove()
	{
		var node =
			[new FakePriorityNode("0"), new FakePriorityNode("1"), new FakePriorityNode("2"),
			new FakePriorityNode("3"), new FakePriorityNode("4")];
		
		_list.add(node[0], 0);
		_list.add(node[1], -1);
		_list.add(node[2], -2);
		_list.add(node[3], -3);
		_list.add(node[4], -4);
		assertHeadAndTail(node[0], node[4]);
		assertLinking(5);
		
		_list.remove(node[2]);
		assertHeadAndTail(node[0], node[4]);
		assertLinking(4);
		Assert.areEqual("0&1&3&4", _list.head.getHeadValues());
		
		_list.remove(node[3]);
		assertHeadAndTail(node[0], node[4]);
		assertLinking(3);
		Assert.areEqual("0&1&4", _list.head.getHeadValues());
		
		_list.add(node[2], -2);
		Assert.areEqual("0&1&2&4", _list.head.getHeadValues());
		assertLinking(4);
		
		_list.add(node[3], -3);
		Assert.areEqual("0&1&2&3&4", _list.head.getHeadValues());
		assertLinking(5);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Priority
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function severalNodesLinkedByIndexOrder_and_headHasLargestIndex()
	{
		var node0 = new FakePriorityNode("0");
		var node1 = new FakePriorityNode("1");
		var node2 = new FakePriorityNode("2");
		_list.add(node0, 0);
		_list.add(node1, 1);
		assertHeadAndTail(node1, node0);
		_list.add(node2, 2);
		assertHeadAndTail(node2, node0);
		Assert.areEqual("2&1&0", _list.head.getHeadValues());
		Assert.areEqual("2&1&0", _list.tail.getTailValues());
	}
	
	@Test
	public function insertNodeInAnyPlacesCases()
	{
		var node10 = new FakePriorityNode("10");
		var node1 = new FakePriorityNode("1");
		var node2 = new FakePriorityNode("2");
		var node0 = new FakePriorityNode("0");
		var node11 = new FakePriorityNode("11");
		var node12 = new FakePriorityNode("12");
		
		_list.add(node10, 10);
		Assert.areEqual(node10, _list.head);
		Assert.areEqual("10", _list.head.getHeadValues());
		Assert.areEqual("10", _list.tail.getTailValues());
		
		_list.add(node1, 1);
		Assert.areEqual(node10, _list.head);
		Assert.areEqual("10&1", _list.head.getHeadValues());
		Assert.areEqual("10&1", _list.tail.getTailValues());
		
		_list.add(node2, 2);
		Assert.areEqual(node10, _list.head);
		Assert.areEqual("10&2&1", _list.head.getHeadValues());
		
		_list.add(node0, 0);
		Assert.areEqual(node10, _list.head);
		Assert.areEqual("10&2&1&0", _list.head.getHeadValues());
		
		_list.add(node11, 11);
		Assert.areEqual(node11, _list.head);
		Assert.areEqual("11&10&2&1&0", _list.head.getHeadValues());
		
		_list.add(node12, 12);
		Assert.areEqual(node12, _list.head);
		Assert.areEqual("12&11&10&2&1&0", _list.head.getHeadValues());
		Assert.areEqual("12&11&10&2&1&0", _list.tail.getTailValues());
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Iteration
	//
	//----------------------------------------------------------------------------------------------
	
	@Test
	public function iteratorNormalCase()
	{
		var node =
			[new FakePriorityNode("0"), new FakePriorityNode("1"), new FakePriorityNode("2"),
			new FakePriorityNode("3"), new FakePriorityNode("4")];
		_list.add(node[0], 0);
		_list.add(node[1], -1);
		_list.add(node[2], -2);
		_list.add(node[3], -3);
		_list.add(node[4], -4);
		var array:Array<FakePriorityNode> = [];
		for (node in _list)
		{
			array.push(node);
		}
		ArrayAssert.equalToArray(node, array);
	}
}
/*
- При добавлени компонента с тем же индексом новый ложится после старого
- При попытке добавить компонент в другой контейнер он удаляется из старого
- При попытке добавить существующий компонент в новый индекс он перемещается в новый индекс
- Изменение приоритета
- Удаление элементов при итерации
- Удаление текущего элемента при итерации
- Добавление элементов при итерации
*/