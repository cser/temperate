package minimal;
import flash.display.Sprite;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.charts.MBarChart;
import temperate.minimal.charts.MPieChart;

class TestMCharts2 extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var main = new CVBox();
		main.addTo(this, 20, 10);
		main.setIndents(10, 10, 10, 10);
		
		var box = new CHBox().addTo(main);
		
		var chart = new MBarChart();
		chart.showValueLabels = true;
		chart.values = [ -10., -2, -1, -3, -10];
		box.add(chart);
		
		var chart = new MPieChart();
		chart.values = [10., 2, 3];
		box.add(chart);
		
		var chart = new MPieChart();
		chart.values = [100., 20, 30];
		chart.setIndents(50, 50, 50, 50);
		chart.setSize(200, 200);
		box.add(chart);
		
		var chart = new MPieChart();
		chart.values = [1., 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
		chart.lineColor = 0x00000000;
		box.add(chart);
		
		var box = new CHBox().addTo(main);
		
		var chart = new MPieChart();
		chart.values = [1000., 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000];
		chart.lineColor = 0x00000000;
		box.add(chart);
		
		var chart = new MBarChart();
		chart.values = [10., 1, 2, -3];
		chart.showInnerBorder = false;
		chart.setIndents(30, 10, 5, 5);
		chart.showBoundLabels = true;
		box.add(chart);
		
		var chart = new MBarChart();
		chart.values = [10., 1, 2, -3];
		chart.showBoundLabels = true;
		chart.showValueLabels = true;
		chart.lineColor = 0xff00ff00;
		box.add(chart);
		
		var chart = new MBarChart();
		chart.values = [10., 1, 2, -3];
		chart.showBoundLabels = true;
		chart.showValueLabels = true;
		chart.lineColor = 0xff00ff00;
		chart.lineWidth = 4;
		box.add(chart);
		
		var box = new CHBox().addTo(main);
		
		var chart = new MPieChart();
		chart.values = [10., 1, 2, -3];
		chart.lineColor = 0xffffffff;
		chart.lineWidth = 2;
		box.add(chart);
		
		var g = main.graphics;
		g.clear();
		g.beginFill(0xffffff);
		g.drawRect(0, 0, main.width, main.height);
		g.endFill();
	}
}