package temperate.components;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.ui.Keyboard;
import temperate.components.helpers.CSmoothTimerChanger;
import temperate.components.helpers.ICTimerChanger;
import temperate.core.CMath;
import temperate.core.CMouseWheelUtil;
import temperate.core.CSprite;
import temperate.skins.CSkinState;
import temperate.skins.ICRectSkin;
import temperate.text.CDefaultFormatFactory;
import temperate.text.CTextFormat;

class CNumericStepper extends CSprite
{
	public function new(up:ICButton, down:ICButton, bg:ICRectSkin)
	{
		super();
		
		_step = 1;
		_editable = true;
		
		_minValue = 0;
		_maxValue = 100;
		_value = 0;
		_mouseWheelDimRatio = 1;
		
		valueTranslator = Std.string;
		valueParser = Std.parseInt;
		valueIsCorrect = isCorrectInt;
		
		_bg = bg;
		_bg.link(addChaldAt0, removeChild, graphics);
		
		_up = up;
		_up.addEventListener(MouseEvent.MOUSE_DOWN, onUpMouseDown);
		_up.addEventListener(MouseEvent.MOUSE_UP, buttonStopTimerHandler);
		_up.addEventListener(MouseEvent.MOUSE_OUT, buttonStopTimerHandler);
		addChild(_up.view);
		
		_down = down;
		_down.addEventListener(MouseEvent.MOUSE_DOWN, onDownMouseDown);
		_down.addEventListener(MouseEvent.MOUSE_UP, buttonStopTimerHandler);
		_down.addEventListener(MouseEvent.MOUSE_OUT, buttonStopTimerHandler);
		addChild(_down.view);
		
		_tf = new TextField();
		_tf.text = valueTranslator(_value);
		_tf.addEventListener(Event.CHANGE, onTfChange, false, CMath.INT_MAX_VALUE);
		addChild(_tf);
		
		_format = CDefaultFormatFactory.getDefaultFormat();
		
		_measuringTf = new TextField();
		_measuringTf.autoSize = TextFieldAutoSize.LEFT;
		_measuringTf.text = " ";
		
		updateTextType();
		updateControlsEnabled();
		updateEnabled();
		
		setUseHandCursor(false);
		
		_settedWidth = 80;
		_size_valid = false;
		postponeSize();
	}
	
	var _size_tfMinSizeValid:Bool;
	
	var _view_formatValid:Bool;
	
	function addChaldAt0(child:DisplayObject)
	{
		addChildAt(child, 0);
	}
	
	function isCorrectInt(text:String):Bool
	{
		return ~/^\-?\d*$/.match(text);
	}
	
	var _up:ICButton;
	var _down:ICButton;
	var _bg:ICRectSkin;
	var _tf:TextField;
	
	var _tfMinWidth:Int;
	var _tfMinHeight:Int;
	
	//----------------------------------------------------------------------------------------------
	//
	//  Parametrization
	//
	//----------------------------------------------------------------------------------------------
	
	public var timerChanger(get_timerChanger, set_timerChanger):ICTimerChanger;
	var _timerChanger:ICTimerChanger;
	function get_timerChanger()
	{
		if (_timerChanger == null)
		{
			set_timerChanger(new CSmoothTimerChanger());
		}
		return _timerChanger;
	}
	function set_timerChanger(value:ICTimerChanger)
	{
		if (_timerChanger != value)
		{
			if (_timerChanger != null)
			{
				_timerChanger.up();
				_timerChanger.onIncrease = null;
				_timerChanger.onDecrease = null;
			}
			_timerChanger = value;
			if (_timerChanger != null)
			{
				_timerChanger.onIncrease = onIncrease;
				_timerChanger.onDecrease = onDecrease;
			}
		}
		return _timerChanger;
	}
	
	public var valueTranslator(default, null):Int->String;
	public var valueParser(default, null):String->Int;
	public var valueIsCorrect(default, null):String->Bool;
	
	public function setValueTranslators(
		translator:Int->String, parser:String->Int, isCorrect:String->Bool
	)
	{
		valueTranslator = translator;
		valueParser = parser;
		valueIsCorrect = isCorrect;
		
		_tf.text = valueTranslator(_value);
		
		_size_tfMinSizeValid = false;
		_size_valid = false;
		postponeSize();
	}
	
	public var step(get_step, set_step):Int;
	var _step:Int;
	function get_step()
	{
		return _step;
	}
	function set_step(value)
	{
		_step = value;
		return _step;
	}
		
	public var value(get_value, set_value):Int;
	var _value:Int;
	function set_value(value)
	{
		var newValue = correctedValue(value);
		if (_value != newValue)
		{
			_value = newValue;
			
			_view_formatValid = false;
			postponeView();
			
			_tf.text = valueTranslator(_value);
			updateControlsEnabled();
			dispatchChange();
		}
		return _value;
	}
	function get_value()
	{
		return _value;
	}
	
	public var minValue(get_minValue, set_minValue):Int;
	var _minValue:Int;
	function get_minValue()
	{
		return _minValue;
	}
	function set_minValue(value)
	{
		if (value != _minValue)
		{
			_minValue = value;
			
			_size_tfMinSizeValid = false;
			_size_valid = false;
			postponeSize();
			
			updateValueConstraints();
		}
		return _minValue;
	}
	
	public var maxValue(get_maxValue, set_maxValue):Int;
	var _maxValue:Int;
	function get_maxValue()
	{
		return _maxValue;
	}
	public function set_maxValue(value)
	{
		if (value != _maxValue)
		{
			_maxValue = value;
			
			_size_tfMinSizeValid = false;
			_size_valid = false;
			postponeSize();
			
			updateValueConstraints();
		}
		return _maxValue;
	}
	
	function updateValueConstraints()
	{
		var newValue = correctedValue(_value);
		if (_value != newValue)
		{
			_value = newValue;
			
			_view_formatValid = false;
			postponeView();
			
			_tf.text = valueTranslator(value);
			dispatchChange();
		}
		updateControlsEnabled();
	}
	
	override function set_isEnabled(value)
	{
		if (_isEnabled != value)
		{
			_isEnabled = value;
			updateTextType();
			updateControlsEnabled();
			updateEnabled();
			
			_view_formatValid = false;
			postponeView();
		}
		return _isEnabled;
	}
	
	function updateEnabled()
	{
		if (_isEnabled)
		{
			_tf.addEventListener(FocusEvent.FOCUS_IN, onTfFocusIn);
			_tf.addEventListener(FocusEvent.FOCUS_OUT, onTfFocusOut);
			_tf.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_up.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_down.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		else
		{
			_tf.removeEventListener(FocusEvent.FOCUS_IN, onTfFocusIn);
			_tf.removeEventListener(FocusEvent.FOCUS_OUT, onTfFocusOut);
			_tf.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_up.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_down.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
	}
	
	public var editable(get_editable, set_editable):Bool;
	var _editable:Bool;
	function set_editable(value)
	{
		if (value != _editable)
		{
			_editable = value;
			updateTextType();
			updateControlsEnabled();
		}
		return _editable;
	}
	function get_editable()
	{
		return _editable;
	}
	
	public var selectable(get_selectable, set_selectable):Bool;
	function get_selectable()
	{
		return _tf.selectable;
	}
	function set_selectable(value)
	{
		_tf.selectable = value;
		return value;
	}
	
	public var format(get_format, set_format):CTextFormat;
	var _format:CTextFormat;
	function get_format()
	{
		return _format;
	}
	function set_format(value)
	{
		if (value != _format)
		{
			_format = value;
			
			_size_valid = false;
			postponeSize();
			_view_formatValid = false;
			postponeView();
		}
		return _format;
	}
	
	public var formatError(get_formatError, set_formatError):CTextFormat;
	var _formatError:CTextFormat;
	function get_formatError()
	{
		return _formatError;
	}
	function set_formatError(value)
	{
		if (value != _formatError)
		{
			_formatError = value;
			
			_view_formatValid = false;
			postponeView();
		}
		return _formatError;
	}
	
	public var formatDisabled(get_formatDisabled, set_formatDisabled):CTextFormat;
	var _formatDisabled:CTextFormat;
	function get_formatDisabled()
	{
		return _formatDisabled;
	}
	function set_formatDisabled(value)
	{
		if (value != _formatDisabled)
		{
			_formatDisabled = value;
			
			_view_formatValid = false;
			postponeView();
		}
		return _formatDisabled;
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
		_up.setUseHandCursor(_useHandCursor);
		_down.setUseHandCursor(_useHandCursor);
	}
	
	public var mouseWheelDimRatio(get_mouseWheelDimRatio, set_mouseWheelDimRatio):Int;
	var _mouseWheelDimRatio:Int;
	function get_mouseWheelDimRatio()
	{
		return _mouseWheelDimRatio;
	}
	function set_mouseWheelDimRatio(value:Int)
	{
		_mouseWheelDimRatio = value;
		return _mouseWheelDimRatio;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Changing
	//
	//----------------------------------------------------------------------------------------------
	
	function updateTextType()
	{
		_tf.type = _isEnabled && _editable && _maxValue > _minValue ?
			_tf.type = TextFieldType.INPUT :
			_tf.type = TextFieldType.DYNAMIC;
	}
	
	function updateControlsEnabled()
	{
		_up.isEnabled = _value < _maxValue && _isEnabled;
		_down.isEnabled = _value > _minValue && _isEnabled;
		if (_isEnabled)
		{
			_bg.state = _editable ? CSkinState.NORMAL : CSkinState.INACTIVE;
		}
		else
		{
			_bg.state = CSkinState.DISABLED;
		}
	}
	
	function correctedValue(value:Int)
	{
		return CMath.intMax(CMath.intMin(value, _maxValue), _minValue);
	}
	
	function dispatchChange()
	{
		dispatchEvent(new Event(Event.CHANGE));
	}
	
	function isTextValueInBounds(text:String):Bool
	{
		var textValue = valueParser(text);
		return textValue <= _maxValue && textValue >= _minValue;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Handlers
	//
	//----------------------------------------------------------------------------------------------
	
	function onTfChange(event:Event)
	{
		event.stopImmediatePropagation();
		event.stopPropagation();
		
		var text = _tf.text;
		if (valueIsCorrect(text) && isTextValueInBounds(text)) 
		{
			setValueWithDispatching(valueParser(text));
		}
		_tf.scrollH = 0;
		
		_view_formatValid = false;
		postponeView();
	}
	
	function setValueWithDispatching(newValue:Int)
	{
		newValue = correctedValue(newValue);
		if (_value != newValue)
		{
			_value = newValue;
			
			_view_formatValid = false;
			postponeView();
			
			updateControlsEnabled();
			dispatchChange();
		}
	}
	
	function onTfFocusIn(event:FocusEvent)
	{
		_tf.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		_tf.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	function onTfFocusOut(event:FocusEvent)
	{
		_tf.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		_tf.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		
		correctTextByValue();
	}
	
	function correctTextByValue()
	{
		var text = _tf.text;
		if (valueIsCorrect(text))
		{
			setValueWithDispatching(valueParser(text));
		}
		else
		{
			_value = correctedValue(_value);
		}
		_tf.text = valueTranslator(_value);
		
		_view_formatValid = false;
		postponeView();
	}
	
	function onMouseWheel(event:MouseEvent)
	{
		value -= _step * CMouseWheelUtil.getDimDelta(event.delta, _mouseWheelDimRatio); 
	}
	
	function onKeyDown(event:KeyboardEvent)
	{
		switch (event.keyCode)
		{
			case Keyboard.UP:
				doUpMouseDown();
			case Keyboard.DOWN:
				doDownMouseDown();
			case Keyboard.ENTER:
				correctTextByValue();
		}
	}
	
	function onKeyUp(event:KeyboardEvent)
	{
		switch (event.keyCode)
		{
			case Keyboard.UP, Keyboard.DOWN:
				buttonStopTimerHandler();
		}
	}
	
	function onUpMouseDown(event:MouseEvent)
	{
		stage.focus = _tf;
		doUpMouseDown();
	}
	
	function onDownMouseDown(event:MouseEvent)
	{
		stage.focus = _tf;
		doDownMouseDown();
	}
	
	function doUpMouseDown()
	{
		timerChanger.increaseDown(false);
	}
	
	function doDownMouseDown()
	{
		timerChanger.decreaseDown(false);
	}
	
	function onIncrease()
	{
		value += _step;
	}
	
	function onDecrease()
	{
		value -= _step;
	}
	
	function buttonStopTimerHandler(event:MouseEvent = null)
	{
		timerChanger.up();
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  For override
	//
	//----------------------------------------------------------------------------------------------
	
	var _measuringTf:TextField;
	
	override function doValidateSize()
	{
		if (!_size_tfMinSizeValid)
		{
			_size_tfMinSizeValid = true;
			
			CTextFormat.setNullFormat(_measuringTf);
			_format.applyTo(_measuringTf);
			
			_measuringTf.text = valueTranslator(_minValue);
			_tfMinWidth = Std.int(_measuringTf.width);
			_tfMinHeight = Std.int(_measuringTf.height);
			_measuringTf.text = valueTranslator(_maxValue);
			_tfMinWidth = CMath.intMax(_tfMinWidth, Std.int(_measuringTf.width));
			_tfMinHeight = CMath.intMax(_tfMinHeight, Std.int(_measuringTf.height));
		}
		if (!_size_valid)
		{
			_size_valid = true;
			
			updateSize();
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_formatValid)
		{
			_view_formatValid = true;
			
			updateFormat();
		}
		if (!_view_valid)
		{
			_view_valid = true;
			
			updateArrange();
			_bg.redraw();
		}
	}
	
	static var TEXT_INDENT = 2;
	
	function updateSize()
	{
		var minWidth = _tfMinWidth + Math.max(_up.view.width, _down.view.width) + TEXT_INDENT * 2;
		_height = _tfMinHeight + TEXT_INDENT * 2;
		if (_isCompactWidth)
		{
			_width = minWidth;
		}
		else
		{
			_width = CMath.max(minWidth, _settedWidth);
		}
	}
	
	function updateArrange()
	{
		var centerY:Int = Std.int(_height * .5);
		
		_tf.height = _tfMinHeight + 2;
		_tf.width = _width - Math.max(_up.view.width, _down.view.width) - TEXT_INDENT;
		_tf.x = TEXT_INDENT;
		_tf.y = centerY - (_tfMinHeight >> 1);
		
		_up.view.x = _width - _up.view.width;
		_up.view.y = centerY - _up.view.height;
		
		_down.view.x = _width - _down.view.width;
		_down.view.y = centerY;
		
		_bg.setBounds(0, 0, Std.int(_tf.width) + TEXT_INDENT, Std.int(_height));
	}
	
	var _currentFormat:CTextFormat;
	
	function updateFormat()
	{
		var newFormat = null;
		if (_isEnabled)
		{
			var text = _tf.text;
			if (valueIsCorrect(text) && isTextValueInBounds(text))
			{
				newFormat = _format;
			}
			else
			{
				newFormat = _formatError;
			}
		}
		else
		{
			newFormat = _formatDisabled;
		}
		if (newFormat == null)
		{
			newFormat = _format;
		}
		if (newFormat != _currentFormat)
		{
			_currentFormat = newFormat;
			
			CTextFormat.setNullFormat(_tf);
			newFormat.applyTo(_tf);
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