package temperate.components;
import flash.display.Bitmap;
import temperate.docks.ICDock;
import temperate.docks.CRightDock;

class CRasterFixedButton extends ACRasterTextButton
{
	public function new() 
	{
		super();
	}
	
	var _bitmap:Bitmap;
	
	override function init()
	{
		_bitmap = new Bitmap();
		addChild(_bitmap);
		
		super.init();
		
		_textDock = new CRightDock(5, .5);
	}

	public var textDock(get_textDock, set_textDock):ICDock;
	var _textDock:ICDock;
	function get_textDock()
	{
		return _textDock;
	}
	function set_textDock(value)
	{
		_textDock = value;
		_size_valid = false;
		postponeSize();
		return _textDock;
	}
	
	var _bdWidth:Int;
	var _bdHeight:Int;

	override function doValidateSize()
	{
		if (!_size_upValid)
		{
			_size_upValid = true;
			
			var upParameters = _parameters[CButtonState.UP.index];
			var upBitmapData = null;
			if (upParameters != null)
			{
				upBitmapData = upParameters.bitmapData;
			}
			if (upBitmapData != null)
			{
				_bdWidth = upBitmapData.width;
				_bdHeight = upBitmapData.height;
			}
			else
			{
				_bdWidth = 0;
				_bdHeight = 0;
			}
		}
		size_tfValidate();
		if (!_size_valid)
		{
			_size_valid = true;
			_textDock.noTargetMode = _text == null;
			_textDock.arrange(
				_isCompactWidth ? 0 : Std.int(_settedWidth),
				_isCompactHeight ? 0 : Std.int(_settedHeight),
				_bdWidth, _bdHeight,
				_tfWidth, _tfHeight);
			_width = _textDock.width;
			_height = _textDock.height;
			
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			var g = graphics;
			g.clear();
			g.beginFill(0xffffff, 0);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
			
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
				_bitmap.bitmapData = parameters.bitmapData;
				_bitmap.filters = parameters.filters;
				_bitmap.alpha = Math.isNaN(parameters.alpha) ? 1 : parameters.alpha;
			}
			else
			{
				_bitmap.bitmapData = null;
				_bitmap.filters = null;
				_bitmap.alpha = 1;
			}
			
			_bitmap.x = _textDock.mainX + (parameters != null ? parameters.bgOffsetLeft : 0);
			_bitmap.y = _textDock.mainY + (parameters != null ? parameters.bgOffsetTop : 0);
			_tf.x = _textDock.targetX + (parameters != null ? parameters.textOffsetX : 0);
			_tf.y = _textDock.targetY + (parameters != null ? parameters.textOffsetY : 0);
		}
	}
}