package ;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.StageQuality;
import helpers.Scaler;
import temperate.components.CScrollBar;
import temperate.containers.CVBox;
import temperate.minimal.graphics.MScrollBarBdFactory;
import temperate.minimal.MButton;
import temperate.minimal.skins.MFieldRectSkin;

class TestScrollBar extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		stage.quality = StageQuality.LOW;
		
		newScrollBar(true).addTo(this);
		newScrollBar(false).addTo(this, 100, 0);
		
		var scrollBar = newScrollBar(true).addTo(this, 0, 120);
		scrollBar.pageSize = 50;
		var scrollBar = newScrollBar(false).addTo(this, 100, 120);
		scrollBar.pageSize = 50;
		
		var scrollBar = newScrollBar(false).addTo(this, 200, 120);
		scrollBar.pageSize = 50;
		addChild(new Scaler(scrollBar));
		
		var g = graphics;
		g.beginFill(0xeeeeee);
		g.drawRect(0, 290, 200, 200);
		g.endFill();
		
		newButtonsBlock().addTo(this, 10, 300);
		newButtonsBlock().addTo(this, 210, 300);
	}
	
	function newButtonsBlock()
	{
		var column = new CVBox();
		column.add(new Bitmap(MScrollBarBdFactory.getScrollLeftUp()));
		column.add(new Bitmap(MScrollBarBdFactory.getScrollLeftOver()));
		return column;
	}
	
	function newScrollBar(horizontal)
	{
		return new CScrollBar(
			horizontal, new MButton().setText("-"),
			new MButton().setText("+"),
			new MButton().setText("::"),
			new MFieldRectSkin()
		);
	}
}