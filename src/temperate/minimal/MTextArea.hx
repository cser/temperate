package temperate.minimal;
import temperate.minimal.skins.MFieldRectSkin;
import temperate.text.CTextArea;

class MTextArea extends CTextArea
{
	public function new() 
	{
		super(newHScrollBar, newVScrollBar, new MFieldRectSkin());
		minWidth = 51;
		minHeight = 51;
		format = MFormatFactory.LABEL;
		setTextIndents(2, 2, 2, 2);
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