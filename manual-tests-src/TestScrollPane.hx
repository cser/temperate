package ;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;
import helpers.Scaler;
import temperate.components.CScrollPolicy;
import temperate.containers.CHBox;
import temperate.containers.CScrollPane;
import temperate.containers.CVBox;
import temperate.core.CMath;
import temperate.layouts.parametrization.CChildWrapper;
import temperate.minimal.MButton;
import temperate.minimal.MLabel;
import temperate.minimal.MScrollBar;
import temperate.minimal.MScrollPane;
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
			
			newScrollPaneBlock(line, CScrollPolicy.AUTO, CScrollPolicy.AUTO, newShape(100, 100));
			newScrollPaneBlock(
				line, CScrollPolicy.AUTO, CScrollPolicy.AUTO, new MButton().setText("Button"))
				.setPercents(100, 100)
				.setContingencies(100, CMath.INT_MAX_VALUE, 50, CMath.INT_MAX_VALUE);
			newScrollPaneBlock(line, CScrollPolicy.OFF, CScrollPolicy.OFF, newShape(100, 100));
			newScrollPaneBlock(
				line, CScrollPolicy.OFF, CScrollPolicy.OFF, new MButton().setText("Button"))
				.setPercents(100, 100)
				.setContingencies(75, CMath.INT_MAX_VALUE, 50, CMath.INT_MAX_VALUE);
				
			var column = new CVBox().addTo(line);
			new MLabel().setText("MScrollPane").addTo(column);
			var scrollPane = new MScrollPane();
			scrollPane.hScrollPolicy = CScrollPolicy.ON;
			scrollPane.vScrollPolicy = CScrollPolicy.ON;
			scrollPane.set(newShape(110, 120));
			var scaler = new Scaler(scrollPane);
			column.add(scaler);
		}
		
		{
			var line = new CHBox().addTo(main);
			
			newScrollPaneBlock(line, CScrollPolicy.AUTO, CScrollPolicy.OFF, newShape(100, 100));
			newScrollPaneBlock(line, CScrollPolicy.AUTO, CScrollPolicy.ON, newShape(100, 100));
			newScrollPaneBlock(
				line, CScrollPolicy.AUTO, CScrollPolicy.OFF, new MButton().setText("Button"))
				.setPercents(100, 100)
				.setContingencies(75, CMath.INT_MAX_VALUE, 50, CMath.INT_MAX_VALUE);
			newScrollPaneBlock(
				line, CScrollPolicy.AUTO, CScrollPolicy.ON, new MButton().setText("Button"))
				.setPercents(100, 100)
				.setContingencies(75, CMath.INT_MAX_VALUE, 50, CMath.INT_MAX_VALUE);
			newScrollPaneBlock(line, CScrollPolicy.ON, CScrollPolicy.ON, newShape(100, 100));
			newScrollPaneBlock(
				line, CScrollPolicy.ON, CScrollPolicy.ON, new MButton().setText("Button"))
				.setPercents(100, 100)
				.setContingencies(75, CMath.INT_MAX_VALUE, 50, CMath.INT_MAX_VALUE);
		}
		
		{
			var line = new CHBox().addTo(main);
			
			newScrollPaneBlock(line, CScrollPolicy.OFF, CScrollPolicy.AUTO, newShape(100, 100));
			newScrollPaneBlock(line, CScrollPolicy.ON, CScrollPolicy.AUTO, newShape(100, 100));
			newScrollPaneBlock(
				line, CScrollPolicy.OFF, CScrollPolicy.AUTO, new MButton().setText("Button"))
				.setPercents(100, 100)
				.setContingencies(75, CMath.INT_MAX_VALUE, 50, CMath.INT_MAX_VALUE);
			newScrollPaneBlock(
				line, CScrollPolicy.ON, CScrollPolicy.AUTO, new MButton().setText("Button"))
				.setPercents(100, 100)
				.setContingencies(75, CMath.INT_MAX_VALUE, 50, CMath.INT_MAX_VALUE);
		}
	}
	
	function newScrollPaneBlock(
		parent:DisplayObjectContainer,
		hScrollPolicy:CScrollPolicy, vScrollPolicy:CScrollPolicy, content:DisplayObject
	):CChildWrapper
	{
		var column = new CVBox();
		column.setIndents(0, 20, 0, 10);
		new MLabel().setText(
			"hScrollPolicy=" + hScrollPolicy + "\nvScrollPolicy=" + vScrollPolicy
		).addTo(column);
		var scrollPane = new CScrollPane(newHScrollBar, newVScrollBar, new MFieldRectSkin());
		scrollPane.hScrollPolicy = hScrollPolicy;
		scrollPane.vScrollPolicy = vScrollPolicy;
		var wrapper = scrollPane.set(content);
		scrollPane.setSize(80, 80);
		var scaler = new Scaler(scrollPane);
		column.add(scaler);
		parent.addChild(column);
		return wrapper;
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