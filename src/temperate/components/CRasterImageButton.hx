package temperate.components;
import flash.display.DisplayObject;
import flash.display.Shape;
import temperate.components.parametrization.CImageParameters;
import temperate.core.CMath;
import temperate.docks.CRightDock;
import temperate.docks.ICDock;
import temperate.raster.CScale9GridDrawer;

class CRasterImageButton extends ACRasterTextButton
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
		
		_imageParameters = [];
		_drawer = new CScale9GridDrawer(_bg.graphics);
		textIndentLeft = 5;
		textIndentRight = 5;
		textIndentTop = 3;
		textIndentBottom = 3;
		
		_textDock = new CRightDock(5, .5);
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
			_textDock.noTargetMode = _text == null;
			var imageWidth = 0;
			var imageHeight = 0;
			var upImageParameters = _imageParameters[CButtonState.UP.index];
			if (upImageParameters != null)
			{
				var upImage = upImageParameters.image;
				if (upImage != null)
				{
					imageWidth = Std.int(upImage.width);
					imageHeight = Std.int(upImage.height);
				}
			}
			_textDock.arrange(
				CMath.intMax(0, getNeededWidth() - textIndentLeft - textIndentRight),
				CMath.intMax(0, getNeededHeight() - textIndentTop - textIndentBottom),
				imageWidth, imageHeight,
				_tfWidth, _tfHeight);
			_width = _textDock.width + textIndentLeft + textIndentRight;
			_height = _textDock.height + textIndentTop + textIndentBottom;
			
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
					Std.int(_height) - parameters.bgOffsetTop + parameters.bgOffsetBottom)
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
			
			var newImage = getStateImage();
			if (_currentImage != newImage)
			{
				if (_currentImage != null)
				{
					removeChild(_currentImage);
				}
				_currentImage = newImage;
				if (_currentImage != null)
				{
					addChild(_currentImage);
				}
			}
			var imageOffsetX = 0;
			var imageOffsetY = 0;
			var imageParameters = _imageParameters[_state.index];
			if (imageParameters == null)
			{
				imageParameters = _imageParameters[CButtonState.UP_SELECTED.index];
			}
			if (imageParameters != null)
			{
				_currentImage.filters = imageParameters.filters;
				_currentImage.alpha = Math.isNaN(imageParameters.alpha) ?
					1 : imageParameters.alpha;
				imageOffsetX = imageParameters.offsetX;
				imageOffsetY = imageParameters.offsetY;
			}
			
			if (_currentImage != null)
			{
				_currentImage.x = _textDock.mainX +
					(parameters != null ? parameters.textOffsetX : 0) +
					textIndentLeft + imageOffsetX;
				_currentImage.y = _textDock.mainY +
					(parameters != null ? parameters.textOffsetY : 0) +
					textIndentTop + imageOffsetY;
			}
			_tf.x = _textDock.targetX + (parameters != null ? parameters.textOffsetX : 0) +
				textIndentLeft;
			_tf.y = _textDock.targetY + (parameters != null ? parameters.textOffsetY : 0) +
				textIndentTop;
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
	
	var _imageParameters:Array<CImageParameters>;
	var _currentImage:DisplayObject;
		
	public function getImage(state:CButtonState):CImageParameters
	{
		var parameters = _imageParameters[state.index];
		if (parameters == null)
		{
			parameters = new CImageParameters();
			_imageParameters[state.index] = parameters;
		}
		if (state == CButtonState.UP)
		{
			_size_upValid = false;
			_size_tfValid = false;
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
	
	function getStateImage()
	{
		var image = null;
		var imageParameters = _imageParameters[_state.index];
		if (imageParameters != null)
		{
			image = imageParameters.image;
		}
		if (image == null && _state.selected)
		{
			var parameters = _imageParameters[CButtonState.UP_SELECTED.index];
			if (parameters != null)
			{
				image = parameters.image;
			}
		}
		if (image == null)
		{
			var parameters = _imageParameters[CButtonState.UP.index];
			if (parameters != null)
			{
				image = parameters.image;
			}
		}
		return image;
	}
}