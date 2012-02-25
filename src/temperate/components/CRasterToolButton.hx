package temperate.components;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.components.parametrization.CImageParams;
import temperate.components.parametrization.CRasterParams;
import temperate.core.CMath;
import temperate.core.CSprite;

class CRasterToolButton extends CSprite, implements ICButton
{
	public function new() 
	{
		super();
		
		imageAlignX = .5;
		imageAlignY = .5;
		imageIndentLeft = 4;
		imageIndentRight = 4;
		imageIndentTop = 4;
		imageIndentBottom = 4;
		_bitmap = new Bitmap();
		addChild(_bitmap);
		view = this;
		_selected = false;
		_state = CButtonState.UP;
		selectState = CButtonState.selectStateNormal;
		_params = [];
		_imageParams = [];
		updateEnabled();
	}
	
	var _size_upValid:Bool;
	var _view_imageValid:Bool;
	
	public var view(default, null):DisplayObject;
	
	var _bitmap:Bitmap;
	var _isDown:Bool;
	var _isOver:Bool;
	var _bdWidth:Int;
	var _bdHeight:Int;
	
	override function set_isEnabled(value:Bool)
	{
		if (_isEnabled != value)
		{
			_isEnabled = value;
			updateEnabled();
		}
		return value;
	}
	
	function updateEnabled()
	{
		buttonMode = _isEnabled;
		if (_isEnabled)
		{
			removeEventListener(MouseEvent.CLICK, onBlockMouse);
			removeEventListener(MouseEvent.MOUSE_DOWN, onBlockMouse);
			removeEventListener(MouseEvent.MOUSE_UP, onBlockMouse);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		}
		else
		{
			_isOver = false;
			_isDown = false;
			
			addEventListener(MouseEvent.CLICK, onBlockMouse, false, CMath.INT_MAX_VALUE);
			addEventListener(MouseEvent.MOUSE_DOWN, onBlockMouse, false, CMath.INT_MAX_VALUE);
			addEventListener(MouseEvent.MOUSE_UP, onBlockMouse, false, CMath.INT_MAX_VALUE);
			
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
			removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
			if (stage != null)
			{
				stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			}
		}
		updateState();
	}
	
	function onBlockMouse(event:MouseEvent)
	{
		event.stopImmediatePropagation();
	}
	
	function onMouseDown(event:MouseEvent)
	{
		if (!_isEnabled)
		{
			event.stopImmediatePropagation();
			return;
		}
		
		if (stage == null)
		{
			return;
		}
		stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		_isDown = true;
		updateState();
	}
	
	function onStageMouseUp(event:MouseEvent)
	{
		stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		if (!_isEnabled)
		{
			event.stopImmediatePropagation();
			return;
		}
		
		_isDown = false;
		updateState();
	}

	function onRollOver(event:MouseEvent)
	{
		_isOver = true;
		updateState();
	}
	
	function onRollOut(event:MouseEvent)
	{
		_isOver = false;
		updateState();
	}
	
	public var selected(get_selected, set_selected):Bool;
	var _selected:Bool;
	function get_selected():Bool
	{
		return _selected;
	}
	function set_selected(value:Bool)
	{
		if (_selected != value)
		{
			_selected = value;
			updateState();
		}
		return _selected;
	}
	
	public function setUseHandCursor(value:Bool):Void
	{
		this.useHandCursor = value;
	}
	
	var _state:CButtonState;
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
			_view_imageValid = false;
			postponeSize();
		}
		if (state == _state)
		{
			_view_valid = false;
			postponeView();
		}
		return params;
	}
	
	function updateState()
	{
		_state = selectState(_isDown, _isOver, _selected, _isEnabled);
		doUpdateState();
	}
	
	public dynamic function selectState(
		isDown:Bool, isOver:Bool, selected:Bool, enabled:Bool):CButtonState
	{
		return null;
	}
	
	function doUpdateState()
	{
		_view_valid = false;
		_view_imageValid = false;
		postponeView();
	}
	
	override function doValidateSize()
	{
		if (!_size_upValid)
		{
			_size_upValid = true;
			
			var upParams = _params[CButtonState.UP.index];
			var upBitmapData = null;
			if (upParams != null)
			{
				upBitmapData = upParams.bitmapData;
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
		if (!_size_valid)
		{
			_size_valid = true;
			
			_width = _bdWidth;
			_height = _bdHeight;
			
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
				_bitmap.bitmapData = params.bitmapData;
				_bitmap.filters = params.filters;
				_bitmap.alpha = Math.isNaN(params.alpha) ? 1 : params.alpha;
			}
			else
			{
				_bitmap.bitmapData = null;
				_bitmap.filters = null;
				_bitmap.alpha = 1;
			}
			
			_bitmap.x = params != null ? params.bgOffsetLeft : 0;
			_bitmap.y = params != null ? params.bgOffsetTop : 0;
		}
		if (!_view_imageValid)
		{
			_view_imageValid = true;
			
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
					_currentImage.filters = imageParams.filters;
					_currentImage.alpha = Math.isNaN(imageParams.alpha) ?
						1 : imageParams.alpha;
					imageOffsetX = imageParams.offsetX;
					imageOffsetY = imageParams.offsetY;
				}
				else
				{
					_currentImage.filters = null;
					_currentImage.alpha = 1;
				}
			}
			
			if (_currentImage != null)
			{
				_currentImage.x = imageIndentLeft + Std.int(
					(_width - imageIndentLeft - imageIndentRight - _currentImage.width) *
					imageAlignX) + imageOffsetX;
				_currentImage.y = imageIndentTop + Std.int(
					(_height - imageIndentTop - imageIndentBottom - _currentImage.height) *
					imageAlignY) + imageOffsetY;
			}
		}
	}
	
	public var imageIndentLeft(default, null):Int;
	
	public var imageIndentRight(default, null):Int;
	
	public var imageIndentTop(default, null):Int;
	
	public var imageIndentBottom(default, null):Int;
	
	public function setImageIndents(left:Int, right:Int, top:Int, bottom:Int):Void
	{
		imageIndentLeft = left;
		imageIndentRight = right;
		imageIndentTop = top;
		imageIndentBottom = bottom;
		_view_imageValid = false;
		postponeView();
	}
	
	public var imageAlignX(default, null):Float;
	
	public var imageAlignY(default, null):Float;
	
	public function setImageAlign(alignX:Float, alingY:Float):Void
	{
		imageAlignX = alignX;
		imageAlignY = alingY;
		_view_imageValid = false;
		postponeView();
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
		if (state == _state)
		{
			_view_imageValid = false;
			postponeView();
		}
		return params;
	}
	
	function getStateImage()
	{
		return CImageParams.getImage(_imageParams, _state);
	}
	
	public var toggle(get_toggle, set_toggle):Bool;
	var _toggle:Bool;
	function get_toggle()
	{
		return _toggle;
	}
	function set_toggle(value)
	{
		if (_toggle != value)
		{
			_toggle = value;
			if (_toggle)
			{
				addEventListener(MouseEvent.CLICK, onClick, false, CMath.INT_MAX_VALUE - 1);
			}
			else
			{
				removeEventListener(MouseEvent.CLICK, onClick);
			}
		}
		return _toggle;
	}
	
	function onClick(event:MouseEvent)
	{
		selected = !selected;
		dispatchEvent(new Event(Event.CHANGE));
	}
}