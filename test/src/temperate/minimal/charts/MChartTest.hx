package temperate.minimal.charts;

import massive.munit.Assert;

class MChartTest
{
	public function new()
	{
	}
	
	@Test
	public function barChart_clearingStupidBugs()
	{
		var chart = new MBarChart();
		
		chart.setIndents(1, 2, 3, 4);
		Assert.areEqual(1, chart.indentLeft);
		Assert.areEqual(2, chart.indentRight);
		Assert.areEqual(3, chart.indentTop);
		Assert.areEqual(4, chart.indentBottom);
		
		chart.setValues([1., 2, 3]);
		ArrayAssert.areEqual([1, 2, 3], chart.values);
		
		chart.autoScale = true;
		Assert.areEqual(true, chart.autoScale);
		
		chart.autoScale = false;
		Assert.areEqual(false, chart.autoScale);
		
		chart.barColor = 0xff123456;
		ExtendedAssert.areUIntEqual(0xff123456, chart.barColor);
		
		chart.bgColor = 0xffe0e0e0;
		ExtendedAssert.areUIntEqual(0xffe0e0e0, chart.bgColor);
		
		chart.borderColor = 0x80a0a0a0;
		ExtendedAssert.areUIntEqual(0x80a0a0a0, chart.borderColor);
		
		chart.colors = [0xff000000, 0xffeeeeee];
		ArrayAssert.areEqual([0xff000000, 0xffeeeeee], chart.colors);
		
		chart.labelPrecision = 2;
		Assert.areEqual(2, chart.labelPrecision);
		
		chart.labels = ["one", "two"];
		ArrayAssert.areEqual(["one", "two"], chart.labels);
		
		chart.maxValue = 1111;
		Assert.areEqual(1111, chart.maxValue);
		
		chart.minValue = -111;
		Assert.areEqual( -111, chart.minValue);
		
		chart.showBoundLabels = true;
		Assert.areEqual(true, chart.showBoundLabels);
		
		chart.showBoundLabels = false;
		Assert.areEqual(false, chart.showBoundLabels);
		
		chart.showValueLabels = true;
		Assert.areEqual(true, chart.showValueLabels);
		
		chart.showValueLabels = false;
		Assert.areEqual(false, chart.showValueLabels);
		
		chart.spacing = 11;
		Assert.areEqual(11, chart.spacing);
		
		chart.showInnerBorder = true;
		Assert.areEqual(true, chart.showInnerBorder);
		
		chart.showInnerBorder = false;
		Assert.areEqual(false, chart.showInnerBorder);
	}
	
	@Test
	public function lineChart_clearingStupidBugs()
	{
		var chart = new MLineChart();
		
		chart.lineWidth = 123;
		Assert.areEqual(123, chart.lineWidth);
		
		chart.lineColor = 0x80abcdef;
		ExtendedAssert.areUIntEqual(0x80abcdef, chart.lineColor);
	}
	
	@Test
	public function pieChart_clearingStupidBugs()
	{
		var chart = new MPieChart();
		
		chart.lineColor = 0x80abcdef;
		ExtendedAssert.areUIntEqual(0x80abcdef, chart.lineColor);
		
		chart.colors = [0xff000000, 0xffeeeeee];
		ArrayAssert.areEqual([0xff000000, 0xffeeeeee], chart.colors);
	}
	
	@Test
	public function minSizeIsNotLess10_and_settedSizeRestored()
	{
		var chart = new MBarChart();
		chart.setSize(0, 0);
		chart.setIndents(0, 0, 0, 0);
		Assert.areEqual(10, chart.width);
		Assert.areEqual(10, chart.height);
		
		chart.setIndents(100, 101, 102, 103);
		Assert.areEqual(211, chart.width);
		Assert.areEqual(215, chart.height);
		
		chart.setSize(50, 60);
		Assert.areEqual(211, chart.width);
		Assert.areEqual(215, chart.height);
		
		chart.setIndents(0, 0, 0, 0);
		Assert.areEqual(50, chart.width);
		Assert.areEqual(60, chart.height);
	}
	
	@Test
	public function boundValuesCases()
	{
		var chart = new MBarChart();
		chart.values = [1., 2, 3, 4, 5];
		Assert.areEqual(1, chart.minValue);
		Assert.areEqual(5, chart.maxValue);
		
		chart.values = [0, -10, 6, 4, .1];
		Assert.areEqual(-10, chart.minValue);
		Assert.areEqual(6, chart.maxValue);
		
		chart.values = [-30., -10, -21, -25];
		Assert.areEqual(-30, chart.minValue);
		Assert.areEqual(-10, chart.maxValue);
	}
	
	@Test
	public function boundValuesOfEmptyChartAreEqualToSetted()
	{
		var chart = new MBarChart();
		chart.minValue = 5;
		chart.maxValue = 20;
		chart.values = [];
		Assert.areEqual(5, chart.minValue);
		Assert.areEqual(20, chart.maxValue);
		
		chart.values = null;
		Assert.areEqual(5, chart.minValue);
		Assert.areEqual(20, chart.maxValue);
	}
	
	@Test
	public function notFiniteValuesAcceptAsZeroDuringBoundValuesCalculation()
	{
		var chart = new MBarChart();
		chart.minValue = 5;
		chart.maxValue = 20;
		chart.values = [Math.NaN, 1, 2, Math.POSITIVE_INFINITY];
		Assert.areEqual(0, chart.minValue);
		Assert.areEqual(2, chart.maxValue);
		
		chart.values = [Math.NEGATIVE_INFINITY, -1, -100];
		Assert.areEqual(-100, chart.minValue);
		Assert.areEqual(0, chart.maxValue);
	}
	
	@Test
	public function ifDeltaValuesIsZeroOneSetted()
	{
		var chart = new MBarChart();
		chart.minValue = 5;
		chart.maxValue = 20;
		chart.values = [21., 21, 21];
		Assert.areEqual(21, chart.minValue);
		Assert.areEqual(22, chart.maxValue);
	}
}