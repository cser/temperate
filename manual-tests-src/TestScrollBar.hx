package ;
import flash.display.Sprite;
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
		new CScrollBar(
			true, new MButton().setText("-"),
			new MButton().setText("+"),
			new MButton().setText("::"),
			new MFieldRectSkin()
		).addTo(this);
	}
}