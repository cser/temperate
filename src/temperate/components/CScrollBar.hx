package temperate.components;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import temperate.components.helpers.CChangingTimerHelper;
import temperate.core.CMath;
import temperate.core.CSprite;
import temperate.skins.ICRectSkin;

class CScrollBar extends CSprite
{
	var _horizontal:Bool;
	var _leftArrow:ACButton;
	var _rightArrow:ACButton;
	var _thumb:ACButton;
	var _bg:Sprite;
	var _bgSkin:ICRectSkin;
	
	public function new(
		horizontal:Bool, leftArrow:ACButton, rightArrow:ACButton, thumb:ACButton, bgSkin:ICRectSkin
	) 
	{
		_horizontal = horizontal;
		_leftArrow = leftArrow;
		_rightArrow = rightArrow;
		_thumb = thumb;
		_bgSkin = bgSkin;
		
		super();
		
		_useHandCursor = true;
		_minValue = 0;
		_maxValue = 100;
		_value = 0;
		
		_lineScrollSize = 1;
		_pageSize = 1;
		_pageScrollSize = Math.NaN;
		
		init();
		
		_settedWidth = _horizontal ? 100 : 0;
		_settedHeight = _horizontal ? 0 : 100;
		
		_size_valid = false;
		_view_valid = false;
		postponeSize();
	}
	
	var _size_pageValid:Bool;
	var _view_positionValid:Bool;
	
	var _timerHelper:CChangingTimerHelper;
	var _pageTimerHelper:CChangingTimerHelper;
	
	function init()
	{
		_bg = new Sprite();
		addChild(_bg);
		
		_bgSkin.link(_bg.addChild, _bg.removeChild, _bg.graphics);
		addChild(_thumb);
		addChild(_leftArrow);
		addChild(_rightArrow);
		
		updateOnMove = false;
		
		_timerHelper = new CChangingTimerHelper();
		_timerHelper.onIncrease = onIncrease;
		_timerHelper.onDecrease = onDecrease;
		
		_leftArrow.addEventListener(MouseEvent.MOUSE_DOWN, onLeftMouseDown);
		_leftArrow.addEventListener(MouseEvent.MOUSE_UP, buttonStopScrollHandler);
		_leftArrow.addEventListener(MouseEvent.MOUSE_OUT, buttonStopScrollHandler);
		
		_rightArrow.addEventListener(MouseEvent.MOUSE_DOWN, onRightMouseDown);
		_rightArrow.addEventListener(MouseEvent.MOUSE_UP, buttonStopScrollHandler);
		_rightArrow.addEventListener(MouseEvent.MOUSE_OUT, buttonStopScrollHandler);
		
		_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbMouseDown);
		
		_pageTimerHelper = new CChangingTimerHelper();
		_pageTimerHelper.onIncrease = onPageIncrease;
		_pageTimerHelper.onDecrease = onPageDecrease;
		updateEnabledListeners();
	}
	
	function onIncrease()
	{
		value += _lineScrollSize;
	}
	
	function onDecrease()
	{
		value -= _lineScrollSize;
	}
	
	function onLeftMouseDown(event:MouseEvent)
	{
		_timerHelper.decreaseDown();
	}
	
	function onRightMouseDown(event:MouseEvent)
	{
		_timerHelper.increaseDown();
	}
	
	function buttonStopScrollHandler(event:MouseEvent = null)
	{
		_timerHelper.up();
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
	
	function onBgMouseDown(event:MouseEvent)
	{
		var mousePosition = _horizontal ? _bg.mouseX : _bg.mouseY;
		var thumbCenter = _horizontal ?
			_thumb.x + _thumb.width * .5 :
			_thumb.y + _thumb.height * .5;
		if (mousePosition < thumbCenter)
		{
			_pageTimerHelper.decreaseDown();
		}
		else
		{
			_pageTimerHelper.increaseDown();
		}
		stage.addEventListener(MouseEvent.MOUSE_UP, onStagePageMouseUp);
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
			_pageTimerHelper.up();
		}
		else
		{
			value += isIncrease ? pageScrollSize : -pageScrollSize;
		}
	}
	
	function onStagePageMouseUp(event:MouseEvent)
	{
		_pageTimerHelper.up();
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
		value += sign * _lineScrollSize * CMath.intMax(1, Math.round(CMath.intAbs(delta) / 3));
	}
	
	override function doValidateSize()
	{
		var needSizeValidation = !_size_valid;
		_size_valid = true;
		if (needSizeValidation)
		{
			updateSize();
			updateBaseArrange();
			_size_pageValid = false;
		}
		if (!_size_pageValid)
		{
			_size_pageValid = true;
			updateThumbSize();
		}
		if (needSizeValidation)
		{
			_view_positionValid = false;
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_positionValid)
		{
			_view_positionValid = true;
			setThumbPositionByValue();
		}
		if (!_view_valid)
		{
			_view_valid = true;
			updateBg();
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
	
	var _guideCrossOffset:Int;
	var _guideDirectOffset:Int;
	var _guideSize:Int;
	
	function updateBaseArrange()
	{
		if (_horizontal)
		{
			_leftArrow.x = 0;
			_leftArrow.y = 0;
			_rightArrow.x = _width - _rightArrow.width;
			_rightArrow.y = 0;
		}
		else
		{
			_leftArrow.x = 0;
			_leftArrow.y = 0;
			_rightArrow.x = 0;
			_rightArrow.y = _height - _rightArrow.height;
		}
		
		_guideCrossOffset = 0;
		_guideDirectOffset = Std.int(_horizontal ? _leftArrow.width : _leftArrow.height);
		_guideSize = Std.int(_horizontal ?
			_width - _leftArrow.width - _rightArrow.width :
			_height - _leftArrow.height - _rightArrow.height);
		updateThumbVisible();
	}
	
	function updateThumbVisible()
	{
		var thumbSize = _horizontal ? _thumb.width : _thumb.height;
		_thumb.visible = _enabled && thumbSize < _guideSize;
	}
	
	function setThumbPositionByValue()
	{
		var thumbSize = Std.int(_horizontal ? _thumb.width : _thumb.height);
		var thumbOffset = Std.int(_guideDirectOffset + 
			(_guideSize - thumbSize) * (_value - _minValue) / (_maxValue - _minValue));
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
		_bgSkin.setBounds(0, 0, Std.int(_width), Std.int(_height));
		_bgSkin.redraw();
	}
	
	function updateThumbSize()
	{
		var conditionalPageSize = Math.isNaN(_pageSize) || _pageSize <= 0 ? 1 : _pageSize;
		var delta = _maxValue - _minValue > 0 ? _maxValue - _minValue : 1;
		var size = _guideSize * conditionalPageSize / delta;
		if (_horizontal)
		{
			_thumb.width = Std.int(size);
		}
		else
		{
			_thumb.height = Std.int(size);
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
			_useHandCursor = value;
			_leftArrow.useHandCursor = _useHandCursor;
			_rightArrow.useHandCursor = _useHandCursor;
			_thumb.useHandCursor = _useHandCursor;
		}
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
	function set_value(value)
	{
		var newValue = fixedValue(value);
		if (_value != newValue)
		{
			_value = newValue;
			setThumbPositionByValue();
			dispatchEvent(new Event(Event.SCROLL));
		}
		return _value;
	}
	
	public var minValue(get_minValue, set_minValue):Float;
	var _minValue:Float;
	function get_minValue()
	{
		return _minValue;
	}
	function set_minValue(value)
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
	function set_maxValue(value)
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
		return _pageSize;
	}
	function set_pageSize(value)
	{
		if (_pageSize != value)
		{
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
		if (Math.isNaN(_pageScrollSize))
		{
			return _pageSize;
		}
		return _pageScrollSize;
	}
	function set_pageScrollSize(value)
	{
		if (_pageScrollSize != value)
		{
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
		if (_lineScrollSize != value)
		{
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