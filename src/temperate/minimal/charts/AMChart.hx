package temperate.minimal.charts;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;
import temperate.core.CMath;
import temperate.core.CSprite;
import temperate.text.CDefaultFormatFactory;
import temperate.text.CTextFormat;
using temperate.core.CMath;
	
class AMChart extends CSprite
{
	static var MIN_WIDTH:Int = 10;
	static var MIN_HEIGHT:Int = 10;
	
	function new(labelFormat:CTextFormat)
	{
		super();
		
		_labelFormat = labelFormat != null ?
			labelFormat :
			CDefaultFormatFactory.getDefaultFormat();
		_settedMinValue = 0;
		_settedMaxValue = 100;
		_includedValue = Math.NaN;
		_autoScale = true;
		_labelPrecision = 0;
		_lineColor = 0xff5f5f5f;
		_lineWidth = 0;
		_bgColor = 0xffffffff;
		_borderColor = 0xff808080;
		
		indentLeft = 0;
		indentRight = 0;
		indentTop = 0;
		indentBottom = 0;
		
		_bg = new Shape();
		addChild(_bg);
		
		_chartOwner = new Sprite();
		addChild(_chartOwner);
		
		_settedWidth = 180;
		_settedHeight = 100;
		_size_valid = false;
		postponeSize();
	}
	
	var _view_bgValid:Bool;
	
	var _labelFormat:CTextFormat;
	
	function getChartWidth()
	{
		return _width - indentLeft - indentRight;
	}
	
	function getChartHeight()
	{
		return _height - indentTop - indentBottom;
	}
	
	var _chartOwner:Sprite;
	var _bg:Shape;
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			_width = CMath.max(_settedWidth, MIN_WIDTH + indentLeft + indentRight);
			_height = CMath.max(_settedHeight, MIN_HEIGHT + indentTop + indentBottom);
			
			_view_bgValid = false;
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_bgValid)
		{
			_view_bgValid = true;
			
			redrawBg();
		}
		if (!_view_valid)
		{
			_view_valid = true;
			
			drawChart();
		}
	}
	
	var _minAndMaxValid:Bool;
	
	var _minValue:Float;
	var _maxValue:Float;
	
	function validateMinAndMax()
	{
		if (_minAndMaxValid)
		{
			return;
		}
		_minAndMaxValid = true;
		if (_autoScale && _values != null && _values.length > 0)
		{
			{
				var value = Math.isFinite(_values[0]) ? _values[0] : 0;
				_maxValue = value;
				_minValue = value;
			}
			if (Math.isFinite(_includedValue))
			{
				_maxValue = CMath.max(_includedValue, _maxValue);
				_minValue = CMath.min(_includedValue, _minValue);
			}
			for (i in 0 ... _values.length)
			{
				var value = Math.isFinite(_values[i]) ? _values[i] : 0;
				_maxValue = CMath.max(value, _maxValue);
				_minValue = CMath.min(value, _minValue);
			}
			if (_maxValue == _minValue)
			{
				_maxValue = _minValue + 1;
			}
		}
		else
		{
			_minValue = _settedMinValue;
			_maxValue = _settedMaxValue;
			if (Math.isFinite(_includedValue))
			{
				_maxValue = CMath.max(_includedValue, _maxValue);
				_minValue = CMath.min(_includedValue, _minValue);
			}
		}
	}
	
	function drawChart()
	{
	}
	
	function redrawBg()
	{
		var g = _bg.graphics;
		g.clear();
		g.lineStyle(0, borderColor.getColor(), _borderColor.getAlpha());
		g.beginFill(_bgColor.getColor(), _bgColor.getAlpha());
		g.drawRect(0, 0, _width, _height);
		g.endFill();
	}
	
	function checkLabelPosition(label:TextField)
	{
		var parentX = _chartOwner.x;
		var parentY = _chartOwner.y;
		if (label.x < -parentX)
		{
			label.x = -parentX;
		}
		else if (label.x > _width - parentX - label.width)
		{
			label.x = _width - parentX - label.width;
		}
		if (label.y < -parentY)
		{
			label.y = -parentY;
		}
		else if (label.y > _height - parentY - label.height)
		{
			label.y = _height - parentY - label.height;
		}
	}
	
	function getLabelText(index:Int):String
	{
		var result = null;
		if (_labels != null)
		{
			result = _labels[index];
		}
		if (result == null)
		{
			result = _values[index].toLimitDigits(_labelPrecision);
		}
		return result;
	}
	
	public function invalidate()
	{
		_minAndMaxValid = false;
		_view_valid = false;
		postponeView();
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Parametrization
	//
	//----------------------------------------------------------------------------------------------
	
	public var values(get_values, set_values):Array<Float>;
	var _values:Array<Float>;
	function set_values(value)
	{
		_values = value;
		_view_valid = false;
		_minAndMaxValid = false;
		postponeView();
		return _values;
	}
	function get_values()
	{
		return _values;
	}
	
	public var minValue(get_minValue, set_minValue):Float;
	var _settedMinValue:Float;
	function set_minValue(value:Float)
	{
		if (_settedMinValue != value)
		{
			_settedMinValue = value;
			_minAndMaxValid = false;
			_view_valid = false;
			postponeView();
		}
		return _settedMinValue;
	}
	function get_minValue():Float
	{
		if (!_minAndMaxValid)
		{
			validateMinAndMax();
		}
		return _minValue;
	}
	
	public var maxValue(get_maxValue, set_maxValue):Float;
	var _settedMaxValue:Float;
	function set_maxValue(value:Float)
	{
		if (_settedMaxValue != value)
		{
			_settedMaxValue = value;
			_minAndMaxValid = false;
			_view_valid = false;
			postponeView();
		}
		return _settedMaxValue;
	}
	function get_maxValue():Float
	{
		if (!_minAndMaxValid)
		{
			validateMinAndMax();
		}
		return _maxValue;
	}
	
	public var autoScale(get_autoScale, set_autoScale):Bool;
	var _autoScale:Bool;
	function set_autoScale(value:Bool)
	{
		if (_autoScale != value)
		{
			_autoScale = value;
			_minAndMaxValid = false;
			_view_valid = false;
			postponeView();
		}
		return _autoScale;
	}
	function get_autoScale():Bool
	{
		return _autoScale;
	}
	
	public var labelPrecision(get_labelPrecision, set_labelPrecision):Int;
	var _labelPrecision:Int;
	function get_labelPrecision()
	{
		return _labelPrecision;
	}
	function set_labelPrecision(value)
	{
		if (_labelPrecision != value)
		{
			_labelPrecision = value;
			_view_valid = false;
			postponeView();
		}
		return _labelPrecision;
	}
	
	public var labels(get_labels, set_labels):Array<String>;
	var _labels:Array<String>;
	function get_labels()
	{
		return _labels;
	}
	function set_labels(value)
	{
		if (_labels != value)
		{
			_labels = value;
			_view_valid = false;
			postponeView();
		}
		return _labels;
	}
	
	public var includedValue(get_includedValue, set_includedValue):Float;
	var _includedValue:Float;
	function get_includedValue()
	{
		return _includedValue;
	}
	function set_includedValue(value)
	{
		if (_includedValue != value)
		{
			_includedValue = value;
			_view_valid = false;
			_minAndMaxValid = false;
			postponeView();
		}
		return _includedValue;
	}
	
	public var showValueLabels(get_showValueLabels, set_showValueLabels):Bool;
	var _showValueLabels:Bool;
	function get_showValueLabels()
	{
		return _showValueLabels;
	}
	function set_showValueLabels(value)
	{
		if (_showValueLabels != value)
		{
			_showValueLabels = value;
			_view_valid = false;
			postponeView();
		}
		return _showValueLabels;
	}
	
	public var indentLeft(default, null):Int;
	public var indentRight(default, null):Int;
	public var indentTop(default, null):Int;
	public var indentBottom(default, null):Int;
	
	public function setIndents(left:Int, right:Int, top:Int, bottom:Int)
	{
		this.indentLeft = left;
		this.indentRight = right;
		this.indentTop = top;
		this.indentBottom = bottom;
		_size_valid = false;
		postponeSize();
	}
	
	public var lineColor(get_lineColor, set_lineColor):Int;
	var _lineColor:Int;
	function get_lineColor()
	{
		return _lineColor;
	}
	function set_lineColor(value)
	{
		_lineColor = value;
		_view_valid = false;
		postponeView();
		return _lineColor;
	}
	
	public var lineWidth(get_lineWidth, set_lineWidth):Float;
	var _lineWidth:Float;
	function set_lineWidth(value:Float)
	{
		_lineWidth = value;
		_view_valid = false;
		postponeView();
		return _lineWidth;
	}
	function get_lineWidth():Float
	{
		return _lineWidth;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Background parametrization
	//
	//---------------------------------------------------------------------------------------------
	
	public var bgColor(get_bgColor, set_bgColor):Int;
	var _bgColor:Int;
	function get_bgColor()
	{
		return _bgColor;
	}
	function set_bgColor(value)
	{
		if (_bgColor != value)
		{
			_bgColor = value;
			_view_bgValid = false;
			postponeView();
		}
		return _bgColor;
	}	
	
	public var borderColor(get_borderColor, set_borderColor):Int;
	var _borderColor:Int;
	function get_borderColor()
	{
		return _borderColor;
	}
	function set_borderColor(value)
	{
		if (_borderColor != value)
		{
			_borderColor = value;
			_view_valid = false;
			postponeView();
		}
		return _borderColor;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Helped
	//
	//----------------------------------------------------------------------------------------------
	
	public function setValues(values:Array<Float>, labels:Array<String> = null)
	{
		this.values = values;
		this.labels = labels;
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