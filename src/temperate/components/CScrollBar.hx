package temperate.components;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.components.helpers.CTimerChanger;
import temperate.components.helpers.ICTimerChanger;
import temperate.core.CMath;
import temperate.core.CMouseWheelUtil;
import temperate.core.CSprite;
import temperate.errors.CArgumentError;
import temperate.skins.ICScrollSkin;

/**
 * Events:
 * flash.events.Event.CHANGE
 */
class CScrollBar extends CSprite, implements ICSlider
{
	var _horizontal:Bool;
	var _leftArrow:ICButton;
	var _rightArrow:ICButton;
	var _thumb:ICButton;
	var _bgSkin:ICScrollSkin;
	var _isThumbResizable:Bool;
	
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
		horizontal:Bool, leftArrow:ICButton, rightArrow:ICButton, thumb:ICButton,
		bgSkin:ICScrollSkin, isThumbResizable:Bool = true) 
	{
		_horizontal = horizontal;
		_leftArrow = leftArrow;
		_rightArrow = rightArrow;
		_thumb = thumb;
		_bgSkin = bgSkin;
		_isThumbResizable = isThumbResizable;
		
		super();
		
		view = this;
		
		_minValue = 0;
		_maxValue = 100;
		_value = 0;
		
		_step = 1;
		_pageSize = Math.NaN;
		_pageStep = Math.NaN;
		
		updateOnMove = false;
		mouseWheelDimRatio = 1;
		
		_isBgDown = false;
		_isBgDownLeft = false;
		
		_bg = new Sprite();
		addChild(_bg);
		
		_bgSkin.link(_horizontal, _bg.addChild, _bg.removeChild, _bg.graphics);
		addChild(_thumb.view);
		addChild(_leftArrow.view);
		addChild(_rightArrow.view);
		
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
	
	public var view(default, null):DisplayObject;
	
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
		setValue(_value + _step, true);
	}
	
	function onDecrease()
	{
		setValue(_value - _step, true);
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
		if (_isEnabled)
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
			thumbPosition = _thumb.view.x;
			thumbSize = _thumb.view.width;
		}
		else
		{
			mousePosition = _bg.mouseY;
			thumbPosition = _thumb.view.y;
			thumbSize = _thumb.view.height;
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
			setValue(_value + (isIncrease ? pageStep : -pageStep), true);
			redrawBg();
		}
	}
	
	function getMousePosition()
	{
		return _horizontal ? _bg.mouseX : _bg.mouseY;
	}
	
	function getThumbCenter()
	{
		var thumbView = _thumb.view;
		return Std.int(
			_horizontal ?
				thumbView.x + thumbView.width * .5 :
				thumbView.y + thumbView.height * .5);
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
	
	var _mouseOffsetX:Float;
	var _mouseOffsetY:Float;
	
	function onThumbMouseDown(event:MouseEvent)
	{
		_mouseOffsetX = _thumb.view.mouseX;
		_mouseOffsetY = _thumb.view.mouseY;
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
	}
	
	function onStageMouseUp(event:MouseEvent)
	{
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		setThumbPositionByValue();
	}
	
	function onStageMouseMove(event:MouseEvent)
	{
		var thumbView = _thumb.view;
		var value = Std.int(_horizontal ? mouseX - _mouseOffsetX : mouseY - _mouseOffsetY);
		if (value < _guideDirectOffset)
		{
			value = _guideDirectOffset;
		}
		else
		{
			var maxValue = _guideDirectOffset + _guideSize -
				Std.int(_horizontal ? thumbView.width : thumbView.height);
			if (value > maxValue)
			{
				value = maxValue;
			}
		}
		if (_horizontal)
		{
			thumbView.x = value;
		}
		else
		{
			thumbView.y = value;
		}
		if (updateOnMove)
		{
			event.updateAfterEvent();
		}
		setValueByThumbPosition();
	}
	
	function onMouseWheel(event:MouseEvent)
	{
		setValue(
			_value - _step * CMouseWheelUtil.getDimDelta(event.delta, mouseWheelDimRatio), true);
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
		var leftWidth = _leftArrow.view.width;
		var leftHeight = _leftArrow.view.height;
		var rightWidth = _rightArrow.view.width;
		var rightHeight = _rightArrow.view.height;
		var minWidth;
		var minHeight;
		if (_horizontal)
		{
			minWidth = leftWidth + rightWidth;
			minHeight = CMath.max3(leftHeight, rightHeight, _thumb.view.height);
		}
		else
		{
			minWidth = CMath.max3(leftWidth, rightWidth, _thumb.view.width);
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
		_leftArrow.view.x = 0;
		_leftArrow.view.y = 0;
		_guideCrossOffset = 0;
		
		if (_horizontal)
		{
			_rightArrow.view.x = _width - _rightArrow.view.width;
			_rightArrow.view.y = 0;
			
			_guideDirectOffset = Std.int(_leftArrow.view.width);
			_guideSize = Std.int(_width - _leftArrow.view.width - _rightArrow.view.width);
		}
		else
		{
			_rightArrow.view.x = 0;
			_rightArrow.view.y = _height - _rightArrow.view.height;
			
			_guideDirectOffset = Std.int(_leftArrow.view.height);
			_guideSize = Std.int(_height - _leftArrow.view.height - _rightArrow.view.height);
		}
	}
	
	function updateThumbVisible()
	{
		var thumbSize = _horizontal ? _thumb.view.width : _thumb.view.height;
		_thumb.view.visible = _isEnabled && thumbSize < _guideSize && _maxValue > _minValue;
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
		if (_isThumbResizable)
		{
			if (_horizontal)
			{
				_thumb.view.width = size;
			}
			else
			{
				_thumb.view.height = size;
			}
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
		value = Math.round(value / _step) * _step;
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
	
	override function set_isEnabled(value)
	{
		if (_isEnabled != value)
		{
			_isEnabled = value;
			_leftArrow.isEnabled = _isEnabled;
			_rightArrow.isEnabled = _isEnabled;
			updateThumbVisible();
			updateEnabledListeners();
		}
		return _isEnabled;
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
		_leftArrow.setUseHandCursor(_useHandCursor);
		_rightArrow.setUseHandCursor(_useHandCursor);
		_thumb.setUseHandCursor(_useHandCursor);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Convertion between value and position
	//
	//----------------------------------------------------------------------------------------------
	
	function setThumbPositionByValue()
	{
		var thumbSize = Std.int(_horizontal ? _thumb.view.width : _thumb.view.height);
		var delta = _maxValue - _minValue;
		var thumbOffset = _guideDirectOffset + 
			(delta > 0 ?
				Std.int((_guideSize - thumbSize) * (_value - _minValue) / (_maxValue - _minValue)) :
				0);
		if (_horizontal)
		{
			_thumb.view.x = thumbOffset;
			_thumb.view.y = _guideCrossOffset;
		}
		else
		{
			_thumb.view.x = _guideCrossOffset;
			_thumb.view.y = thumbOffset;
		}
	}
	
	function setValueByThumbPosition()
	{
		var thumbSize = Std.int(_horizontal ? _thumb.view.width : _thumb.view.height);
		var thumbOffset = Std.int(_horizontal ? _thumb.view.x : _thumb.view.y);
		var rawValue = _minValue +  (thumbOffset - _guideDirectOffset)
			* (_maxValue - _minValue) / (_guideSize - thumbSize);
		var newValue = fixedValue(rawValue);
		if (_value != newValue)
		{
			_value = newValue;
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Parameters
	//
	//----------------------------------------------------------------------------------------------
	
	public var updateOnMove:Bool;
	
	public var mouseWheelDimRatio:Int;
	
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
				dispatchEvent(new Event(Event.CHANGE));
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
		return Math.isFinite(_pageSize) ? _pageSize : _step;
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
	
	public var pageStep(get_pageStep, set_pageStep):Float;
	var _pageStep:Float;
	function get_pageStep()
	{
		return Math.isFinite(_pageStep) ? _pageStep : pageSize;
	}
	function set_pageStep(value)
	{
		if (_pageStep != value)
		{
			if (value <= 0)
			{
				throw new CArgumentError("pageScrollSize mast be positive or NaN");
			}
			_pageStep = value;
			_size_pageValid = false;
			_view_positionValid = false;
			postponeSize();
		}
		return _pageStep;
	}
	
	public var step(get_step, set_step):Float;
	var _step:Float;
	function get_step()
	{
		return _step;
	}
	function set_step(value)
	{
		if (!Math.isFinite(value))
		{
			throw new CArgumentError("step mast be finite");
		}
		if (_step != value)
		{
			if (value <= 0)
			{
				throw new CArgumentError("step mast be positive");
			}
			_step = value;
			_size_pageValid = false;
			_view_positionValid = false;
			postponeSize();
		}
		return _step;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	public function setValues(minValue:Float, maxValue:Float, value:Float = 0)
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