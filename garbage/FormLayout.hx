package temperate.layouts;
import flash.display.Graphics;
import flash.Lib;
import temperate.layouts.utility.LayoutAlgoritms;
import temperate.layouts.utility.SizeInfo;
import temperate.controls.text.Label;
import temperate.utils.Maths;
import temperate.layouts.ExcessSpaceMode;
import temperate.layouts.FormLayoutMode;

class FormLayout extends AGridLayout
{
	public var graphics:Graphics;
	
	var _rows:Array<Dynamic>;
	
	public function new() 
	{
		_numCols = 2;
		
		super();
		
		_rows = [];
		_excessSpaceModeX = MOVE_TO_EDGES(.5);
		_excessSpaceModeY = UNIFORM;
		_formLayoutMode = KDE;
	}
	
	// PROTECTED METHODS
	
	inline function register(component:ILayoutable)
	{
		heraldAddChild.dispatch(component);
	}
	
	inline function unregister(component:ILayoutable)
	{
		heraldRemoveChild.dispatch(component);
	}
	
	// PUBLIC METHODS
	
	public function add(component:ILayoutable, index:Int = Maths.INT_NULL)
	{
		if (component == null)
		{
			return 0;
		}
		
		register(component);
		
		if (index > 0 && index < _rows.length)
		{
			_rows.insert(index, component);
		}
		else
		{
			index = _rows.push(component);
		}
		setNum(false, _rows.length);
		heraldChange.dispatch(this);
		return index;
	}
	
	public function addLabel(text:String, index:Int = Maths.INT_NULL)
	{
		if (text != null)
		{
			var label = new Label(text);
			return add(label);
		}
		return 0;
	}
	
	public function addLabeled(?text:String, ?component:ILayoutable, index:Int = Maths.INT_NULL)
	{
		var label = text != null ? new Label(text) : null;
		return addRow(label, component, index);
	}
	
	public function addRow(?label:ILayoutable, ?component:ILayoutable, index:Int = Maths.INT_NULL)
	{
		if (label == null && component == null)
		{
			return 0;
		}
		
		if (label != null)
		{
			register(label);
		}
		if (component != null)
		{
			register(component);
		}
		
		var row = [label, component];
		if (index > 0 && index < _rows.length)
		{
			_rows.insert(index, row);
		}
		else
		{
			index = _rows.push(row);
		}
		setNum(false, _rows.length);
		heraldChange.dispatch(this);
		return index;
	}
	
	public override function setColSize(index:Int, value:Float)
	{
		if (index > 1)
		{
			return;
		}
		super.setColSize(index, value);
	}
	
	public override function setColPercents(index:Int, value:Float)
	{
		if (index > 1)
		{
			return;
		}
		super.setColPercents(index, value);
	}
	
	public override function arrange()
	{
		var numRows = _rows.length;
		
		var gapX = _gapX;
		var gapY = _gapY;
		var sumGapY = numRows > 1 ? (numRows - 1) * gapY : 0;
		
		if (_autoSize)
		{
			width = gapX + .1;
			height = sumGapY + .1;
		}
		else
		{
			if (width < gapX + .1)
			{
				width = gapX + .1;
			}
			if (height < sumGapY + .1)
			{
				height = sumGapY + .1;
			}
		}
		
		if (graphics != null)
		{
			graphics.clear();
		}
		
		// Distribute X
		
		var isForceScale = _formLayoutMode == COMMON || _formLayoutMode == KDE;
		
		var leftInfo = _colInfos[0];
		leftInfo.min = 0;
		leftInfo.max = 0;
		
		var rightInfo = _colInfos[1];
		rightInfo.min = 0;
		rightInfo.max = 0;
		
		var centerMin = 0.;
		var centerMax = 0.;
		for (row in _rows)
		{
			var component = Lib.as(row, ILayoutable);
			if (component != null)
			{
				if (isXScaled(component) || isYScaled(component))
				{
					disableComponent(component);
				}
				
				var min;
				var max;
				if (isXScaled(component))
				{
					component.width = 0;
					min = component.width;
					component.width = width;
					max = component.width;
				}
				else
				{
					max = min = component.width;
				}
				if (centerMin < min)
				{
					centerMin = min;
				}
				if (centerMax < max)
				{
					centerMax = max;
				}
			}
			else
			{
				for (i in 0 ... 2)
				{
					var component:ILayoutable = row[i];
					if (component != null)
					{
						var isXScaledComponent = isXScaled(component) || i == 1 && isForceScale;
						if (isXScaledComponent || isYScaled(component))
						{
							disableComponent(component);
						}
						
						var min;
						var max;
						if (isXScaledComponent)
						{	
							component.width = 0;
							min = component.width;
							component.width = width;
							max = component.width;
						}
						else
						{
							max = min = component.width;
						}
						var info = _colInfos[i];
						if (info.min < min)
						{
							info.min = min;
						}
						if (info.max < max)
						{
							info.max = max;
						}
					}
				}
			}
		}
		
		for (i in 0 ... 2)
		{
			var info = _colInfos[i];
			if (!isCellScaled(info))
			{
				var fixed = info.gridSize;
				if (fixed < info.min)
				{
					fixed = info.min;
				}
				info.max = fixed;
				info.min = fixed;
			}
		}
		
		var leftMin = leftInfo.min;
		var rightMin = rightInfo.min;
		var leftMax = leftInfo.max;
		var rightMax = rightInfo.max;
		
		var minWidth = Math.max(leftMin + rightMin + gapX, centerMin);
		if (width < minWidth)
		{
			width = minWidth;
		}
		var pureWidth = width - gapX;
		
		var leftWidth;
		var rightWidth;
		var left = 0.;
		if (pureWidth > leftMax + rightMax)
		{
			var delta = pureWidth - leftMax - rightMax;
			switch (_excessSpaceModeX)
			{
				case UNIFORM:
					leftWidth = leftMax + delta * .5;
					rightWidth = rightMax + delta * .5;
				case COMPACT_CONTAINER:
					if (leftMax + rightMax + gapX > centerMin)
					{
						width = leftMax + rightMax + gapX;
						leftWidth = leftMax;
						rightWidth = rightMax;
					}
					else
					{
						leftWidth = leftMax + delta * .5;
						rightWidth = rightMax + delta * .5;
					}
				case INCREASE_GAPS:
					gapX += delta;
					leftWidth = leftMax;
					rightWidth = rightMax;
				case MOVE_TO_EDGES(align):
					if (leftMax + rightMax + gapX > centerMin)
					{
						left = align * delta;
						leftWidth = leftMax;
						rightWidth = rightMax;
					}
					else
					{
						leftWidth = leftMax + delta * .5;
						rightWidth = rightMax + delta * .5;
					}
			}
		}
		else
		{
			LayoutAlgoritms.distributeProportionally(pureWidth, leftInfo.portion + rightInfo.portion, _colInfos);
			leftWidth = leftInfo.size;
			rightWidth = rightInfo.size;
		}
		
		// begin distribute Y
		
		var isIndividualMode = _formLayoutMode == INDIVIDUAL;
		var leftAlign = _formLayoutMode == COMMON ? 0. : 1.;
		
		var infos = [];
		var sumPortion = 0.;
		var leftForRightCol = left + leftWidth + gapX;
		for (i in 0 ... numRows)
		{
			var row:Dynamic = _rows[i];
			var info = _rowInfos[i];
			
			var min = 0.;
			var max = 0.;
			
			var component = Lib.as(row, ILayoutable);
			if (component != null)
			{
				if (isXScaled(component))
				{
					component.width = component.widthPortion * width;
				}
				component.x = (width - component.width) * component.alignX;
				
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
			}
			else
			{
				var component:ILayoutable = row[0];
				if (component != null)
				{
					if (isXScaled(component))
					{
						component.width = component.widthPortion * leftWidth;
					}
					var align = isIndividualMode ? component.alignX : leftAlign;
					component.x = left + (leftWidth - component.width) * align;
					
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
				}
				var component:ILayoutable = row[1];
				if (component != null)
				{
					if (isXScaled(component))
					{
						component.width = component.widthPortion * rightWidth;
					}
					else if (isForceScale)
					{
						component.width = rightWidth;
					}
					component.x = leftForRightCol + (rightWidth - component.width) * component.alignX;
					
					var subMin;
					var subMax;
					if (isYScaled(component))
					{
						component.height = height;
						subMax = component.height;
						component.height = 0;
						subMin = component.height;
					}
					else
					{
						subMax = subMin = component.height;
					}
					if (min < subMin)
					{
						min = subMin;
					}
					if (max < subMax)
					{
						max = subMax;
					}
				}
			}
			if (!isCellScaled(info))
			{
				var size = info.gridSize;
				if (size < min)
				{
					size = min;
				}
				info.min = info.max = size;
			}
			else
			{
				info.min = min;
				info.max = max;
			}
			infos.push(info);
			sumPortion += info.portion;
		}
		
		// Distribute Y
		
		var space = LayoutAlgoritms.distributeProportionally(height - sumGapY, sumPortion, infos);
		
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
		
		var offset = space * globalAlign;
		for (i in 0 ... numRows)
		{
			var row:Dynamic = _rows[i];
			
			var info = infos[i];
			var rowHeight = info.size + additional;
			info.dispose();
			
			var component = Lib.as(row, ILayoutable);
			if (component != null)
			{
				if (isYScaled(component))
				{
					component.height = rowHeight * component.heightPortion;
				}
				component.y = offset + (rowHeight - component.height) * component.alignY;
				
				if (isXScaled(component) || isYScaled(component))
				{
					enableComponent(component);
				}
			}
			else
			{
				var component:ILayoutable = row[0];
				if (component != null)
				{
					if (isYScaled(component))
					{
						component.height = rowHeight * component.heightPortion;
					}
					component.y = offset + (rowHeight - component.height) * component.alignY;
					
					if (isXScaled(component) || isYScaled(component))
					{
						enableComponent(component);
					}
				}
				var component:ILayoutable = row[1];
				if (component != null)
				{
					if (isYScaled(component))
					{
						component.height = rowHeight * component.heightPortion;
					}
					component.y = offset + (rowHeight - component.height) * component.alignY;
					
					if (isXScaled(component) || isYScaled(component) || isForceScale)
					{
						enableComponent(component);
					}
				}
			}
			offset += rowHeight + gapY;
		}
		
		height = offset - gapY + (1 - globalAlign) * space;
		
		if (graphics != null)
		{
			graphics.lineStyle(0, 0xff0000);
			graphics.drawRect(0, 0, width, height);
			
			graphics.moveTo(left + leftWidth, 0);
			graphics.lineTo(left + leftWidth, height);
			
			graphics.moveTo(leftForRightCol, 0);
			graphics.lineTo(leftForRightCol, height);
			
			graphics.moveTo(leftForRightCol + rightWidth, 0);
			graphics.lineTo(leftForRightCol + rightWidth, height);
		}
	}
	
	public function remove(component:ILayoutable)
	{
		for (i in 0 ... _rows.length)
		{
			var row = _rows[i];
			var componentI = Lib.as(row, ILayoutable);
			if (componentI != null)
			{
				if (componentI == component)
				{
					unregister(component);
					_rows.splice(i, 1);
					break;
				}
			}
			else
			{
				if (row[0] == component)
				{
					unregister(component);
					if (row[1] != null)
					{
						row[0] = null;
					}
					else
					{
						_rows.splice(i, 1);
					}
					break;
				}
				else if (row[1] == component)
				{
					unregister(component);
					if (row[0] != null)
					{
						row[1] = null;
					}
					else
					{
						_rows.splice(i, 1);
					}
					break;
				}
			}
		}
	}
	
	public function removeRow(index:Int)
	{
		var row = _rows[index];
		if (row == null)
		{
			return;
		}
		
		var component = Lib.as(row, ILayoutable);
		if (component != null)
		{
			unregister(component);
		}
		else
		{
			var component = row[0];
			if (component != null)
			{
				unregister(component);
			}
			var component = row[1];
			if (component != null)
			{
				unregister(component);
			}
		}
		_rows.splice(index, 1);
	}
	
	public override function removeAll()
	{
		for (component in this)
		{
			unregister(component);
		}
		_rows = [];
	}
	
	override function iterator():Iterator<ILayoutable>
	{
		return new FormIterator(_rows);
	}
	
	// PROPERTIES
	
	override function getNumRows()
	{
		return _rows.length;
	}
	
	public var formLayoutMode(getFormLayoutMode, setFormLayoutMode):FormLayoutMode;
	var _formLayoutMode:FormLayoutMode;
	function getFormLayoutMode()
	{
		return _formLayoutMode;
	}
	function setFormLayoutMode(value)
	{
		_formLayoutMode = value;
		heraldChange.dispatch(this);
		return value;
	}
}

private class FormIterator
{
	var _rowIndex:Int;
	
	var _colIndex:Int;
	
	public function new(rows:Array<Dynamic>)
	{
		_rows = rows;
		_rowIndex = rows.length - 1;
	}
	
	var _rows:Array<Dynamic>;
	
	var _next:ILayoutable;
	
	public function hasNext()
	{
		if (_next == null)
		{
			_next = findNext();
		}
		return _next != null;
	}
	
	public function next()
	{
		var result;
		if (_next != null)
		{
			result = _next;
			_next = null;
		}
		else
		{
			result = findNext();
		}
		return result;
	}
	
	inline function findNext()
	{
		var result:ILayoutable = null;
		while (result == null && _rowIndex >= 0)
		{
			var row:Dynamic = _rows[_rowIndex];
			result = Lib.as(row, ILayoutable);
			if (result != null)
			{
				_rowIndex--;
				_colIndex = 0;
			}
			else
			{
				result = row[_colIndex++];
				
				if (_colIndex > 1)
				{
					_rowIndex--;
					_colIndex = 0;
				}
				else if (result == null)
				{
					result = row[1];
					_rowIndex--;
					_colIndex = 0;
				}
			}
		}
		return result;
	}
}