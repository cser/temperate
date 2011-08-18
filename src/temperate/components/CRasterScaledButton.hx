package temperate.components;
import flash.display.Shape;
import temperate.core.CMath;
import temperate.raster.Scale9GridDrawer;

class CRasterScaledButton extends ACRasterButton
{
	public function new() 
	{
		super();
	}
	
	var _drawer:Scale9GridDrawer;
	var _bg:Shape;
	
	override function init()
	{
		_bg = new Shape();
		addChild(_bg);
		
		super.init();
		
		_textAlignX = .5;
		_textAlignY = .5;
		_drawer = new Scale9GridDrawer(_bg.graphics);
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
			
			var upParameters = _parameters[CButtonState.UP.index];
			var parameters = _parameters[_state.index];
			if (parameters == null)
			{
				parameters = upParameters;
			}
			
			var format = getCurrentFormat(parameters, upParameters);
			format.applyTo(_tf);
			
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
			
			_tf.x = Std.int(
				_textAlignX * 
				(_width - _measuringTf.width - textIndentLeft - textIndentRight) +
				textIndentLeft
			) + (parameters != null ? parameters.textOffsetX : 0);
			_tf.y = Std.int(
				_textAlignY * 
				(_height - _measuringTf.height - textIndentTop - textIndentBottom) +
				textIndentTop
			) + (parameters != null ? parameters.textOffsetY : 0);
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