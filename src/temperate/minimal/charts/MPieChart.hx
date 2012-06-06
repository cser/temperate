package temperate.minimal.charts;
import flash.text.TextField;
import temperate.core.CGraphicsUtil;
import temperate.core.CMath;
import temperate.text.CTextFormat;
using temperate.core.CMath;

class MPieChart extends AMChart
{
	var _chartRotation:Float;
	
	public function new(labelFormat:CTextFormat = null)
	{
		super(labelFormat);
		
		_chartRotation = 0;
		_colors = [];
		
		_showValueLabels = true;
		_settedWidth = 150;
		_settedHeight = 150;
		
		indentLeft = 30;
		indentRight = 30;
		indentTop = 20;
		indentBottom = 20;
	}
	
	override function drawChart()
	{	
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
		
		var radius = CMath.min(chartWidth, chartHeight) * .5;
		_chartOwner.x = indentLeft + .5 * chartWidth;
		_chartOwner.y = indentTop + .5 * chartHeight;
		
		if (_lineColor.getAlpha() != 0)
		{
			g.lineStyle(_lineWidth, _lineColor.getColor(), _lineColor.getAlpha());
		}
		else
		{
			g.lineStyle();
		}
		
		var total = 0.;
		for(i in 0 ... _values.length)
		{
			if (Math.isFinite(_values[i]))
			{
				total += _values[i];
			}
		}
		
		var begin = _chartRotation * Math.PI / 180;
		for(i in 0 ... _values.length)
		{
			var percent = _values[i] / total;
			var end = begin + CMath.max(0, Math.PI * 2 * percent);
			drawSegment(begin, end, radius, getColorByIndex(i));
			if (_showValueLabels)
			{
				var label = _labelFormat.newAutoSized(false, getLabelText(i));
				var angle = (begin + end) * 0.5;
				setLabelPosition(label, angle, radius);
				checkLabelPosition(label);
				_chartOwner.addChild(label);
			}
			begin = end;
		}
	}
	
	function setLabelPosition(label:TextField, angle:Float, radius:Float)
	{
		var labelRadius = radius + 5;
		var halfW = label.width * .5;
		var halfH = label.height * .5;
		
		var rX = labelRadius + halfW;
		var rY = labelRadius + halfH;
		
		label.x = rX * Math.cos(angle) - halfW;
		label.y = rY * Math.sin(angle) - halfH;
	}
	
	function drawSegment(begin:Float, end:Float, radius:Float, color:Int)
	{
		var g = _chartOwner.graphics;
		g.beginFill(color.getColor(), color.getAlpha());
		g.moveTo(0, 0);
		g.lineTo(Math.cos(begin) * radius, Math.sin(begin) * radius);
		CGraphicsUtil.drawArc(g, 0, 0, radius, begin, end);
		g.lineTo(0, 0);
		g.endFill();
	}
	
	function getColorByIndex(index:Int):Int
	{
		if(_colors[index] != null)
		{
			return _colors[index];
		}
		
		var k = (index % 7) / 7;
		var r:Float;
		var g:Float;
		var b:Float;
		if (k < 1 / 3)
		{
			r = 1 - k * 3;
			g = k * 3;
			b = 0;
		}
		else if (k < 2 / 3)
		{
			r = 0;
			g = 1 - (k - 1 / 3) * 3;
			b = (k - 1 / 3) * 3;
		}
		else
		{
			r = (k - 2 / 3) * 3;
			g = 0;
			b = 1 - (k - 2 / 3) * 3;
		}
		r = CMath.max(0, CMath.min(1, r + (index % 3 == 0 ? -.1 : .5)));
		g = CMath.max(0, CMath.min(1, g + (index % 3 == 1 ? -.1 : .5)));
		b = CMath.max(0, CMath.min(1, b + (index % 3 == 2 ? -.1 : .5)));
		
		return ((Std.int(r * 0xff) << 16) | (Std.int(g * 0xff) << 8) | Std.int(b * 0xff))
			.applyAlpha(1);
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Parametrization
	//
	//----------------------------------------------------------------------------------------------
	
	/**
	 * Degrees that first line rotated by clockwise
	 */
	public var chartRotation(get_chartRotation, set_chartRotation):Float;
	function set_chartRotation(value:Float)
	{
		_chartRotation = value;
		_view_valid = false;
		postponeView();
		return _chartRotation;
	}
	function get_chartRotation():Float
	{
		return _chartRotation;
	}
	
	public var colors(get_colors, set_colors):Array<Int>;
	var _colors:Array<Null<Int>>;
	function set_colors(value:Array<Int>)
	{
		if (_colors != value)
		{
			_colors = value;
			_view_valid = false;
			postponeView();
		}		
		return _colors;
	}
	function get_colors():Array<Int>
	{
		return _colors;
	}
}