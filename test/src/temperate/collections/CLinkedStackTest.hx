package temperate.collections;

import haxe.PosInfos;
import massive.munit.Assert;

class CLinkedStackTest
{
	public function new()
	{
	}
	
	function assertNodes<T>(
		expectedValue:T, explectedValues:Array<T>, stack:ExtendedLinkedStack<T>, ?info:PosInfos)
	{
		Assert.areEqual(expectedValue, stack.value, info);
		if (explectedValues.length == 0)
		{
			if (stack.getHead() != null)
			{
				Assert.fail("stack.head != null", info);
			}
		}
		var node = stack.getHead();
		var prev = null;
		var i = 0;
		while (node != null)
		{
			if (node.prev != prev)
			{
				Assert.fail("node.prev != prev", info);
			}
			if (i >= explectedValues.length)
			{
				Assert.fail("i >= explected.length", info);
			}
			if (explectedValues[i] != node.value)
			{
				Assert.fail("explected[" + i + "] != " + node.value, info);
			}
			prev = node;
			node = node.next;
			i++;
		}
	}
	
	@Test
	public function oneElementAdditionAndRemoving()
	{
		var stack = new ExtendedLinkedStack();
		
		var node = stack.newSwitcher().setValue("value");
		
		Assert.areEqual(null, stack.value);
		node.on();
		Assert.areEqual("value", stack.value);
		
		node.off();
		Assert.areEqual(null, stack.value);
	}
	
	@Test
	public function valueAreEqualLastAddedValue()
	{
		var stack = new ExtendedLinkedStack();
		var node0 = stack.newSwitcher().setValue("value0");
		var node1 = stack.newSwitcher().setValue("value1");
		var node2 = stack.newSwitcher().setValue("value2");
		
		node0.on();
		node1.on();
		assertNodes("value1", [ "value1", "value0" ], stack);
		
		node1.off();
		assertNodes("value0", [ "value0" ], stack);
		
		node0.off();
		assertNodes(null, [], stack);
		
		node0.on();
		node1.on();
		assertNodes("value1", [ "value1", "value0" ], stack);
		
		node0.off();
		assertNodes("value1", [ "value1" ], stack);
		
		node1.off();
		assertNodes(null, [], stack);
		
		node0.on();
		node1.on();
		node2.on();
		assertNodes("value2", [ "value2", "value1", "value0" ], stack);
		
		node1.off();
		assertNodes("value2", [ "value2", "value0" ], stack);
		
		node1.on();
		assertNodes("value1", [ "value1", "value2", "value0" ], stack);
		
		node1.off();
		assertNodes("value2", [ "value2", "value0" ], stack);
		
		node0.off();
		assertNodes("value2", [ "value2" ], stack);
		
		node2.off();
		assertNodes(null, [], stack);
	}
	
	@Test
	public function priorityIsTakedToAccount()
	{
		var stack = new ExtendedLinkedStack();
		var node0 = stack.newSwitcher(0).setValue("value0");
		var node1 = stack.newSwitcher(1).setValue("value1");
		var node2 = stack.newSwitcher(2).setValue("value2");
		
		node1.on();
		node0.on();
		assertNodes("value1", [ "value1", "value0" ], stack);
		
		node1.off();
		assertNodes("value0", [ "value0" ], stack);
		
		node0.off();
		assertNodes(null, [], stack);
		
		node2.on();
		node1.on();
		node0.on();
		assertNodes("value2", [ "value2", "value1", "value0" ], stack);
		
		node1.off();
		assertNodes("value2", [ "value2", "value0" ], stack);
		
		node1.on();
		assertNodes("value2", [ "value2", "value1", "value0" ], stack);
		
		node0.off();
		assertNodes("value2", [ "value2", "value1" ], stack);
		
		node0.on();
		assertNodes("value2", [ "value2", "value1", "value0" ], stack);
		
		node2.off();
		assertNodes("value1", [ "value1", "value0" ], stack);
		
		node2.on();
		assertNodes("value2", [ "value2", "value1", "value0" ], stack);
		
		node0.off();
		assertNodes("value2", [ "value2", "value1" ], stack);
		
		node0.on();
		assertNodes("value2", [ "value2", "value1", "value0" ], stack);
	}
	
	@Test
	public function repeatRemovingIsNothingChange()
	{
		var stack = new ExtendedLinkedStack();
		var node0 = stack.newSwitcher(0).setValue("value0");
		
		node0.off();
		assertNodes(null, [], stack);
		
		node0.on();
		assertNodes("value0", [ "value0" ], stack);
		
		node0.on();
		assertNodes("value0", [ "value0" ], stack);
		
		node0.off();
		assertNodes(null, [ ], stack);
		
		node0.off();
		assertNodes(null, [ ], stack);
		
		var node1 = stack.newSwitcher(1).setValue("value1");
		var node2 = stack.newSwitcher(2).setValue("value2");
		
		node1.on();
		node2.on();
		assertNodes("value2", [ "value2", "value1" ], stack);
		
		node1.off();
		assertNodes("value2", [ "value2" ], stack);
		node1.off();
		assertNodes("value2", [ "value2" ], stack);
	}
	
	@Test
	public function repeatAdditionIsMoveElementToTopIfPrioritiesAreEqual()
	{
		var stack = new ExtendedLinkedStack();
		var node0 = stack.newSwitcher().setValue("value0");
		var node1 = stack.newSwitcher().setValue("value1");
		var node2 = stack.newSwitcher().setValue("value2");
		var node3 = stack.newSwitcher().setValue("value3");
		
		node0.on();
		node1.on();
		node2.on();
		node3.on();
		assertNodes("value3", [ "value3", "value2", "value1", "value0" ], stack);
		
		node1.on();
		assertNodes("value1", [ "value1", "value3", "value2", "value0" ], stack);
		
		node0.on();
		assertNodes("value0", [ "value0", "value1", "value3", "value2" ], stack);
	}
	
	@Test
	public function repeatAdditionIsMoveElementToTopIfPriorityAllowIt()
	{
		var stack = new ExtendedLinkedStack();
		var node0 = stack.newSwitcher(1).setValue("value0");
		var node1 = stack.newSwitcher(1).setValue("value1");
		var node2 = stack.newSwitcher(2).setValue("value2");
		var node3 = stack.newSwitcher(2).setValue("value3");
		
		node0.on();
		node1.on();
		node2.on();
		node3.on();
		assertNodes("value3", [ "value3", "value2", "value1", "value0" ], stack);
		
		node1.on();
		assertNodes("value3", [ "value3", "value2", "value1", "value0" ], stack);
		
		node0.on();
		assertNodes("value3", [ "value3", "value2", "value0", "value1" ], stack);
		
		node3.on();
		assertNodes("value3", [ "value3", "value2", "value0", "value1" ], stack);
		
		node2.on();
		assertNodes("value2", [ "value2", "value3", "value0", "value1" ], stack);
	}
	
	@Test
	public function valueOfTopNodeChangingIsChangeValueOfStack()
	{
		var stack = new ExtendedLinkedStack();
		var node = stack.newSwitcher().setValue("value");
		node.on();
		Assert.areEqual("value", stack.value);
		
		node.value = "anotherValue";
		Assert.areEqual("anotherValue", stack.value);
		
		node.value = null;
		Assert.areEqual(null, stack.value);
		
		var node2 = stack.newSwitcher().setValue("value2");
		node2.on();
		Assert.areEqual("value2", stack.value);
		
		node.value = "value";
		node2.off();
		Assert.areEqual("value", stack.value);
	}
	
	var _stack:ExtendedLinkedStack<String>;
	
	@Test
	public function callbackCalledOnlyIfValueChanged()
	{
		_stack = new ExtendedLinkedStack(onChange);
		var node0 = _stack.newSwitcher().setValue("value0");
		var node01 = _stack.newSwitcher().setValue("value0");
		var node2 = _stack.newSwitcher().setValue("value2");
		
		_log = [];
		ArrayAssert.areEqual([], _log);
		node0.on();
		ArrayAssert.areEqual(["value0"], _log);
		Assert.areEqual("value0", _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node01.on();
		ArrayAssert.areEqual([], _log);
		Assert.areEqual("value0", _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node2.on();
		ArrayAssert.areEqual(["value2"], _log);
		Assert.areEqual("value2", _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node2.off();
		ArrayAssert.areEqual(["value0"], _log);
		Assert.areEqual("value0", _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node01.off();
		ArrayAssert.areEqual([], _log);
		Assert.areEqual("value0", _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node0.off();
		ArrayAssert.areEqual([null], _log);
		Assert.areEqual(null, _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
	}
	
	var _log:Array<String>;
	
	function onChange()
	{
		_log.push(_stack.value);
	}
	
	@Test
	public function changeDispatchedOnNodeValueChangedToo()
	{
		_stack = new ExtendedLinkedStack(onChange);
		var node0 = _stack.newSwitcher().setValue("value0");
		var node1 = _stack.newSwitcher().setValue("value1");
		
		_log = [];
		node0.on();
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node0.value = "value1";
		ArrayAssert.areEqual(["value1"], _log);
		Assert.areEqual("value1", _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node0.value = "value1";
		ArrayAssert.areEqual([], _log);
		Assert.areEqual("value1", _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node1.on();
		ArrayAssert.areEqual([], _log);
		Assert.areEqual("value1", _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node1.value = "newValue1";
		ArrayAssert.areEqual(["newValue1"], _log);
		Assert.areEqual("newValue1", _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node0.off();
		ArrayAssert.areEqual([], _log);
		Assert.areEqual("newValue1", _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node0.value = "value0NotInfluence";
		ArrayAssert.areEqual([], _log);
		Assert.areEqual("newValue1", _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node1.off();
		ArrayAssert.areEqual([null], _log);
		Assert.areEqual(null, _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
		
		_log = [];
		node1.value = "value1NotInfluence";
		ArrayAssert.areEqual([], _log);
		Assert.areEqual(null, _stack.value);
		assertNoNodeCallbacksExcludeHead(_stack.getHead());
	}
	
	function assertNoNodeCallbacksExcludeHead<T>(head:CLinkedStackNode<T>, ?info:PosInfos)
	{
		Assert.isTrue(true);// For prevent "no assert" error
		if (head == null)
		{
			return;
		}
		var node = head.next;
		while (node != null)
		{
			Assert.isNull(node.changeCallback);
			node = node.next;
		}
	}
}

/**
 * Public Morozov :)
 */
class ExtendedLinkedStack< T > extends CLinkedStack<T>
{
	public function new(changeCallback:Void->Void = null)
	{
		super(changeCallback);
	}
	
	public function getHead()
	{
		return _head;
	}
}