package temperate.components;
import flash.display.DisplayObject;
import flash.display.Shape;
import temperate.components.parametrization.CImageParams;
import temperate.components.parametrization.CRasterParams;
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
		
		_imageParams = [];
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
			var upImageParams = _imageParams[CButtonState.UP.index];
			if (upImageParams != null)
			{
				var upImage = upImageParams.image;
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
			
			var upParams = _params[CButtonState.UP.index];
			var params = _params[_state.index];
			if (params == null)
			{
				params = upParams;
			}
			
			var format = getCurrentFormat(params, upParams);
			format.applyTo(_tf, true);
			
			if (params != null)
			{
				_drawer.setBounds(
					params.bgOffsetLeft,
					params.bgOffsetTop,
					Std.int(_width) - params.bgOffsetLeft + params.bgOffsetRight,
					Std.int(_height) - params.bgOffsetTop + params.bgOffsetBottom)
					.setBitmapData(params.bitmapData)
					.redraw();
				params.applyTransforms(_bg);
			}
			else
			{
				_bg.graphics.clear();
				CRasterParams.clearTransforms(_bg);
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
			if (_currentImage != null)
			{
				var imageParams = _imageParams[_state.index];
				if (imageParams == null)
				{
					imageParams = _imageParams[CButtonState.UP_SELECTED.index];
				}
				if (imageParams != null)
				{
					imageParams.applyTransforms(_currentImage);
					imageOffsetX = imageParams.offsetX;
					imageOffsetY = imageParams.offsetY;
				}
				else
				{
					CImageParams.clearTransforms(_currentImage);
				}
			}
			
			if (_currentImage != null)
			{
				_currentImage.x = _textDock.mainX +
					(params != null ? params.textOffsetX : 0) +
					textIndentLeft + imageOffsetX;
				_currentImage.y = _textDock.mainY +
					(params != null ? params.textOffsetY : 0) +
					textIndentTop + imageOffsetY;
			}
			_tf.x = _textDock.targetX + (params != null ? params.textOffsetX : 0) +
				textIndentLeft;
			_tf.y = _textDock.targetY + (params != null ? params.textOffsetY : 0) +
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
	
	var _imageParams:Array<CImageParams>;
	var _currentImage:DisplayObject;
		
	public function getImage(state:CButtonState):CImageParams
	{
		var params = _imageParams[state.index];
		if (params == null)
		{
			params = new CImageParams();
			_imageParams[state.index] = params;
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
		return params;
	}
	
	function getStateImage()
	{
		return CImageParams.getImage(_imageParams, _state);
	}
}