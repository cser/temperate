package ;
import flash.display.Shape;
import flash.display.Sprite;
import helpers.Scaler;
import temperate.components.CScrollPolicy;
import temperate.containers.CHBox;
import temperate.containers.CScrollPane;
import temperate.containers.CVBox;
import temperate.minimal.MButton;
import temperate.minimal.MLabel;
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
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("Default").addTo(column);
			var scrollPane = new CScrollPane(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			scrollPane.set(newShape(100, 100));
			scrollPane.setSize(80, 80);
			var scaler = new Scaler(scrollPane);
			column.add(scaler);
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("CScrollPolicy.OFF\nCScrollPolicy.OFF").addTo(column);
			var scrollPane = new CScrollPane(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			scrollPane.hScrollPolicy = CScrollPolicy.OFF;
			scrollPane.vScrollPolicy = CScrollPolicy.OFF;
			scrollPane.set(newShape(100, 100));
			scrollPane.setSize(80, 80);
			var scaler = new Scaler(scrollPane);
			column.add(scaler);
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("CScrollPolicy.OFF\nCScrollPolicy.OFF").addTo(column);
			var scrollPane = new CScrollPane(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			scrollPane.hScrollPolicy = CScrollPolicy.OFF;
			scrollPane.vScrollPolicy = CScrollPolicy.OFF;
			scrollPane.set(new MButton().setText("Button")).setPercents(100, 100);
			scrollPane.setSize(80, 80);
			var scaler = new Scaler(scrollPane);
			column.add(scaler);
		}
		
		{
			var line = new CHBox().addTo(main);
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("CScrollPolicy.AUTO\nCScrollPolicy.OFF").addTo(column);
			var scrollPane = new CScrollPane(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			scrollPane.vScrollPolicy = CScrollPolicy.OFF;
			scrollPane.set(newShape(100, 100));
			scrollPane.setSize(80, 80);
			var scaler = new Scaler(scrollPane);
			column.add(scaler);
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("CScrollPolicy.AUTO\nCScrollPolicy.OFF").addTo(column);
			var scrollPane = new CScrollPane(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			scrollPane.vScrollPolicy = CScrollPolicy.OFF;
			scrollPane.set(new MButton().setText("Button")).setPercents(100, 100);
			scrollPane.setSize(80, 80);
			var scaler = new Scaler(scrollPane);
			column.add(scaler);
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("CScrollPolicy.ON\nCScrollPolicy.ON").addTo(column);
			var scrollPane = new CScrollPane(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			scrollPane.hScrollPolicy = CScrollPolicy.ON;
			scrollPane.vScrollPolicy = CScrollPolicy.ON;
			scrollPane.set(newShape(100, 100));
			scrollPane.setSize(80, 80);
			var scaler = new Scaler(scrollPane);
			column.add(scaler);
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("CScrollPolicy.ON\nCScrollPolicy.ON").addTo(column);
			var scrollPane = new CScrollPane(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			scrollPane.hScrollPolicy = CScrollPolicy.ON;
			scrollPane.vScrollPolicy = CScrollPolicy.ON;
			scrollPane.set(new MButton().setText("Button")).setPercents(100, 100);
			scrollPane.setSize(80, 80);
			var scaler = new Scaler(scrollPane);
			column.add(scaler);
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