package ;
import flash.display.Sprite;
import helpers.Scaler;
import temperate.components.CScrollBar;
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
		newScrollBar(true).addTo(this);
		newScrollBar(false).addTo(this, 100, 0);
		
		var scrollBar = newScrollBar(true).addTo(this, 0, 120);
		scrollBar.pageSize = 50;
		var scrollBar = newScrollBar(false).addTo(this, 100, 120);
		scrollBar.pageSize = 50;
		
		var scrollBar = newScrollBar(false).addTo(this, 200, 120);
		scrollBar.pageSize = 50;
		addChild(new Scaler(scrollBar));
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