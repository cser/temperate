package temperate.layouts;
import flash.display.Graphics;
import flash.display.Shape;
import flash.geom.Rectangle;
import flash.Lib;
import flash.utils.Dictionary;
import flash.utils.TypedDictionary;
import temperate.layouts.utility.LayoutAlgoritms;
import temperate.layouts.utility.SizeInfo;
import temperate.layouts.ExcessSpaceMode;
import temperate.utils.Maths;

class GridLayout extends AGridLayout
{
	var _components:Array<ILayoutable>;
	
	var _constraints:TypedDictionary<ILayoutable, Constraint>;
	
	public function new() 
	{
		super();
		_components = [];
		_constraints = new TypedDictionary<ILayoutable, Constraint>();
		_excessSpaceModeX = UNIFORM;
		_excessSpaceModeY = UNIFORM;
	}
	
	// PROTECTED METHODS
	
	var _nodes:Array<Node>;
	
	var _infos:Array<SizeInfo>;
	
	var _numLines:Int;
	
	inline function universalArrange(forX:Bool)
	{
		_numLines = forX ? _numCols : _numRows;
		
		var infos = forX ? _colInfos : _rowInfos;
		var gap = forX ? _gapX : _gapY;
		var sumSize = (forX ? width : height) + gap;
		
		_infos = infos;
		
		// Find min and max line sizes
		
		var sumPortion = 0.;
		for (i in 0 ... _numLines)
		{
			var info = infos[i];
			if (isCellScaled(info))
			{
				info.min = 0;
				info.max = Math.POSITIVE_INFINITY;
			}
			else
			{
				info.max = info.min = info.gridSize;
			}
			sumPortion += info.portion;
		}
		
		for (component in _components)
		{
			var constraint = _constraints.get(component);
			var min;
			var max;
			if (forX ? isXScaled(component) : isYScaled(component))
			{
				if (forX)
				{
					component.width = sumSize;
					max = component.width;
					component.width = 0;
					min = component.width;
				}
				else
				{
					component.height = sumSize;
					max = component.height;
					component.height = 0;
					min = component.height;
				}
			}
			else
			{
				max = min = forX ? component.width : component.height;
			}
			constraint.min = min + gap;
			constraint.max = max + gap;
		}
		
		_nodes = [];
		var node = new Node();
		node.coord = 0;
		node.rights = [];
		_nodes[0] = node;
		for (i in 1 ... _numLines)
		{
			var node = new Node();
			node.lefts = [];
			node.rights = [];
			_nodes[i] = node;
		}
		var node = new Node();
		node.lefts = [];
		_nodes[_numLines] = node;
		
		for (component in _components)
		{
			var constraint = _constraints.get(component);
			var left = _nodes[forX ? constraint.leftIndex : constraint.topIndex];
			var right = _nodes[forX ? constraint.rightIndex : constraint.bottomIndex];
			var edge = edgeByNodes(left, right);
			if (edge == null)
			{
				edge = new Edge();
				edge.min = constraint.min;
				edge.max = constraint.max;
				edge.beginning = left;
				edge.end = right;
				left.rights.push(edge);
				right.lefts.push(edge);
			}
			else
			{
				var constraintMin = constraint.min;
				if (edge.min < constraintMin)
				{
					edge.min = constraintMin;
				}
				var constraintMax = constraint.max;
				if (edge.max < constraintMax)
				{
					edge.max = constraintMax;
				}
			}
		}
		
		// Obturating of holes in grid
		
		for (i in 0 ... _numLines)
		{
			var left = _nodes[i];
			var right = _nodes[i + 1];
			var edge = edgeByNodes(left, right);
			if (edge == null)
			{
				var info = infos[i];
				if (isCellScaled(info))
				{
					edge = new Edge();
					edge.min = 0;
					edge.max = Math.POSITIVE_INFINITY;
				}
				else
				{
					var size = info.gridSize;
					edge = new Edge();
					edge.min = size;
					edge.max = size;
				}
				left.rights.push(edge);
				right.lefts.push(edge);
				edge.beginning = left;
				edge.end = right;
			}
		}
		
		// Eges creation
		
		var sumPortion = 0.;
		for (info in _infos)
		{
			sumPortion += info.portion;
		}
		for (i in 0 ... _numLines)
		{
			var info = _infos[i];
			var edge = edgeByNodes(_nodes[i], _nodes[i + 1]);
			if (edge.min < info.min)
			{
				edge.min = info.min;
				if (edge.max < edge.min)
				{
					edge.max = info.min;
				}
			}
			if (edge.max > info.max)
			{
				edge.max = info.max;
				if (edge.max < edge.min)
				{
					edge.max = edge.min;
				}
			}
		}
		
		// Check min size
		
		var needExcess:Bool = false;
		
		findRight(_nodes[0]);
		if (sumSize > _rightMax)
		{
			sumSize = _rightMax;
			needExcess = true;
		}
		if (sumSize < _rightMin)
		{
			sumSize = _rightMin;
			if (forX)
			{
				width = _rightMin - gap;
			}
			else
			{
				height = _rightMin - gap;
			}
		}
		
		// Sizes distribution
		
		var offset = 0.;
		var rightSumSize = sumSize;
		var rightSumPortion = sumPortion;
		for (i in 0 ... _numLines)
		{
			var node = _nodes[i + 1];
			var portion = _infos[i].portion;
			var coord = offset + rightSumSize * portion / rightSumPortion;
			
			findLeft(node);
			findRight(node);
			
			var rightMax = sumSize - _rightMax;
			if (coord < rightMax)
			{
				coord = rightMax;
			}
			if (coord > _leftMax)
			{
				coord = _leftMax;
			}
			
			var rightMin = sumSize - _rightMin;
			if (coord > rightMin)
			{
				coord = rightMin;
			}
			if (coord < _leftMin)
			{
				coord = _leftMin;
			}
			
			var size = coord - offset;
			node.coord = coord;
			
			rightSumPortion -= portion;
			rightSumSize -= size;
			
			offset += size;
			//trace(Std.int(rightSumPortion) + ' / ' + Std.int(rightSumSize));
		}
		
		// Arrange and resize components
		
		var coordK = 1.;
		var leftOffset = 0.;
		if (needExcess)
		{
			var makeweight = (forX ? width : height) + gap - sumSize;
			switch(forX ? _excessSpaceModeX : _excessSpaceModeY)
			{
				case UNIFORM, INCREASE_GAPS:
					coordK = (sumSize + makeweight) / sumSize;
				case COMPACT_CONTAINER:
					if (forX)
					{
						width = sumSize - gap;
					}
					else
					{
						height = sumSize - gap;
					}
				case MOVE_TO_EDGES(align):
					leftOffset = makeweight * align;
			}
		}
		
		for (component in _components)
		{
			var constraint = _constraints.get(component);
			
			var left = _nodes[forX ? constraint.leftIndex : constraint.topIndex].coord * coordK;
			var right = _nodes[forX ? constraint.rightIndex : constraint.bottomIndex].coord * coordK - gap;
			if (forX ? isXScaled(component) : isYScaled(component))
			{
				if (forX)
				{
					component.width = component.widthPortion * (right - left);
				}
				else
				{
					component.height = component.heightPortion * (right - left);
				}
			}
			if (forX)
			{
				component.x = leftOffset + left + (right - left - component.width) * component.alignX;
			}
			else
			{
				component.y = leftOffset + left + (right - left - component.height) * component.alignY;
			}
		}
		
		//??????????????????????????????????????????????????????????????????????????????????????????????????????
		if (graphics != null)
		{
			var offset = 0.;
			for (i in 0 ... _numLines)
			{
				var node = _nodes[i + 1];
				var coord = node.coord;
				
				graphics.lineStyle(0, 0xff0000);
				if (forX)
				{
					graphics.moveTo(coord, 0);
					graphics.lineTo(coord, height);
				}
				else
				{
					graphics.moveTo(0, coord);
					graphics.lineTo(width, coord);
				}
				/*graphics.lineStyle(0, 0xffC0C0);
				if (forX)
				{
					graphics.moveTo(coord - gap, 0);
					graphics.lineTo(coord - gap, height);
				}
				else
				{
					graphics.moveTo(0, coord - gap);
					graphics.lineTo(width, coord - gap);
				}*/
			}
		}
		//??????????????????????????????????????????????????????????????????????????????????????????????????????
	}
	
	var _leftMax:Float;
	
	var _leftMin:Float;
	
	function findLeft(node:Node)
	{
		var lefts = node.lefts;
		if (lefts != null)
		{
			var max = Math.POSITIVE_INFINITY;
			var min = 0.;
			for (leftEdge in lefts)
			{
				var leftNode = leftEdge.beginning;
				var minCoord = leftEdge.min + leftNode.coord;
				if (min < minCoord)
				{
					min = minCoord;
				}
				var maxCoord = leftEdge.max + leftNode.coord;
				if (max > maxCoord && maxCoord > min)
				{
					max = maxCoord;
				}
				if (max < min)
				{
					max = min;
				}
			}
			_leftMax = max;
			_leftMin = min;
		}
		else
		{
			_leftMax = 0;
			_leftMin = 0;
		}
	}
	
	var _rightMax:Float;
	
	var _rightMin:Float;
	
	function findRight(node:Node)
	{
		var rights = node.rights;
		if (rights != null)
		{
			var min = 0.;
			var max = Math.POSITIVE_INFINITY;
			for (rightEdge in rights)
			{	
				var rightNode = rightEdge.end;
				findRight(rightNode);
				var minCoord = rightEdge.min + _rightMin;
				if (min < minCoord)
				{
					min = minCoord;
				}
				var maxCoord = rightEdge.max + _rightMax;
				if (max > maxCoord)
				{
					max = maxCoord;
				}
				if (max < min)
				{
					max = min;
				}
			}
			_rightMax = max;
			_rightMin = min;
		}
		else
		{
			_rightMax = 0;
			_rightMin = 0;
		}
		
	}
	
	function edgeByNodes(left:Node, right:Node)
	{
		// TODO Соптимизировать
		
		var rights = left.rights;
		var lefts = right.lefts;
		if (rights != null && lefts != null)
		{
			for (leftEdge in rights)
			{
				for (rightEdge in lefts)
				{
					if (leftEdge == rightEdge)
					{
						return leftEdge;
					}
				}
			}
		}
		return null;
	}
	
	// PUBLIC METHODS
	
	public var graphics:Graphics;//?
	
	public override function arrange()
	{
		//?????????????????
		if (graphics != null)
		{
			graphics.clear();
		}
		//?????????????????
		
		//var timer = Lib.getTimer();
		
		if (_autoSize)
		{
			width = 0;
			height = 0;
		}
		
		if (_components.length == 0)
		{
			return;
		}
		
		for (component in _components)
		{
			if (isXScaled(component) || isYScaled(component))
			{
				disableComponent(component);
			}
		}
		
		universalArrange(true);
		universalArrange(false);
		
		for (component in _components)
		{
			if (isXScaled(component) || isYScaled(component))
			{
				enableComponent(component);
			}
		}
		
		//trace(Lib.getTimer() - timer);
	}
	
	public function add(component:ILayoutable, row:Int, col:Int, rowSpan:Int = 1, colSpan:Int = 1)
	{
		if (rowSpan < 1)
		{
			rowSpan = 1;
		}
		if (colSpan < 1)
		{
			colSpan = 1;
		}
		
		if (col + colSpan > _numCols)
		{
			setNum(true, col + colSpan);
		}
		if (row + rowSpan > _numRows)
		{
			setNum(false, row + rowSpan);
		}
		
		_components.push(component);
		
		var constraint = new Constraint();
		constraint.leftIndex = col;
		constraint.rightIndex = col + colSpan;
		constraint.topIndex = row;
		constraint.bottomIndex = row + rowSpan;
		
		_constraints.set(component, constraint);
		
		heraldAddChild.dispatch(component);
	}
	
	public function remove(component:ILayoutable)
	{
		_components.remove(component);
		_constraints.delete(component);
		heraldRemoveChild.dispatch(component);
	}
	
	public override function removeAll()
	{
		var i = _components.length;
		while (i-- > 0)
		{
			remove(_components[i]);
		}
	}
	
	public override function iterator()
	{
		return _components.iterator();
	}
}

private class Constraint
{
	public function new()
	{
		
	}
	
	public var leftIndex:Int;
	
	public var rightIndex:Int;
	
	public var topIndex:Int;
	
	public var bottomIndex:Int;
	
	public var max:Float;
	
	public var min:Float;
}

class Edge
{	
	public function new()
	{
		
	}
	
	public var min:Float;
	
	public var max:Float;
	
	public var size:Float;
	
	public var beginning:Node;
	
	public var end:Node;
}

class Node
{
	public function new()
	{
		
	}
	
	public var coord:Float;
	
	public var lefts:Array<Edge>;
	
	public var rights:Array<Edge>;
}