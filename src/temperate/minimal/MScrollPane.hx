package temperate.minimal;
import temperate.containers.CScrollPane;
import temperate.skins.CNullRectSkin;

class MScrollPane extends CScrollPane
{
	public function new() 
	{
		super(newHScrollBar, newVScrollBar, CNullRectSkin.getInstance());
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