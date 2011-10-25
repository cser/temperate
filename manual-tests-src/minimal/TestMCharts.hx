package minimal;
import flash.display.Sprite;
import flash.events.Event;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.charts.MBarChart;
import temperate.minimal.charts.MLineChart;
import temperate.minimal.charts.MPieChart;
import temperate.minimal.MButton;
import temperate.text.CTextFormat;

class TestMCharts extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var data = [0., 1, 8, 2, 4, 5];
		
		var main = new CVBox().addTo(this, 20, 10);
		
		var box = new CHBox().addTo(main);
		new MLineChart().setValues(data).addTo(box);
		new MBarChart().setValues(data).addTo(box);
		new MPieChart().setValues(data).addTo(box);
		
		_dynamicChart = new MBarChart();
		_dynamicChart.values = [];
		_dynamicChart.showBoundLabels = true;
		box.add(_dynamicChart);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		var box = new CHBox().addTo(main);
		
		box.add(newLineChart());
		box.add(newBarChart());
		box.add(newPieChart());
		
		var chart = newLineChart();
		chart.setIndents(20, 10, 5, 50);
		chart.setSize(150, 200);
		box.add(chart);
		
		var chart = newBarChart();
		chart.setIndents(20, 10, 25, 50);
		chart.setSize(150, 200);
		box.add(chart);
		
		var chart = newPieChart();
		chart.setIndents(20, 10, 5, 50);
		chart.setSize(150, 200);
		box.add(chart);
		
		var box = new CHBox().addTo(main);
		
		var chart = newLineChart();
		chart.setSize(150, 200);
		chart.autoScale = false;
		chart.minValue = -30;
		chart.maxValue = 50;
		box.add(chart);
		
		var chart = newBarChart();
		chart.setSize(150, 200);
		chart.autoScale = false;
		chart.minValue = -30;
		chart.maxValue = 50;
		box.add(chart);
		
		var chart = newPieChart();
		chart.setSize(150, 200);
		chart.autoScale = false;
		chart.minValue = -30;
		chart.maxValue = 50;
		box.add(chart);
		
		var chart = newLineChart();
		chart.setSize(150, 200);
		chart.values = [0., -2, 3.5, -8, 1, 7];
		box.add(chart);
		
		var chart = newBarChart();
		chart.setSize(150, 200);
		chart.values = [0., -2, 3.5, -8, 1, 7];
		chart.spacing = 10;
		box.add(chart);
		
		new MButton().setText("Show / hide test 2").addClickHandler(onShowTest2Click).addTo(main);
	}
	
	private var _test2:TestMCharts2;
	
	function onShowTest2Click(event:Event)
	{
		if (_test2 == null)
		{
			_test2 = new TestMCharts2();
			_test2.visible = false;
			addChild(_test2);
			
			_test2.init();
		}
		_test2.visible = !_test2.visible;
	}
	
	var _dynamicChart:MBarChart;
	
	function onEnterFrame(event:Event)
	{
		if (_dynamicChart.values == null)
		{
			_dynamicChart.values = [];
		}
		_dynamicChart.values.push(10 - Math.random() * 20);
		_dynamicChart.invalidate();
		if (_dynamicChart.values.length > 20)
		{
			_dynamicChart.values.shift();
		}
	}
	
	function newLineChart()
	{
		var chart = new MLineChart(
			new CTextFormat().setFont("Tahoma").setBold(true).setColor(0xff0000).setAlpha(.5));
		chart.setValues(
			[1.5, 1, 8, 2, 4, 5],
			["First", "Second", "Third", "Fourth", "Fifth", "Sixth"]);
		chart.lineColor = 0x800000ff;
		chart.showValueLabels = true;
		chart.showBoundLabels = true;
		chart.width = 100;
		chart.height = 200;
		return chart;
	}
	
	function newBarChart()
	{
		var chart = new MBarChart();
		chart.showValueLabels = true;
		chart.labelPrecision = 1;
		chart.values = [1.5, 1, 8, 2, 4, 5];
		chart.colors = [0xffff0000, 0x800000ff, 0x8000ff00, 0xffffff00, 0xffff00ff, 0xffc0ff00];
		chart.showBoundLabels = true;
		chart.width = 100;
		chart.height = 200;
		return chart;
	}
	
	function newPieChart()
	{
		var chart = new MPieChart();
		chart.lineColor = 0x00000000;
		chart.values = [0., 1, 8, 2, 4, 5];
		chart.labels = ["First", "Second", "Third", "Fourth", "Fifth", "Sixth"];
		chart.width = 100;
		chart.height = 200;
		chart.chartRotation = 45;
		return chart;
	}
}