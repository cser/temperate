package ;
import flash.display.Shape;
import flash.display.Sprite;
import temperate.components.CScrollPane;
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
		var scrollPane = new CScrollPane(newHScrollBar, newVScrollBar, new MFieldRectSkin());
		scrollPane.content = newShape(300, 200);
		addChild(scrollPane);
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