package ;
import flash.display.Shape;
import flash.display.Sprite;
import helpers.Scaler;
import temperate.containers.CHBox;
import temperate.containers.CScrollPane;
import temperate.containers.CVBox;
import temperate.minimal.MScrollBar;
import temperate.minimal.skins.MFieldRectSkin;

class TestScrollPane extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var main = new CVBox().addTo(this, 10, 10);
		
		{
			var line = new CHBox().addTo(main);
			
			var scrollPane = new CScrollPane(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			scrollPane.set(newShape(300, 200));
			line.add(scrollPane);
			
			var scrollPane = new CScrollPane(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			scrollPane.set(newShape(100, 100));
			scrollPane.setSize(80, 80);
			var scaler = new Scaler(scrollPane);
			line.add(scaler);
		}
	}
	
	function newShape(width:Float, height:Float)
	{
		var shape = new Shape();
		var g = shape.graphics;
		g.lineStyle(2, 0xff0000);
		g.beginFill(0x0000ff, .5);
		g.drawRect(0, 0, width, height);
		g.endFill();
		g.moveTo(0, 0);
		g.lineTo(width, height);
		g.moveTo(0, height);
		g.lineTo(width, 0);
		return shape;
	}
	
	function newHScrollBar()
	{
		return new MScrollBar(true);
	}
	
	function newVScrollBar()
	{
		return new MScrollBar(false);
	}
}