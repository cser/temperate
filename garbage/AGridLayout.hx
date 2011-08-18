package temperate.layouts;
import temperate.layouts.ILayoutable;
import temperate.layouts.ExcessSpaceMode;
import temperate.layouts.utility.SizeInfo;

class AGridLayout extends ALayout
{
	static inline var DEFAULT_PORTION = .1;
	
	public function new()
	{
		super();
		_colInfos = [];
		_rowInfos = [];
		subResetSizes(true);
		subResetSizes(false);
	}
	
	// PROTECTED METHODS
	
	function subResetSizes(isForX:Bool)
	{
		var infos = isForX ? _colInfos : _rowInfos;
		var num = isForX ? _numCols : _numRows;
		for (i in num ... infos.length)
		{
			infos.pop().dispose();
		}
		for (i in 0 ... num)
		{
			var info = infos[i];
			if (info == null)
			{
				info = SizeInfo.get();
				infos[i] = info;
			}
			info.portion = DEFAULT_PORTION;
			info.gridSize = Math.NaN;
		}
	}
	
	inline function setNum(isForX:Bool, value:Int)
	{
		// Can't to delete - info contains user sizes
		var infos = isForX ? _colInfos : _rowInfos;
		for (i in infos.length ... value)
		{
			var info = SizeInfo.get();
			info.gridSize = Math.NaN;
			info.portion = DEFAULT_PORTION;
			infos[i] = info;
		}
		if (isForX)
		{
			_numCols = value;
		}
		else
		{
			_numRows = value;
		}
	}
	
	inline function isXScaled(component:ILayoutable)
	{
		return !Math.isNaN(component.widthPortion);
	}
	
	inline function isYScaled(component:ILayoutable)
	{
		return !Math.isNaN(component.heightPortion);
	}
	
	inline function isCellScaled(info:SizeInfo)
	{
		return Math.isNaN(info.gridSize);
	}
	
	inline function setSize(index:Int, value:Float, infos:Array<SizeInfo>)
	{
		if (index >= 0)
		{
			var info = infos[index];
			if (info == null)
			{
				info = SizeInfo.get();
				info.portion = DEFAULT_PORTION;
				infos[index] = info;
			}
			info.gridSize = value;
			heraldChange.dispatch(this);
		}
	}
	
	inline function setPercents(index:Int, value:Float, infos:Array<SizeInfo>)
	{
		if (index >= 0 && !Math.isNaN(value))
		{
			var info = infos[index];
			if (info == null)
			{
				info = SizeInfo.get();
				infos[index] = info;
			}
			if (value > 100)
			{
				value = 100;
			}
			else if (value < 1)
			{
				value = 1;
			}
			info.portion = value * .01;
			heraldChange.dispatch(this);
		}
	}
	
	// PUBLIC METHODS
	
	public inline function resetSizes()
	{
		subResetSizes(true);
		subResetSizes(false);
		heraldChange.dispatch(this);
	}
	
	var _colInfos:Array<SizeInfo>;
	
	public function getColSize(index:Int)
	{
		var info = _colInfos[index];
		return info != null ? info.gridSize : Math.NaN;
	}
	
	public function setColSize(index:Int, value:Float)
	{
		setSize(index, value, _colInfos);
	}
	
	public function getColPercents(index:Int)
	{
		var info = _colInfos[index];
		return info != null ? info.portion * 100 : Math.NaN;
	}
	
	public function setColPercents(index:Int, value:Float)
	{
		setPercents(index, value, _colInfos);
	}
	
	var _rowInfos:Array<SizeInfo>;
	
	public function getRowSize(index:Int)
	{
		var info = _rowInfos[index];
		return info != null ? info.gridSize : Math.NaN;
	}
	
	public function setRowSize(index:Int, value:Float)
	{
		setSize(index, value, _rowInfos);
	}
	
	public function getRowPersents(index:Int)
	{
		var info = _rowInfos[index];
		return info != null ? info.portion * 100 : Math.NaN;
	}
	
	public function setRowPercents(index:Int, value:Float)
	{
		setPercents(index, value, _rowInfos);
	}
	
	// PROPERTIES
	
	public var excessSpaceModeX(getExcessSpaceModeX, setExcessSpaceModeX):ExcessSpaceMode;
	var _excessSpaceModeX:ExcessSpaceMode;
	function getExcessSpaceModeX()
	{
		return _excessSpaceModeX;
	}
	function setExcessSpaceModeX(value)
	{
		_excessSpaceModeX = value;
		heraldChange.dispatch(this);
		return value;
	}
	
	public var excessSpaceModeY(getExcessSpaceModeY, setExcessSpaceModeY):ExcessSpaceMode;
	var _excessSpaceModeY:ExcessSpaceMode;
	function getExcessSpaceModeY()
	{
		return _excessSpaceModeY;
	}
	function setExcessSpaceModeY(value)
	{
		_excessSpaceModeY = value;
		heraldChange.dispatch(this);
		return value;
	}
	
	public var numRows(getNumRows, null):Int;
	var _numRows:Int;
	function getNumRows()
	{
		return _numRows;
	}
	
	public var numCols(getNumCols, null):Int;
	var _numCols:Int;
	function getNumCols()
	{
		return _numCols;
	}
}