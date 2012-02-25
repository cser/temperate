package temperate.minimal.charts;
import flash.text.TextField;
import temperate.text.CTextFormat;
using temperate.core.CMath;

class AMBoundableChart extends AMChart
{
	function new(labelFormat:CTextFormat) 
	{
		super(labelFormat);
		
		_showBoundLabels = false;
		_showInnerBorder = true;
	}
	
	var _maxLabel:TextField;
	var _minLabel:TextField;
	
	override function drawChart()
	{
		super.drawChart();
		
		if (_maxLabel != null)
		{
			_maxLabel.text = maxValue.toLimitDigits(_labelPrecision);
			var x = indentLeft - _maxLabel.width;
			if (x < 0)
			{
				x = 0;
			}
			var y = indentTop - .5 * _maxLabel.height;
			if (y < 0)
			{
				y = 0;
			}
			_maxLabel.x = x;
			_maxLabel.y = y;
		}
		
		if (_minLabel != null)
		{
			_minLabel.text = minValue.toLimitDigits(_labelPrecision);
			var x = indentLeft - _minLabel.width;
			if (x < 0)
			{
				x = 0;
			}
			var y = _height - indentBottom - .5 * _minLabel.height;
			if (y > _height - _minLabel.height)
			{
				y = _height - _minLabel.height;
			}
			_minLabel.x = x;
			_minLabel.y = y;
		}
	}
	
	override function redrawBg()
	{
		super.redrawBg();
		if (_showInnerBorder &&
			(indentLeft != 0 || indentRight != 0 || indentTop != 0 || indentBottom != 0))
		{
			var chartWidth = getChartWidth();
			var chartHeight = getChartHeight();
			
			var g = _bg.graphics;
			g.lineStyle(0, _borderColor.getColor(), _borderColor.getAlpha());
			g.drawRect(indentLeft, indentTop, chartWidth, chartHeight);
		}
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Parametrization
	//
	//----------------------------------------------------------------------------------------------
	
	public var showBoundLabels(get_showBoundLabels, set_showBoundLabels):Bool;
	var _showBoundLabels:Bool;
	function set_showBoundLabels(value:Bool)
	{
		if (_showBoundLabels != value)
		{
			_showBoundLabels = value;
			
			if (_showBoundLabels)
			{
				if (_maxLabel == null)
				{
					_maxLabel = _labelFormat.newAutoSized(false);
				}
				if (_minLabel == null)
				{
					_minLabel = _labelFormat.newAutoSized(false);
				}
				addChild(_maxLabel);
				addChild(_minLabel);
			}
			else
			{
				removeChild(_maxLabel);
				removeChild(_minLabel);
			}
		}
		return _showBoundLabels;
	}
	function get_showBoundLabels():Bool
	{
		return _showBoundLabels;
	}
	
	public var showInnerBorder(get_showInnerBorder, set_showInnerBorder):Bool;
	var _showInnerBorder:Bool;
	function get_showInnerBorder()
	{
		return _showInnerBorder;
	}
	function set_showInnerBorder(value)
	{
		if (_showInnerBorder != value)
		{
			_showInnerBorder = value;
			_view_bgValid = false;
			postponeView();
		}
		return _showInnerBorder;
	}
}