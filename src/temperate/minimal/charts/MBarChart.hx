package temperate.minimal.charts;
import temperate.core.CMath;
import temperate.text.CTextFormat;
	
class MBarChart extends AMBoundableChart
{
	var _spacing:Float;
	var _barColor:UInt;
	
	public function new(labelFormat:CTextFormat = null)
	{
		super(labelFormat);
		_spacing = 2;
		_barColor = 0xff80e015;
		_lineColor = 0x00000000;
	}
	
	override function drawChart()
	{
		super.drawChart();
		
		var g = _chartOwner.graphics;
		g.clear();
		
		while (_chartOwner.numChildren > 0)
		{
			_chartOwner.removeChildAt(0);
		}
		
		if (_values == null)
		{
			return;
		}
		
		var chartWidth = getChartWidth();
		var chartHeight = getChartHeight();
		
		var totalSpace:Float = _spacing * (_values.length + 1);
		var barWidth:Float = (chartWidth - totalSpace) / _values.length;
		_chartOwner.x = indentLeft;
		_chartOwner.y = indentTop + chartHeight;
		
		var xpos:Float = _spacing;
		var max:Float = get_maxValue();
		var min:Float = get_minValue();
		var scale:Float = chartHeight / (max - min);
		
		if (CMath.alphaPart(_lineColor) != 0)
		{
			g.lineStyle(_lineWidth, CMath.colorPart(_lineColor), CMath.alphaPart(_lineColor));
		}
		else
		{
			g.lineStyle();
		}
		for(i in 0 ... _values.length)
		{
			if(!Math.isNaN(_values[i]))
			{
				var relativeY = -_values[i] * scale;
				if (!Math.isFinite(relativeY))
				{
					continue;
				}
				var y = relativeY + min * scale;
				var color = getColorByIndex(i);
				g.beginFill(CMath.colorPart(color), CMath.alphaPart(color));
				if (min < 0 && max > 0)
				{
					g.drawRect(xpos, min * scale, barWidth, relativeY);
				}
				else if (min >= 0)
				{
					g.drawRect(xpos, 0, barWidth, y);
				}
				else
				{
					g.drawRect(xpos, -chartHeight, barWidth, y + chartHeight);
				}
				g.endFill();
				
				if (_showValueLabels)
				{
					var label = _labelFormat.newAutoSized(false, getLabelText(i));
					label.x = xpos + .5 * (barWidth - label.width);
					label.y = y - label.height;
					checkLabelPosition(label);
					_chartOwner.addChild(label);
				}
			}
			xpos += barWidth + _spacing;
		}
		
		if (min < 0 && max > 0)
		{
			g.lineStyle(0, CMath.colorPart(_borderColor), CMath.alphaPart(_borderColor));
			g.moveTo(0, min * scale);
			g.lineTo(chartWidth, min * scale);
			g.lineStyle();
		}
	}
	
	function getColorByIndex(index:UInt):UInt
	{
		var result = null;
		if (_colors != null)
		{
			result = _colors[index];
		}
		if (result == null)
		{
			result = _barColor;
		}
		return result;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Parametrization
	//
	//----------------------------------------------------------------------------------------------
	
	public var spacing(get_spacing, set_spacing):Float;
	function set_spacing(value:Float)
	{
		if (_spacing != value)
		{
			_spacing = value;
			_view_valid = false;
			postponeView();
		}
		return _spacing;
	}
	function get_spacing():Float
	{
		return _spacing;
	}
	
	public var barColor(get_barColor, set_barColor):UInt;
	function set_barColor(value:UInt)
	{
		if (_barColor != value)
		{
			_barColor = value;
			_view_valid = false;
			postponeView();
		}
		return _barColor;
	}
	function get_barColor():UInt
	{
		return _barColor;
	}
	
	public var colors(get_colors, set_colors):Array<UInt>;
	var _colors:Array<Null<UInt>>;
	function set_colors(value:Array<UInt>)
	{
		_colors = value;
		_view_valid = false;
		postponeView();
		return _colors;
	}
	function get_colors():Array<UInt>
	{
		return _colors;
	}
}