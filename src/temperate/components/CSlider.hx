package temperate.components;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import temperate.core.CMath;
import temperate.core.CSprite;
import temperate.skins.ICRectSkin;

class CSlider extends CSprite, implements ICSlider
{
	var _horizontal:Bool;
	var _thumb:ACButton;
	var _bgSkin:ICRectSkin;
	
	public function new(horizontal:Bool, thumb:ACButton, bgSkin:ICRectSkin) 
	{
		_horizontal = horizontal;
		_thumb = thumb;
		_bgSkin = bgSkin;
		
		super();
		
		view = this;
		
		_minValue = 0;
		_maxValue = 100;
		_value = 0;
		
		_step = 0;
		_mouseWheelStep = 10;
		
		addChild(_thumb);
		_bgSkin.link(addChildAt0, removeChild, graphics);
		
		updateOnMove = false;
		
		updateEnabledListeners();
		
		setUseHandCursor(false);
		
		_settedWidth = _horizontal ? 100 : 0;
		_settedHeight = _horizontal ? 0 : 100;
		
		_size_valid = false;
		_view_valid = false;
		postponeSize();
	}
	
	public var view(default, null):DisplayObject;
	
	function addChildAt0(child:DisplayObject)
	{
		addChildAt(child, 0);
	}
	
	var _guideCrossOffset:Int;
	var _guideDirectOffset:Int;
	var _guideSize:Int;
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			updateSize();
			updateBaseArrange();
			
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			updateBg();
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
		if (_step > 0)
		{
			value = Math.round(value / _step) * _step;
			if (value < _minValue)
			{
				return _minValue;
			}
			if (value > _maxValue)
			{
				return _maxValue;
			}
		}
		return value;
	}
	
	function updateEnabledListeners()
	{
		if (_enabled)
		{
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbMouseDown);
		}
		else
		{
			removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, onThumbMouseDown);
		}
	}
	
	function onThumbMouseDown(event:MouseEvent)
	{
		var rect = _horizontal ? 
			new Rectangle(
				_guideDirectOffset, _guideCrossOffset, _guideSize, 0) :
			new Rectangle(
				_guideCrossOffset, _guideDirectOffset, 0, _guideSize);
		_thumb.startDrag(false, rect);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
	}
	
	function onStageMouseMove(event:MouseEvent)
	{
		if (updateOnMove)
		{
			event.updateAfterEvent();
		}
		setValueByThumbPosition();
	}
	
	function onStageMouseUp(event:MouseEvent)
	{
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		_thumb.stopDrag();
		setThumbPositionByValue();
	}
	
	function onMouseWheel(event:MouseEvent)
	{
		var delta = event.delta;
		var sign = delta > 0 ? -1 : 1;
		setValue(
			_value + sign * _mouseWheelStep * CMath.intMax(1, Math.round(CMath.intAbs(delta) / 3)),
			true);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  May be override
	//
	//----------------------------------------------------------------------------------------------
	
	function updateSize()
	{
		var thumbWidth = _thumb.width;
		var thumbHeight = _thumb.height;
		var minWidth;
		var minHeight;
		if (_horizontal)
		{
			minWidth = thumbWidth + 1;
			minHeight = thumbHeight;
		}
		else
		{
			minWidth = thumbWidth;
			minHeight = thumbHeight + 1;
		}
		if (_horizontal)
		{
			_width = _isCompactWidth ? minWidth : CMath.max(_settedWidth, minWidth);
			_height = minHeight;
		}
		else
		{
			_width = minWidth;
			_height = _isCompactHeight ? minHeight : CMath.max(_settedHeight, minHeight);
		}
	}
	
	function updateBaseArrange()
	{
		var thumbWidth = _thumb.width;
		var thumbHeight = _thumb.height;
		
		_guideCrossOffset = 0;
		_guideDirectOffset = 0;
		_guideSize = _horizontal ? Std.int(_width - thumbWidth) : Std.int(_height - thumbHeight);
	}
	
	function updateBg()
	{
		_bgSkin.setBounds(0, 0, Std.int(_width), Std.int(_height));
		_bgSkin.redraw();
	}
	
	function setUseHandCursor(value:Bool)
	{
		_useHandCursor = value;
		_thumb.useHandCursor = _useHandCursor;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Convertion between value and position
	//
	//----------------------------------------------------------------------------------------------
	
	function setThumbPositionByValue()
	{
		var delta = _maxValue - _minValue;
		var thumbOffset = _guideDirectOffset + 
			(delta > 0 ? Std.int(_guideSize * (_value - _minValue) / (_maxValue - _minValue)) : 0);
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
		var thumbOffset = Std.int(_horizontal ? _thumb.x : _thumb.y);
		var rawValue = _minValue +  (thumbOffset - _guideDirectOffset)
			* (_maxValue - _minValue) / _guideSize;
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
			_value = fixedValue(_value);
			postponeSize();
		}
		return _maxValue;
	}
	
	/**
	 * If step = 0, it's ignored
	 */
	public var step(get_step, set_step):Float;
	var _step:Float;
	function get_step()
	{
		return _step;
	}
	function set_step(value)
	{
		_step = value;
		return step;
	}
	
	public var mouseWheelStep(get_mouseWheelStep, set_mouseWheelStep):Float;
	var _mouseWheelStep:Float;
	function get_mouseWheelStep()
	{
		return _mouseWheelStep;
	}
	function set_mouseWheelStep(value:Float)
	{
		_mouseWheelStep = value;
		return _mouseWheelStep;
	}
	
	override function set_enabled(value)
	{
		if (_enabled != value)
		{
			_enabled = value;
			_thumb.enabled = _enabled;
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
- перемещение мышью
- выставление положения движка при изменении значения
- значение должно быть кратным шагу
- при любом шаге должно высталвяться минимальное и максимальное значение
- изменение значения колесом мыши
- реализовать disabled состояние
- отправка события только при действиях пользователя
- реализовтаь useHandCursor поле
- если шаг нулевой или неконечный - он не учитывается
*/