package temperate.components;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import temperate.components.helpers.CTimerChanger;
import temperate.components.helpers.ICTimerChanger;
import temperate.core.CMath;
import temperate.core.CSprite;
import temperate.errors.CArgumentError;
import temperate.skins.ICScrollSkin;

class CScrollBar extends CSprite
{
	var _horizontal:Bool;
	var _leftArrow:ACButton;
	var _rightArrow:ACButton;
	var _thumb:ACButton;
	var _bgSkin:ICScrollSkin;
	
	var _bg:Sprite;
	
	var _size_pageValid:Bool;
	var _view_positionValid:Bool;
	
	var _timerChanger:ICTimerChanger;
	var _pageTimerChanger:ICTimerChanger;
	
	var _isBgDown:Bool;
	var _isBgDownLeft:Bool;
	
	var _guideCrossOffset:Int;
	var _guideDirectOffset:Int;
	var _guideSize:Int;
	
	public function new(
		horizontal:Bool, leftArrow:ACButton, rightArrow:ACButton, thumb:ACButton,
		bgSkin:ICScrollSkin) 
	{
		_horizontal = horizontal;
		_leftArrow = leftArrow;
		_rightArrow = rightArrow;
		_thumb = thumb;
		_bgSkin = bgSkin;
		
		super();
		
		_minValue = 0;
		_maxValue = 100;
		_value = 0;
		
		_lineScrollSize = 1;
		_pageSize = Math.NaN;
		_pageScrollSize = Math.NaN;
		
		updateOnMove = false;
		
		_isBgDown = false;
		_isBgDownLeft = false;
		
		_bg = new Sprite();
		addChild(_bg);
		
		_bgSkin.link(_horizontal, _bg.addChild, _bg.removeChild, _bg.graphics);
		addChild(_thumb);
		addChild(_leftArrow);
		addChild(_rightArrow);
		
		_timerChanger = newTimerChanger();
		_timerChanger.onIncrease = onIncrease;
		_timerChanger.onDecrease = onDecrease;
		
		_leftArrow.addEventListener(MouseEvent.MOUSE_DOWN, onLeftMouseDown);
		_rightArrow.addEventListener(MouseEvent.MOUSE_DOWN, onRightMouseDown);
		
		_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbMouseDown);
		
		_pageTimerChanger = newPageTimerChanger();
		_pageTimerChanger.onIncrease = onPageIncrease;
		_pageTimerChanger.onDecrease = onPageDecrease;
		
		updateEnabledListeners();
		
		setUseHandCursor(false);
		
		_settedWidth = _horizontal ? 100 : 0;
		_settedHeight = _horizontal ? 0 : 100;
		
		_size_valid = false;
		_view_valid = false;
		postponeSize();
	}
	
	function newTimerChanger():ICTimerChanger
	{
		return new CTimerChanger();
	}
	
	function newPageTimerChanger():ICTimerChanger
	{
		return newTimerChanger();
	}
	
	function onIncrease()
	{
		setValue(_value + _lineScrollSize, true);
	}
	
	function onDecrease()
	{
		setValue(_value - _lineScrollSize, true);
	}
	
	function onLeftMouseDown(event:MouseEvent)
	{
		stage.addEventListener(MouseEvent.MOUSE_UP, onStageLeftMouseUp);
		_leftArrow.addEventListener(MouseEvent.ROLL_OVER, onLeftRollOver);
		_leftArrow.addEventListener(MouseEvent.ROLL_OUT, onLeftRollOut);
		_timerChanger.decreaseDown(false);
	}
	
	function onStageLeftMouseUp(event:MouseEvent)
	{
		stage.removeEventListener(MouseEvent.MOUSE_UP, onStageLeftMouseUp);
		_leftArrow.removeEventListener(MouseEvent.ROLL_OVER, onLeftRollOver);
		_leftArrow.removeEventListener(MouseEvent.ROLL_OUT, onLeftRollOut);
		_timerChanger.up();
	}
	
	function onLeftRollOver(event:MouseEvent)
	{
		_timerChanger.decreaseDown(true);
	}
	
	function onLeftRollOut(event:MouseEvent)
	{
		_timerChanger.up();
	}
	
	function onRightMouseDown(event:MouseEvent)
	{
		stage.addEventListener(MouseEvent.MOUSE_UP, onStageRightMouseUp);
		_rightArrow.addEventListener(MouseEvent.ROLL_OVER, onRightRollOver);
		_rightArrow.addEventListener(MouseEvent.ROLL_OUT, onRightRollOut);
		_timerChanger.increaseDown(false);
	}
	
	function onStageRightMouseUp(event:MouseEvent)
	{
		stage.removeEventListener(MouseEvent.MOUSE_UP, onStageRightMouseUp);
		_rightArrow.removeEventListener(MouseEvent.ROLL_OVER, onRightRollOver);
		_rightArrow.removeEventListener(MouseEvent.ROLL_OUT, onRightRollOut);
		_timerChanger.up();
	}
	
	function onRightRollOver(event:MouseEvent)
	{
		_timerChanger.increaseDown(true);
	}
	
	function onRightRollOut(event:MouseEvent)
	{
		_timerChanger.up();
	}
	
	function updateEnabledListeners()
	{
		if (_enabled)
		{
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_bg.addEventListener(MouseEvent.MOUSE_DOWN, onBgMouseDown);
		}
		else
		{
			removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_bg.removeEventListener(MouseEvent.MOUSE_DOWN, onBgMouseDown);
		}
	}
	
	function onPageDecrease()
	{
		checkPageMouseAndChange(false);
	}
	
	function onPageIncrease()
	{
		checkPageMouseAndChange(true);
	}
	
	function checkPageMouseAndChange(isIncrease:Bool)
	{
		var mousePosition;
		var thumbPosition;
		var thumbSize;
		if (_horizontal)
		{
			mousePosition = _bg.mouseX;
			thumbPosition = _thumb.x;
			thumbSize = _thumb.width;
		}
		else
		{
			mousePosition = _bg.mouseY;
			thumbPosition = _thumb.y;
			thumbSize = _thumb.height;
		}
		if (isIncrease && mousePosition < thumbPosition + thumbSize ||
			!isIncrease && mousePosition > thumbPosition)
		{
			_pageTimerChanger.up();
			_isBgDown = false;
			redrawBg();
		}
		else
		{
			setValue(_value + (isIncrease ? pageScrollSize : -pageScrollSize), true);
			redrawBg();
		}
	}
	
	function getMousePosition()
	{
		return _horizontal ? _bg.mouseX : _bg.mouseY;
	}
	
	function getThumbCenter()
	{
		return Std.int(_horizontal ? _thumb.x + _thumb.width * .5 : _thumb.y + _thumb.height * .5);
	}
	
	function onBgMouseDown(event:MouseEvent)
	{
		_isBgDown = true;
		_isBgDownLeft = getMousePosition() < getThumbCenter();
		if (_isBgDownLeft)
		{
			_pageTimerChanger.decreaseDown(false);
		}
		else
		{
			_pageTimerChanger.increaseDown(false);
		}
		redrawBg();
		
		stage.addEventListener(MouseEvent.MOUSE_UP, onStagePageMouseUp);
		_bg.addEventListener(MouseEvent.ROLL_OVER, onBgRollOver);
		_bg.addEventListener(MouseEvent.ROLL_OUT, onBgRollOut);
	}
	
	function onStagePageMouseUp(event:MouseEvent)
	{
		_bg.removeEventListener(MouseEvent.ROLL_OVER, onBgRollOver);
		_bg.removeEventListener(MouseEvent.ROLL_OUT, onBgRollOut);
		_pageTimerChanger.up();
		_isBgDown = false;
		redrawBg();
	}
	
	function onBgRollOver(event:MouseEvent)
	{
		var currentIsBgDownLeft = getMousePosition() < getThumbCenter();
		if (currentIsBgDownLeft != _isBgDownLeft)
		{
			return;
		}
		
		_isBgDown = true;
		if (_isBgDownLeft)
		{
			_pageTimerChanger.decreaseDown(true);
		}
		else
		{
			_pageTimerChanger.increaseDown(true);
		}
		redrawBg();
	}
	
	function onBgRollOut(event:MouseEvent)
	{
		_pageTimerChanger.up();
		_isBgDown = false;
		redrawBg();
	}
	
	function onThumbMouseDown(event:MouseEvent)
	{
		var rect = _horizontal ? 
			new Rectangle(
				_guideDirectOffset, _guideCrossOffset, _guideSize - Std.int(_thumb.width), 0) :
			new Rectangle(
				_guideCrossOffset, _guideDirectOffset, 0, _guideSize - Std.int(_thumb.height));
		_thumb.startDrag(false, rect);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
	}
	
	function onStageMouseUp(event:MouseEvent)
	{
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		_thumb.stopDrag();
		setThumbPositionByValue();
	}
	
	function onStageMouseMove(event:MouseEvent)
	{
		if (updateOnMove)
		{
			event.updateAfterEvent();
		}
		setValueByThumbPosition();
	}
	
	function onMouseWheel(event:MouseEvent)
	{
		var delta = event.delta;
		var sign = delta > 0 ? -1 : 1;
		setValue(
			_value + sign * _lineScrollSize * CMath.intMax(1, Math.round(CMath.intAbs(delta) / 3)),
			true);
	}
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			updateSize();
			updateBaseArrange();
			
			_size_pageValid = false;
			_view_positionValid = false;
			_view_valid = false;
		}
		if (!_size_pageValid)
		{
			_size_pageValid = true;
			
			updateThumbSize();
			updateThumbVisible();
			
			_view_positionValid = false;
		}
		if (!_view_positionValid || !_view_valid)
		{
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		var needValidateComponents = false;
		if (!_view_positionValid)
		{
			_view_positionValid = true;
			setThumbPositionByValue();
			needValidateComponents = true;
		}
		if (!_view_valid)
		{
			_view_valid = true;
			updateBg();
			needValidateComponents = true;
		}
		if (needValidateComponents)
		{
			// Validation system is not ideal :(
			_thumb.validate();
			_leftArrow.validate();
			_rightArrow.validate();
		}
	}
	
	function updateSize()
	{
		var leftWidth = _leftArrow.width;
		var leftHeight = _leftArrow.height;
		var rightWidth = _rightArrow.width;
		var rightHeight = _rightArrow.height;
		var minWidth;
		var minHeight;
		if (_horizontal)
		{
			minWidth = leftWidth + rightWidth;
			minHeight = CMath.max3(leftHeight, rightHeight, _thumb.height);
		}
		else
		{
			minWidth = CMath.max3(leftWidth, rightWidth, _thumb.width);
			minHeight = leftHeight + rightHeight;
		}
		if (_horizontal)
		{
			_width = _isCompactWidth ?
				minWidth :
				CMath.max(_settedWidth, leftWidth + rightWidth);
			_height = minHeight;
		}
		else
		{
			_width = minWidth;
			_height = _isCompactHeight ?
				minHeight :
				CMath.max(_settedHeight, leftHeight + rightHeight);
		}
	}
	
	function updateBaseArrange()
	{
		_leftArrow.x = 0;
		_leftArrow.y = 0;
		_guideCrossOffset = 0;
		
		if (_horizontal)
		{
			_rightArrow.x = _width - _rightArrow.width;
			_rightArrow.y = 0;
			
			_guideDirectOffset = Std.int(_leftArrow.width);
			_guideSize = Std.int(_width - _leftArrow.width - _rightArrow.width);
		}
		else
		{
			_rightArrow.x = 0;
			_rightArrow.y = _height - _rightArrow.height;
			
			_guideDirectOffset = Std.int(_leftArrow.height);
			_guideSize = Std.int(_height - _leftArrow.height - _rightArrow.height);
		}
	}
	
	function updateThumbVisible()
	{
		var thumbSize = _horizontal ? _thumb.width : _thumb.height;
		_thumb.visible = _enabled && thumbSize < _guideSize && _maxValue > _minValue;
	}
	
	function setThumbPositionByValue()
	{
		var thumbSize = Std.int(_horizontal ? _thumb.width : _thumb.height);
		var delta = _maxValue - _minValue;
		var thumbOffset = _guideDirectOffset + 
			(delta > 0 ?
				Std.int((_guideSize - thumbSize) * (_value - _minValue) / (_maxValue - _minValue)) :
				0);
		if (_horizontal)
		{
			_thumb.x = thumbOffset;
			_thumb.y = _guideCrossOffset;
		}
		else
		{
			_thumb.x = _guideCrossOffset;
			_thumb.y = thumbOffset;
		}
	}
	
	function setValueByThumbPosition()
	{
		var thumbSize = Std.int(_horizontal ? _thumb.width : _thumb.height);
		var thumbOffset = Std.int(_horizontal ? _thumb.x : _thumb.y);
		var rawValue = _minValue +  (thumbOffset - _guideDirectOffset)
			* (_maxValue - _minValue) / (_guideSize - thumbSize);
		var newValue = fixedValue(rawValue);
		if (_value != newValue)
		{
			_value = newValue;
			dispatchEvent(new Event(Event.SCROLL));
		}
	}
	
	function updateBg()
	{
		_bgSkin.setSize(_guideDirectOffset, _guideSize, Std.int(_horizontal ? _width : _height));
		redrawBg();
	}
	
	function redrawBg()
	{
		if (_isBgDown)
		{
			_bgSkin.redrawDown(_isBgDownLeft, getThumbCenter());
		}
		else
		{
			_bgSkin.redrawUp();
		}
	}
	
	function updateThumbSize()
	{
		var pageSize = this.pageSize;
		var delta = _maxValue - _minValue + pageSize;
		var size = Std.int(_guideSize * pageSize / delta);
		if (size < 0 || size > _guideSize)
		{
			size = CMath.intMax(_guideSize - 1, 0);
		}
		if (_horizontal)
		{
			_thumb.width = size;
		}
		else
		{
			_thumb.height = size;
		}
	}
	
	function fixedValue(value:Float)
	{
		if (value <= _minValue)
		{
			return _minValue;
		}
		if (value >= _maxValue)
		{
			return _maxValue;
		}
		value = Math.round(value / _lineScrollSize) * _lineScrollSize;
		if (value < _minValue)
		{
			return _minValue;
		}
		if (value > _maxValue)
		{
			return _maxValue;
		}
		return value;
	}
	
	override function set_enabled(value)
	{
		if (_enabled != value)
		{
			_enabled = value;
			_leftArrow.enabled = _enabled;
			_rightArrow.enabled = _enabled;
			updateThumbVisible();
			updateEnabledListeners();
		}
		return _enabled;
	}
	
	var _useHandCursor:Bool;
	
	@:getter(useHandCursor)
	function get_useHandCursor()
	{
		return _useHandCursor;
	}
	
	@:setter(useHandCursor)
	function set_useHandCursor(value)
	{
		if (_useHandCursor != value)
		{
			setUseHandCursor(value);
		}
	}
	
	function setUseHandCursor(value:Bool)
	{
		_useHandCursor = value;
		_leftArrow.useHandCursor = _useHandCursor;
		_rightArrow.useHandCursor = _useHandCursor;
		_thumb.useHandCursor = _useHandCursor;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Parameters
	//
	//----------------------------------------------------------------------------------------------
	
	public var updateOnMove:Bool;
	
	public var value(get_value, set_value):Float;
	var _value:Float;
	function get_value()
	{
		return _value;
	}
	function set_value(value:Float)
	{
		setValue(value, false);
		return _value;
	}
	
	function setValue(value:Float, needDispatch:Bool)
	{
		var newValue = fixedValue(value);
		if (_value != newValue)
		{
			_value = newValue;
			setThumbPositionByValue();
			if (needDispatch)
			{
				dispatchEvent(new Event(Event.SCROLL));
			}
		}
	}
	
	public var minValue(get_minValue, set_minValue):Float;
	var _minValue:Float;
	function get_minValue()
	{
		return _minValue;
	}
	function set_minValue(value:Float)
	{
		if (_minValue != value)
		{
			_minValue = value;
			_size_pageValid = false;
			_view_positionValid = false;
			_value = fixedValue(_value);
			postponeSize();
		}
		return _minValue;
	}
	
	public var maxValue(get_maxValue, set_maxValue):Float;
	var _maxValue:Float;
	function get_maxValue()
	{
		return _maxValue;
	}
	function set_maxValue(value:Float)
	{
		if (_maxValue != value)
		{
			_maxValue = value;
			_size_pageValid = false;
			_view_positionValid = false;
			_value = fixedValue(_value);
			postponeSize();
		}
		return _maxValue;
	}
	
	public var pageSize(get_pageSize, set_pageSize):Float;
	var _pageSize:Float;
	function get_pageSize()
	{
		return Math.isFinite(_pageSize) ? _pageSize : _lineScrollSize;
	}
	function set_pageSize(value:Float)
	{
		if (_pageSize != value)
		{
			if (value <= 0)
			{
				throw new CArgumentError("pageSize mast be positive or NaN");
			}
			_pageSize = value;
			_size_pageValid = false;
			_view_positionValid = false;
			postponeSize();
		}
		return _pageSize;
	}
	
	public var pageScrollSize(get_pageScrollSize, set_pageScrollSize):Float;
	var _pageScrollSize:Float;
	function get_pageScrollSize()
	{
		return Math.isFinite(_pageScrollSize) ? _pageScrollSize : pageSize;
	}
	function set_pageScrollSize(value)
	{
		if (_pageScrollSize != value)
		{
			if (value <= 0)
			{
				throw new CArgumentError("pageScrollSize mast be positive or NaN");
			}
			_pageScrollSize = value;
			_size_pageValid = false;
			_view_positionValid = false;
			postponeSize();
		}
		return _pageScrollSize;
	}
	
	public var lineScrollSize(get_lineScrollSize, set_lineScrollSize):Float;
	var _lineScrollSize:Float;
	function get_lineScrollSize()
	{
		return _lineScrollSize;
	}
	function set_lineScrollSize(value)
	{
		if (!Math.isFinite(value))
		{
			throw new CArgumentError("lineScrollSize mast be finite");
		}
		if (_lineScrollSize != value)
		{
			if (value <= 0)
			{
				throw new CArgumentError("lineScrollSize mast be positive");
			}
			_lineScrollSize = value;
			_size_pageValid = false;
			_view_positionValid = false;
			postponeSize();
		}
		return _lineScrollSize;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	public function setValues(minValue:Int, maxValue:Int = CMath.INT_MAX_VALUE, value:Int = 0)
	{
		this.minValue = minValue;
		this.maxValue = maxValue;
		this.value = value;
		return this;
	}
	
	public function addChangeHandler(handler:Event->Dynamic)
	{
		addEventListener(Event.CHANGE, handler);
		return this;
	}
	
	public function addTo(parent:DisplayObjectContainer, x:Float = 0, y:Float = 0)
	{
		this.x = x;
		this.y = y;
		parent.addChild(this);
		return this;
	}
}
/*
TODO
Вынести настройку таймеров
*/