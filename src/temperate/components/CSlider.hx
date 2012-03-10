package temperate.components;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.core.CMath;
import temperate.core.CMouseWheelUtil;
import temperate.core.CSprite;
import temperate.skins.CSkinState;
import temperate.skins.ICRectSkin;

/**
 * Events:
 * flash.events.Event.CHANGE
 * flash.events.Event.COMPLETE
 */
class CSlider extends CSprite, implements ICSlider
{
	var _horizontal:Bool;
	var _thumb:ICButton;
	var _bgSkin:ICRectSkin;
	var _bg:Sprite;
	var _bgShape:Shape;
	
	public function new(horizontal:Bool, thumb:ICButton, bgSkin:ICRectSkin) 
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
		_mouseWheelStep = 1;
		
		_bg = new Sprite();
		addChild(_bg);
		
		_bgShape = new Shape();
		_bg.addChild(_bgShape);
		
		addChild(_thumb.view);
		_bgSkin.link(addChildToBg, _bg.removeChild, _bg.graphics);
		
		updateOnMove = false;
		mouseWheelDimRatio = 1;
		
		updateEnabled();
		
		setUseHandCursor(false);
		
		_settedWidth = _horizontal ? 100 : 0;
		_settedHeight = _horizontal ? 0 : 100;
		
		_size_valid = false;
		_view_valid = false;
		postponeSize();
	}
	
	public var view(default, null):DisplayObject;
	
	function addChildToBg(child:DisplayObject)
	{
		_bg.addChildAt(child, 0);
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
			
			_thumb.validate();
			
			updateBg();
			setThumbPositionByValue();
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
		if (Math.isFinite(_step) && _step > 0)
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
	
	function updateEnabled()
	{
		if (_isEnabled)
		{
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_bg.addEventListener(MouseEvent.MOUSE_DOWN, onBgMouseDown);
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbMouseDown);
		}
		else
		{
			removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_bg.removeEventListener(MouseEvent.MOUSE_DOWN, onBgMouseDown);
			_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, onThumbMouseDown);
		}
		_view_valid = false;
		_bgSkin.state = _isEnabled ? CSkinState.NORMAL : CSkinState.DISABLED;
	}
	
	function onBgMouseDown(event:MouseEvent)
	{
		var thumbOffset = Std.int(
			_horizontal ? mouseX - _thumb.view.width * .5 : mouseY - _thumb.view.height * .5);
		var newValue = getValueByPosition(thumbOffset);
		if (_value != newValue)
		{
			_value = newValue;
			setThumbPositionByValue();
			dispatchEvent(new Event(Event.CHANGE));
			dispatchEvent(new Event(Event.COMPLETE));
		}
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
	
	function onStageMouseMove(event:MouseEvent)
	{
		var value = Std.int(_horizontal ? mouseX - _mouseOffsetX : mouseY - _mouseOffsetY);
		if (value < _guideDirectOffset)
		{
			value = _guideDirectOffset;
		}
		else
		{
			var maxValue = _guideDirectOffset + _guideSize;
			if (value > maxValue)
			{
				value = maxValue;
			}
		}
		if (_horizontal)
		{
			_thumb.view.x = value;
		}
		else
		{
			_thumb.view.y = value;
		}
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
		setThumbPositionByValue();
		dispatchEvent(new Event(Event.COMPLETE));
	}
	
	function onMouseWheel(event:MouseEvent)
	{
		var delta = event.delta;
		var sign = delta > 0 ? -1 : 1;
		setValue(
			_value -
			_mouseWheelStep * CMouseWheelUtil.getFixedDimDelta(event.delta, mouseWheelDimRatio),
			true);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  May be override
	//
	//----------------------------------------------------------------------------------------------
	
	function updateSize()
	{
		var thumbWidth = _thumb.view.width;
		var thumbHeight = _thumb.view.height;
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
		var thumbWidth = _thumb.view.width;
		var thumbHeight = _thumb.view.height;
		
		_guideCrossOffset = 0;
		_guideDirectOffset = 0;
		_guideSize = _horizontal ? Std.int(_width - thumbWidth) : Std.int(_height - thumbHeight);
	}
	
	function updateBg()
	{
		var g = _bgShape.graphics;
		g.clear();
		g.beginFill(0x000000, 0);
		g.drawRect(0, 0, _width, _height);
		g.endFill();
		
		var fixedWidth = _bgSkin.getFixedWidth();
		var fixedHeight = _bgSkin.getFixedHeight();
		var lineWidth = Math.isNaN(fixedWidth) ? _width : fixedWidth;
		var lineHeight = Math.isNaN(fixedHeight) ? _height : fixedHeight;
		_bgSkin.setBounds(
			Std.int(_width - lineWidth) >> 1,
			Std.int(_height - lineHeight) >> 1,
			Std.int(lineWidth),
			Std.int(lineHeight));
		_bgSkin.redraw();
	}
	
	function setUseHandCursor(value:Bool)
	{
		_useHandCursor = value;
		_thumb.setUseHandCursor(_useHandCursor);
		_bg.useHandCursor = _useHandCursor;
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
		var thumbOffset = Std.int(_horizontal ? _thumb.view.x : _thumb.view.y);
		var newValue = getValueByPosition(thumbOffset);
		if (_value != newValue)
		{
			_value = newValue;
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
	
	function getValueByPosition(thumbOffset:Int)
	{
		var rawValue = _minValue +  (thumbOffset - _guideDirectOffset)
			* (_maxValue - _minValue) / _guideSize;
		return fixedValue(rawValue);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Params
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
	
	override function set_isEnabled(value)
	{
		if (_isEnabled != value)
		{
			_isEnabled = value;
			_thumb.isEnabled = _isEnabled;
			updateEnabled();
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