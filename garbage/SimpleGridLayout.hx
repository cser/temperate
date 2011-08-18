package temperate.layouts;
import temperate.layouts.utility.LayoutAlgoritms;
import temperate.utils.Maths;
import temperate.layouts.ExcessSpaceMode;

class SimpleGridLayout extends AGridLayout, implements ILineLayout
{
	var _components:Array<ILayoutable>;
	
	public function new(isHorisontalBase:Bool = true, numBaseCells:Int = 2)
	{
		super();
		_isHorisontalBase = isHorisontalBase;
		_numBaseCells = numBaseCells;
		_components = [];
		updateRowsAndCols();
		_excessSpaceModeX = UNIFORM;
		_excessSpaceModeY = UNIFORM;
	}
	
	public override function arrange()
	{
		var gapX = _gapX;
		var gapY = _gapY;
		var sumGapX = _numCols > 1 ? (_numCols - 1) * gapX : 0;
		var sumGapY = _numRows > 1 ? (_numRows - 1) * gapY : 0;
		
		if (_autoSize)
		{
			width = sumGapX + .1;
			height = sumGapY + .1;
		}
		else
		{
			if (width < sumGapX + .1)
			{
				width = sumGapX + .1;
			}
			if (height < sumGapY + .1)
			{
				height = sumGapY + .1;
			}
		}
		
		setNum(true, _numCols);
		setNum(false, _numRows);
		
		var sumPortionX = 0.;
		var colInfos = [];
		for (i in 0 ... _numCols)
		{
			var info = _colInfos[i];
			if (isCellScaled(info))
			{
				info.max = 0;
				info.min = 0;
			}
			else
			{
				info.max = info.min = info.gridSize;
			}
			colInfos[i] = info;
			sumPortionX += info.portion;
		}
		
		var sumPortionY = 0.;
		var rowInfos = [];
		for (i in 0 ... _numRows)
		{
			var info = _rowInfos[i];
			if (isCellScaled(info))
			{
				info.max = 0;
				info.min = 0;
			}
			else
			{
				info.max = info.min = info.gridSize;
			}
			sumPortionY += info.portion;
			rowInfos[i] = info;
		}
		
		// Find min and max sizes for X
		
		var num = _components.length;
		for (i in 0 ... num)
		{
			var component = _components[i];
			if (isXScaled(component) || isYScaled(component))
			{
				disableComponent(component);
			}
			
			var min;
			var max;
			if (isXScaled(component))
			{
				component.width = width;
				max = component.width;
				component.width = 0;
				min = component.width;
			}
			else
			{
				max = min = component.width;
			}
			
			var info = colInfos[i % _numCols];
			if (isCellScaled(info))
			{
				if (info.min < min)
				{
					info.min = min;
				}
				if (info.max < max)
				{
					info.max = max;
				}
			}
			else if (info.min < min)
			{
				info.max = info.min = min;
			}
		}
		
		// Find and apply sizes for X;
		
		var space = LayoutAlgoritms.distributeProportionally(width - sumGapX, sumPortionX, colInfos);
		
		var additional = 0.;
		var globalAlign = 0.;
		switch (_excessSpaceModeX)
		{
			case UNIFORM:
				additional = space / numCols;
			case INCREASE_GAPS:
				if (numCols > 1)
				{
					gapX = gapX + space / (numCols - 1);//TODO проверить случай с одним компонентом и без компонентов
				}
			case COMPACT_CONTAINER:
			case MOVE_TO_EDGES(align):
				globalAlign = align;
		}
		
		var sumSizes = 0.;
		for (info in colInfos)
		{
			sumSizes += info.size;
		}
		width = sumSizes + gapX * (numCols - 1) + additional * numCols;
		
		var defaultOffsetX = space * globalAlign;
		var offsetX = defaultOffsetX;
		for (i in 0 ... num)
		{
			var component = _components[i];
			var index = i % _numCols;
			if (index == 0)
			{
				offsetX = defaultOffsetX;
			}
			var info = colInfos[index];
			var size = info.size + additional;
			if (isXScaled(component))
			{
				component.width = size * component.widthPortion;
			}
			component.x = offsetX + (size - component.width) * component.alignX;
			offsetX += size + gapX;
			
			// Find min and max sizes for Y
			
			var min;
			var max;
			if (isYScaled(component))
			{
				component.height = height;
				max = component.height;
				component.height = 0;
				min = component.height;
			}
			else
			{
				max = min = component.height;
			}
			
			var index = Std.int(i / _numCols);
			var info = rowInfos[index];
			if (isCellScaled(info))
			{
				if (info.min < min)
				{
					info.min = min;
				}
				if (info.max < max)
				{
					info.max = max;
				}
			}
			else if (info.min < min)
			{
				info.max = info.min = min;
			}
		}
		
		// Find and apply sizes for Y
		
		var space = LayoutAlgoritms.distributeProportionally(height - sumGapY, sumPortionY, rowInfos);
		
		var additional = 0.;
		var globalAlign = 0.;
		switch (_excessSpaceModeY)
		{
			case UNIFORM:
				additional = space / numRows;
			case INCREASE_GAPS:
				if (numRows > 1)
				{
					gapY = gapY + space / (numRows - 1);//TODO проверить случай с одним компонентом и без компонентов
				}
			case COMPACT_CONTAINER:
			case MOVE_TO_EDGES(align):
				globalAlign = align;
		}
		
		var offsetY = globalAlign * space;
		var info = rowInfos[0];
		for (i in 0 ... num)
		{
			var component = _components[i];
			var size = info.size + additional;
			if (isYScaled(component))
			{
				component.height = size * component.heightPortion;
			}
			component.y = offsetY + (size - component.height) * component.alignY;
			
			if (isXScaled(component) || isYScaled(component))
			{
				enableComponent(component);
			}
			if (i % _numCols == _numCols - 1)
			{
				offsetY += size + gapY;
				var index = Std.int((i + 1) / _numCols);
				info = rowInfos[index];
			}
		}
		height = offsetY - gapY + (1 - globalAlign) * space;
	}
	
	public function add(component:ILayoutable)
	{
		_components.push(component);
		component.heraldResize.add(onComponentResize);
		heraldAddChild.dispatch(component);
		updateRowsAndCols();
	}
	
	public function remove(component:ILayoutable)
	{
		_components.remove(component);
		component.heraldResize.remove(onComponentResize);
		heraldRemoveChild.dispatch(component);
		updateRowsAndCols();
	}
	
	public function addBefore(component:ILayoutable, rightComponent:ILayoutable)
	{
		for (i in 0 ... _components.length)
		{
			if (_components[i] == rightComponent)
			{
				_components.insert(i, component);
				component.heraldResize.add(onComponentResize);
				heraldAddChild.dispatch(component);
				updateRowsAndCols();
				break;
			}
		}
	}
	
	public function addAfter(leftComponent:ILayoutable, component:ILayoutable)
	{
		for (i in 0 ... _components.length)
		{
			if (_components[i] == leftComponent)
			{
				_components.insert(i + 1, component);
				component.heraldResize.add(onComponentResize);
				heraldAddChild.dispatch(component);
				updateRowsAndCols();
				break;
			}
		}
	}
	
	public override function iterator()
	{
		return _components.iterator();
	}
	
	public override function removeAll()
	{
		var i = _components.length;
		while (i-- > 0)
		{
			var component = _components.pop();
			component.heraldResize.remove(onComponentResize);
			heraldRemoveChild.dispatch(component);
		}
		updateRowsAndCols();
	}
	
	function updateRowsAndCols()
	{
		var num = _components.length;
		if (_numBaseCells < 1)
		{
			_numBaseCells = 1;
		}
		if (_isHorisontalBase)
		{
			_numCols = Maths.intMin(_numBaseCells, num);
			_numRows = Math.ceil((num - .1) / _numBaseCells);
		}
		else
		{
			_numCols = Math.ceil((num - .1) / _numBaseCells);
			_numRows = Maths.intMin(_numBaseCells, num);
		}
	}
	
	public var isHorisontalBase(getHorisontalBase, setHorisontalBase):Bool;
	var _isHorisontalBase:Bool;
	function getHorisontalBase()
	{
		return _isHorisontalBase;
	}
	function setHorisontalBase(value)
	{
		if (_isHorisontalBase == value)
		{
			return value;
		}
		_isHorisontalBase = value;
		updateRowsAndCols();
		heraldChange.dispatch(this);
		return value;
	}
	
	public var numBaseCells(getNumBaseCells, setNumBaseCells):Int;
	var _numBaseCells:Int;
	function getNumBaseCells()
	{
		return _numBaseCells;
	}
	function setNumBaseCells(value)
	{
		if (_numBaseCells == value)
		{
			return value;
		}
		_numBaseCells = value;
		updateRowsAndCols();
		heraldChange.dispatch(this);
		return value;
	}
}