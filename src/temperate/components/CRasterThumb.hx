package temperate.components;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import temperate.components.parametrization.CRasterParams;
import temperate.core.CMath;
import temperate.raster.CScale3GridDrawer;

class CRasterThumb extends ACButton
{
	var _horizontal:Bool;
	
	public function new(horizontal:Bool) 
	{
		_horizontal = horizontal;
		super();
		selectState = CButtonState.selectStateThumb;
	}
	
	var _size_upValid:Bool;
	
	var _drawer:CScale3GridDrawer;
	var _bg:Shape;
	
	override function init()
	{
		_params = [];
		minSize = 10;
		minSizeWithIcon = 20;
		
		iconOffsetX = 0;
		iconOffsetY = 0;
		
		_bg = new Shape();
		addChild(_bg);
		
		_iconBitmap = new Bitmap();
		addChild(_iconBitmap);
		
		_drawer = new CScale3GridDrawer(_horizontal, _bg.graphics);
	}
	
	var _params:Array<CRasterParams>;
		
	public function getState(state:CButtonState):CRasterParams
	{
		var params = _params[state.index];
		if (params == null)
		{
			params = new CRasterParams();
			_params[state.index] = params;
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
		return params;
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
			
			var upParameter = _params[CButtonState.UP.index];
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
			
			var upParams = _params[CButtonState.UP.index];
			var params = _params[_state.index];
			if (params == null)
			{
				params = upParams;
			}
			
			if (params != null)
			{
				_drawer.setBounds(
					params.bgOffsetLeft,
					params.bgOffsetTop,
					Std.int(_width) - params.bgOffsetLeft + params.bgOffsetRight,
					Std.int(_height) - params.bgOffsetTop + params.bgOffsetBottom
				)
					.setBitmapData(params.bitmapData)
					.redraw();
				_bg.filters = params.filters;
				_bg.alpha = Math.isNaN(params.alpha) ? 1 : params.alpha;
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
}