package temperate.components;
import flash.display.Shape;
import temperate.core.CMath;
import temperate.raster.CScale9GridDrawer;

class CRasterScaledButton extends ACRasterTextButton
{
	public function new() 
	{
		super();
	}
	
	var _drawer:CScale9GridDrawer;
	var _bg:Shape;
	
	override function init()
	{
		_bg = new Shape();
		addChild(_bg);
		
		super.init();
		
		_textAlignX = .5;
		_textAlignY = .5;
		_drawer = new CScale9GridDrawer(_bg.graphics);
		textIndentLeft = 5;
		textIndentRight = 5;
		textIndentTop = 3;
		textIndentBottom = 3;
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
		}
		size_tfValidate();
		if (!_size_valid)
		{
			_size_valid = true;
			
			var minWidth = _tfWidth + textIndentLeft + textIndentRight;
			_width = CMath.max(_isCompactWidth ? 0 : _settedWidth, minWidth);
			
			var minHeight = _tfHeight + textIndentTop + textIndentBottom;
			_height = CMath.max(_isCompactHeight ? 0 : _settedHeight, minHeight);
			
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
			
			var format = getCurrentFormat(params, upParams);
			format.applyTo(_tf);
			
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
			
			_tf.x = Std.int(
				_textAlignX * 
				(_width - _measuringTf.width - textIndentLeft - textIndentRight) +
				textIndentLeft
			) + (params != null ? params.textOffsetX : 0);
			_tf.y = Std.int(
				_textAlignY * 
				(_height - _measuringTf.height - textIndentTop - textIndentBottom) +
				textIndentTop
			) + (params != null ? params.textOffsetY : 0);
		}
	}
	
	public var textIndentLeft(default, null):Int;
	
	public var textIndentRight(default, null):Int;
	
	public var textIndentTop(default, null):Int;
	
	public var textIndentBottom(default, null):Int;
	
	public function setTextIndents(left:Int, right:Int, top:Int, bottom:Int)
	{
		textIndentLeft = left;
		textIndentRight = right;
		textIndentTop = top;
		textIndentBottom = bottom;
		_size_valid = false;
		postponeSize();
	}
	
	public function setGrid9Insets(left:Int, right:Int, top:Int, bottom:Int)
	{
		_drawer.setInsets(left, right, top, bottom);
		_size_valid = false;
		postponeSize();
	}
	
	public var textAlignX(get_textAlignX, null):Float;
	var _textAlignX:Float;
	function get_textAlignX()
	{
		return _textAlignX;
	}
	
	public var textAlignY(get_textAlignY, null):Float;
	var _textAlignY:Float;
	function get_textAlignY()
	{
		return _textAlignY;
	}
	
	public function setTextAlign(alignX:Float, alignY:Float)
	{
		_textAlignX = alignX;
		_textAlignY = alignY;
		_view_valid = false;
		postponeView();
	}
}