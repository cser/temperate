package temperate.minimal;
import temperate.minimal.skins.MFieldRectSkin;
import temperate.text.CTextArea;

class MTextArea extends CTextArea
{
	public function new() 
	{
		super(newHScrollBar, newVScrollBar, new MFieldRectSkin());
		_layout.minWidth = 51;
		_layout.minHeight = 51;
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