package temperate.layouts.parametrization;
import flash.display.DisplayObject;
import temperate.core.CMath;

class CChildWrapper 
{
	public function new(child:DisplayObject)
	{
		_child = child;
		_childAlignX = 0;
		_childAlignY = 0;
		_fixedHeight = -1;
		_fixedWidth = -1;
		alignX = 0;
		alignY = 0;
		x = 0;
		y = 0;
		_minWidth = 0;
		_minHeight = 0;
		_maxWidth = CMath.INT_MAX_VALUE;
		_maxHeight = CMath.INT_MAX_VALUE;
	}
	
	var _child:DisplayObject;
	
	public var x:Float;
	public var y:Float;
	
	/**
	 * [optional] percentWidth (component scaled by width if this parameter exists only)
	 */
	public var widthPortion(default, null):Float;
	
	/**
	 * [optional] percentHeight (component scaled by height if this parameter exists only)
	 */
	public var heightPortion(default, null):Float;
	
	public function setPercents(percentsWidth:Int = -1, percentsHeight:Int = -1):CChildWrapper
	{
		widthPortion = percentsWidth != -1 ? CMath.max(.01, percentsWidth * .01) : Math.NaN;
		heightPortion = percentsHeight != -1 ? CMath.max(.01, percentsHeight * .01) : Math.NaN;
		return this;
	}
	
	inline public function getWidth():Float
	{
		return _fixedWidth != -1 ? _fixedWidth : _child.width + _indentLeft + _indentRight;
	}
	
	inline public function setWidth(value:Float):Void
	{
		if (value < _minWidth)
		{
			value = _minWidth;
		}
		else if (value > _maxWidth)
		{
			value = _maxWidth;
		}
		if (_fixedWidth == -1)
		{
			_child.width = value - _indentLeft - _indentRight;
		}
	}
	
	inline public function getHeight():Float
	{
		return _fixedHeight != -1 ? _fixedHeight : _child.height + _indentTop + _indentBottom;
	}
	
	inline public function setHeight(value:Float):Void
	{
		if (value < _minHeight)
		{
			value = _minHeight;
		}
		else if (value > _maxHeight)
		{
			value = _maxHeight;
		}
		if (_fixedHeight == -1)
		{
			_child.height = value - _indentTop - _indentBottom;
		}
	}
	
	public var alignX(default, null):Float;
	public var alignY(default, null):Float;
	
	/**
	 * @param	alignX	0 - by left, 1 - by right, .5 - by center
	 * @param	alignY	0 - by top, 1 - by bottom, .5 - by center
	 */
	public function setAlign(alignX:Float = 0, alignY:Float = 0):CChildWrapper
	{
		this.alignX = alignX;
		this.alignY = alignY;
		return this;
	}
	
	var _offsetX:Int;
	var _offsetY:Int;
	
	public function setOffsets(offsetX:Int = 0, offsetY:Int = 0):CChildWrapper
	{
		_offsetX = offsetX;
		_offsetY = offsetY;
		return this;
	}
	
	var _childAlignX:Float;
	var _childAlignY:Float;
	
	/**
	 * [optional] childAlignX (takes to account if fixedWidth exists)
	 * [optional] childAlignY (takes to account if fixedHeight exists)
	 */
	public function setChildAlign(alignX:Float = 0, alignY:Float = 0):CChildWrapper
	{
		_childAlignX = alignX;
		_childAlignY = alignY;
		return this;
	}
	
	var _fixedWidth:Int;
	var _fixedHeight:Int;
	
	/**
	 * [optional] fixedWidth
	 * [optional] fixedHeight
	 */
	public function setFixedSize(fixedWidth:Int = -1, fixedHeight:Int = -1):CChildWrapper
	{
		_fixedWidth = fixedWidth;
		_fixedHeight = fixedHeight;
		return this;
	}
	
	var _minWidth:Int;
	var _minHeight:Int;
	var _maxWidth:Int;
	var _maxHeight:Int;
	
	/**
	 * Works only if persentage scaling on
	 */
	public function setContingencies(
		minWidth:Int = 0, maxWidth:Int = CMath.INT_MAX_VALUE,
		minHeight:Int = 0, maxHeight:Int = CMath.INT_MAX_VALUE):CChildWrapper
	{
		_minWidth = minWidth;
		_maxWidth = maxWidth;
		_minHeight = minHeight;
		_maxHeight = maxHeight;
		return this;
	}
	
	var _indentLeft:Int;
	var _indentRight:Int;
	var _indentTop:Int;
	var _indentBottom:Int;
	
	public function setIndents(
		left:Int = 0, right:Int = 0, top:Int = 0, bottom:Int = 0):CChildWrapper
	{
		_indentLeft = left;
		_indentRight = right;
		_indentTop = top;
		_indentBottom = bottom;
		return this;
	}
	
	public function updatePosition(globalOffsetX:Int, globalOffsetY:Int):Void
	{
		_child.x = Std.int(
			_fixedWidth == -1 ?
				x + _indentLeft + _offsetX :
				x + _indentLeft + (getWidth() - _child.width) * _childAlignX + _offsetX
		) + globalOffsetX;
		_child.y = Std.int(
			_fixedHeight == -1 ?
				y + _indentTop + _offsetY :
				y + _indentTop + (getHeight() - _child.height) * _childAlignY + _offsetY
		) + globalOffsetY;
	}
}