package temperate.components;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import temperate.components.parametrization.CRasterParameters;
import temperate.core.CMath;
import temperate.raster.Scale3GridDrawer;

class CRasterThumb extends ACButton
{
	var _horizontal:Bool;
	
	public function new(horizontal:Bool) 
	{
		_horizontal = horizontal;
		super();
	}
	
	var _size_upValid:Bool;
	
	var _drawer:Scale3GridDrawer;
	var _bg:Shape;
	
	override function init()
	{
		_parameters = [];
		minSize = 10;
		minSizeWithIcon = 20;
		
		iconOffsetX = 0;
		iconOffsetY = 0;
		
		_bg = new Shape();
		addChild(_bg);
		
		_iconBitmap = new Bitmap();
		addChild(_iconBitmap);
		
		_drawer = new Scale3GridDrawer(_horizontal, _bg.graphics);
	}
	
	var _parameters:Array<CRasterParameters>;
		
	public function getState(state:CButtonState):CRasterParameters
	{
		var parameters = _parameters[state.index];
		if (parameters == null)
		{
			parameters = new CRasterParameters();
			_parameters[state.index] = parameters;
		}
		if (state == CButtonState.UP)
		{
			_size_upValid = false;
			_size_valid = false;
			postponeSize();
		}
		if (state == _state)
		{
			_view_valid = false;
			postponeView();
		}
		return parameters;
	}
	
	override function doUpdateState()
	{
		_view_valid = false;
		postponeView();
	}
	
	override function doValidateSize()
	{
		if (!_size_upValid)
		{
			_size_upValid = true;
			
			var upParameter = _parameters[CButtonState.UP.index];
			var upBd = upParameter.bitmapData;
			if (upBd != null)
			{
				if (_horizontal)
				{
					_height = upBd.height;
				}
				else
				{
					_width = upBd.width;
				}
			}
			else
			{
				_height = 0;
				_width = 0;
			}
		}
		if (!_size_valid)
		{
			_size_valid = true;
			
			if (_horizontal)
			{
				_width = CMath.max(_isCompactWidth ? 0 : _settedWidth, minSize);
			}
			else
			{
				_height = CMath.max(_isCompactHeight ? 0 : _settedHeight, minSize);
			}
			
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			var upParameters = _parameters[CButtonState.UP.index];
			var parameters = _parameters[_state.index];
			if (parameters == null)
			{
				parameters = upParameters;
			}
			
			if (parameters != null)
			{
				_drawer.setBounds(
					parameters.bgOffsetLeft,
					parameters.bgOffsetTop,
					Std.int(_width) - parameters.bgOffsetLeft + parameters.bgOffsetRight,
					Std.int(_height) - parameters.bgOffsetTop + parameters.bgOffsetBottom
				)
					.setBitmapData(parameters.bitmapData)
					.redraw();
				_bg.filters = parameters.filters;
				_bg.alpha = Math.isNaN(parameters.alpha) ? 1 : parameters.alpha;
			}
			else
			{
				_bg.graphics.clear();
				_bg.filters = null;
				_bg.alpha = 1;
			}
			
			_iconBitmap.x = (Std.int(_width - _iconBitmap.width) >> 1) + iconOffsetX;
			_iconBitmap.y = (Std.int(_height - _iconBitmap.height) >> 1) + iconOffsetY;
			_iconBitmap.visible = _horizontal ?
				_width > minSizeWithIcon :
				_height > minSizeWithIcon;
		}
	}
	
	public function setGrid3Insets(left:Int, right:Int)
	{
		_drawer.setInsets(left, right);
		_view_valid = false;
		postponeView();
	}
	
	public var minSize(default, null):Float;
	public var minSizeWithIcon(default, null):Float;
	
	public function setMinSizeParams(minSize:Float, minSizeWithIcon:Float)
	{
		this.minSize = minSize;
		this.minSizeWithIcon = minSizeWithIcon;
		_size_valid = false;
		postponeSize();
	}
	
	var _iconBitmap:Bitmap;
	
	public var icon(default, null):BitmapData;
	public var iconOffsetX(default, null):Int;
	public var iconOffsetY(default, null):Int;
	
	public function setIcon(icon:BitmapData, offsetX:Int, offsetY:Int)
	{
		this.icon = icon;
		iconOffsetX = offsetX;
		iconOffsetY = offsetY;
		_iconBitmap.bitmapData = icon;
		_view_valid = false;
		postponeView();
	}
	
	override function updateState()
	{
		if (_enabled)
		{
			if (_isDown)
			{
				_state = _selected ? CButtonState.DOWN_SELECTED : CButtonState.DOWN;
			}
			else if (_isOver)
			{
				_state = _selected ? CButtonState.OVER_SELECTED : CButtonState.OVER;
			}
			else
			{
				_state = _selected ? CButtonState.UP_SELECTED : CButtonState.UP;
			}
		}
		else
		{
			_state = _selected ? CButtonState.DISABLED_SELECTED : CButtonState.DISABLED;
		}
		doUpdateState();
	}
}