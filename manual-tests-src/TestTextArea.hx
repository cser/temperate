package ;
import flash.display.Sprite;
import flash.text.TextFieldType;
import temperate.containers.CVBox;
import temperate.minimal.MScrollBar;
import temperate.text.CTextArea;

class TestTextArea extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var main = new CVBox().addTo(this, 10, 10);
		
		var area = new CTextArea(new MScrollBar(false)).addTo(main);
		area.text = "Line 1\nLine 2\nLine 3\nLine 4\nLine 5\nLine 6\nLine 7\nLine 8\nLine 9" +
			"\nLine10\nlines11";
		
		var area = new CTextArea(new MScrollBar(false)).addTo(main);
		area.text = "Line 1\nLine 2\nLine 3";
		
		var area = new CTextArea(new MScrollBar(false)).addTo(main);
		area.type = TextFieldType.INPUT;
		area.text = "Line 1\nLine 2\nLine 3";
	}
}