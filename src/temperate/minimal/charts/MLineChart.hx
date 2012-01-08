package temperate.minimal.charts;
import temperate.text.CTextFormat;
using temperate.core.CMath;

class MLineChart extends AMBoundableChart
{	
	public function new(labelFormat:CTextFormat = null)
	{
		super(labelFormat);
		
		_lineWidth = 1;
		_lineColor = 0xff60a020;
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
		
		var lineWidth:Float = chartWidth / (_values.length - 1);
		var chartHeight:Float = chartHeight;
		_chartOwner.x = indentLeft;
		_chartOwner.y = indentTop + chartHeight;
		
		var xpos:Float = 0;
		var max:Float = get_maxValue();
		var min:Float = get_minValue();
		var scale:Float = chartHeight / (max - min);
		
		g.lineStyle(_lineWidth, _lineColor.getColor(), _lineColor.getAlpha());
		
		for(i in 0 ... _values.length)
		{
			if (!Math.isNaN(_values[i]))
			{
				var y = (_values[i] - min) * -scale;
				
				if (i == 0)
				{
					g.moveTo(xpos, y);
				}
				else
				{
					g.lineTo(xpos, y);
				}
				
				if (_showValueLabels)
				{
					var label = _labelFormat.newAutoSized(false, getLabelText(i));
					label.x = xpos - .5 * label.width;
					label.y = y - label.height;
					checkLabelPosition(label);
					_chartOwner.addChild(label);
				}
			}
			xpos += lineWidth;
		}
		
		if (min < 0)
		{
			g.lineStyle(0, _borderColor.getColor(), _borderColor.getAlpha());
			g.moveTo(0, min * scale);
			g.lineTo(chartWidth, min * scale);
			g.lineStyle();
		}
	}
}