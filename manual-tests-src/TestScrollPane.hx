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
			
			{
				var column = new CVBox();
				column.setIndents(0, 20, 0, 10);
				new MLabel().setText("isEnabled = false").addTo(column);
				var scrollPane = new CScrollPane(
					newHScrollBar, newVScrollBar, new MFieldRectSkin()
				);
				scrollPane.hScrollPolicy = CScrollPolicy.ON;
				scrollPane.vScrollPolicy = CScrollPolicy.ON;
				scrollPane.set(newShape(81, 50));
				scrollPane.setSize(80, 80);
				scrollPane.isEnabled = false;
				var scaler = new Scaler(scrollPane);
				column.add(scaler);
				line.addChild(column);
			}
			
			{
				var column = new CVBox();
				column.setIndents(0, 20, 0, 10);
				new MLabel().setText("scroll = (10, 20)").addTo(column);
				var scrollPane = new CScrollPane(
					newHScrollBar, newVScrollBar, new MFieldRectSkin()
				);
				scrollPane.hScrollPolicy = CScrollPolicy.ON;
				scrollPane.vScrollPolicy = CScrollPolicy.ON;
				scrollPane.set(newShape(100, 100));
				scrollPane.setSize(80, 80);
				scrollPane.hScrollValue = 10;
				scrollPane.vScrollValue = 20;
				var scaler = new Scaler(scrollPane);
				column.add(scaler);
				line.addChild(column);
			}
		}
		
		{
			var line = new CHBox().addTo(main);
			
			newIndentedScrollPaneBlock(line, CScrollPolicy.OFF, CScrollPolicy.OFF);
			newIndentedScrollPaneBlock(line, CScrollPolicy.AUTO, CScrollPolicy.OFF);
			newIndentedScrollPaneBlock(line, CScrollPolicy.AUTO, CScrollPolicy.ON);
			newIndentedScrollPaneBlock(line, CScrollPolicy.OFF, CScrollPolicy.AUTO);
			newIndentedScrollPaneBlock(line, CScrollPolicy.ON, CScrollPolicy.AUTO);
			newIndentedScrollPaneBlock(line, CScrollPolicy.AUTO, CScrollPolicy.AUTO);
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
	
	function newIndentedScrollPaneBlock(
		parent:DisplayObjectContainer,
		hScrollPolicy:CScrollPolicy, vScrollPolicy:CScrollPolicy
	):CChildWrapper
	{
		var column = new CVBox();
		column.setIndents(0, 20, 0, 10);
		new MLabel().setText(
			"hScrollPolicy=" + hScrollPolicy + "\nvScrollPolicy=" + vScrollPolicy
		).addTo(column);
		var scrollPane = new CScrollPane(newHScrollBar, newVScrollBar, new MFieldRectSkin());
		scrollPane.setContentIndents(20, 10, 5, 15);
		scrollPane.hScrollPolicy = hScrollPolicy;
		scrollPane.vScrollPolicy = vScrollPolicy;
		var wrapper = scrollPane.set(new MButton().setText("Content"))
			.setPercents(100, 100)
			.setContingencies(75, CMath.INT_MAX_VALUE, 50, CMath.INT_MAX_VALUE);
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
		
		g.beginFill(0x0000ff, .5);
		g.drawRect(0, 0, width, height);
		g.endFill();
		
		g.beginFill(0x000000);
		g.moveTo(0, 0);
		g.lineTo(2, 0);
		g.lineTo(width, height);
		g.lineTo(width - 2, height);
		g.lineTo(0, 0);
		g.endFill();
		
		g.beginFill(0x000000);
		g.moveTo(2, height);
		g.lineTo(0, height);
		g.lineTo(width - 2, 0);
		g.lineTo(width, 0);
		g.lineTo(2, height);
		g.endFill();
		
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