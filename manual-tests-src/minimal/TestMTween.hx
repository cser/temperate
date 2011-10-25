package minimal;
import flash.display.Shape;
import flash.display.Sprite;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.charts.MLineChart;
import temperate.minimal.easing.MBack;
import temperate.minimal.easing.MBounce;
import temperate.minimal.easing.MEaseMethod;
import temperate.minimal.easing.MExpo;
import temperate.minimal.easing.MPower;
import temperate.minimal.MLabel;
import temperate.minimal.MTween;

class TestMTween extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		{
			var shape = newShape();
			addChild(shape);
			
			shape.alpha = .5;
			MTween.to(shape, 1000, { x:10, y:20, alpha: 1 })
				.setOnComplete(onComplete)
				.setOnUpdate(onUpdate);
		
			_chart = new MLineChart();
			_chart.addTo(this, 10, 200);
			_chart.showBoundLabels = true;
			_chart.setIndents(30, 0, 0, 0);
			_chart.values = [];
		}
		
		{
			var shape = newShape();
			addChild(shape);
			
			_backAlpha = 0;
			shape.alpha = .7;
			MTween.to(shape, 1000, { x:10, y:20, alpha: 1 })
				.setEase(MBack.typicalAbsolute.easeOut)
				.setOnComplete(onBackComplete);
		}
		
		{
			var column = new CVBox().addTo(this, 10, 300);
			
			new MLabel().setText("Power").addTo(column);
			
			var line = new CHBox().addTo(column);
			line.add(newEaseChart(MPower.quad.easeIn));
			line.add(newEaseChart(MPower.quad.easeOut));
			line.add(newEaseChart(MPower.quad.easeInOut));
		}
		
		{
			var column = new CVBox().addTo(this, 450, 10);
			
			new MLabel().setText("Expo.typical").addTo(column);
			
			var line = new CHBox().addTo(column);
			line.add(newEaseChart(MExpo.typical.easeIn));
			line.add(newEaseChart(MExpo.typical.easeOut));
			line.add(newEaseChart(MExpo.typical.easeInOut));
			
			new MLabel().setText("Bounce.typical").addTo(column);
			
			var line = new CHBox().addTo(column);
			line.add(newEaseChart(MBounce.typical.easeIn));
			line.add(newEaseChart(MBounce.typical.easeOut));
			line.add(newEaseChart(MBounce.typical.easeInOut));
			
			new MLabel().setText("Bounce.typicalAbsolute").addTo(column);
			
			var line = new CHBox().addTo(column);
			line.add(newEaseChart(MBounce.typicalAbsolute.easeIn));
			line.add(newEaseChart(MBounce.typicalAbsolute.easeOut));
			line.add(newEaseChart(MBounce.typicalAbsolute.easeInOut));
			
			new MLabel().setText("Back.typical").addTo(column);
			
			var line = new CHBox().addTo(column);
			line.add(newEaseChart(MBack.typical.easeIn));
			line.add(newEaseChart(MBack.typical.easeOut));
			line.add(newEaseChart(MBack.typical.easeInOut));
			
			new MLabel().setText("Back.typicalAbsolute").addTo(column);
			
			var line = new CHBox().addTo(column);
			line.add(newEaseChart(MBack.typicalAbsolute.easeIn));
			line.add(newEaseChart(MBack.typicalAbsolute.easeOut));
			line.add(newEaseChart(MBack.typicalAbsolute.easeInOut));
		}
	}
	
	var _chart:MLineChart;
	
	function onComplete(tween)
	{
		MTween.to(
			tween.target,
			1000, { x:100 - Math.random() * 100, y:100 - Math.random() * 100 })
			.setOnComplete(onComplete)
			.setOnUpdate(onUpdate);
	}
	
	var _backAlpha:Float;
	
	function onBackComplete(tween)
	{
		_backAlpha += Math.PI * .25;
		MTween.to(
			tween.target,
			1000, { x:300 + Math.cos(_backAlpha) * 50, y:150 + Math.sin(_backAlpha) * 50 })
			.setEase(MBack.typicalAbsolute.easeOut)
			.setOnComplete(onBackComplete);
	}
	
	function onUpdate(tween)
	{
		var values = _chart.values;
		values.push(tween.getValue(0, 100));
		if (values.length > 50)
		{
			values.shift();
		}
		_chart.invalidate();
	}
	
	function newShape()
	{
		var shape = new Shape();
		var g = shape.graphics;
		g.lineStyle(0, 0x800000);
		g.beginFill(0xff0000);
		g.drawRect(0, 0, 100, 100);
		g.endFill();
		return shape;
	}
	
	function newEaseChart(ease:MEaseMethod)
	{
		var values = [];
		
		for (i in 0 ... 101)
		{
			values.push(ease(i, 100, 200 - 100, 100));
		}
		
		var chart = new MLineChart();
		chart.setSize(100, 80);
		chart.showBoundLabels = true;
		chart.autoScale = false;
		chart.minValue = 100;
		chart.maxValue = 200;
		chart.values = values;
		return chart;
	}
}