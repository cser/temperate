package ;
import flash.display.Sprite;
import flash.text.TextFieldType;
import haxe.Timer;
import temperate.containers.CVBox;
import temperate.core.CValidator;
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
		
		/*var area = new CTextArea(new MScrollBar(false)).addTo(main);
		area.text = "Line 1\nLine 2\nLine 3\nLine 4\nLine 5\nLine 6\nLine 7\nLine 8\nLine 9" +
			"\nLine10\nlines11";
		
		var area = new CTextArea(new MScrollBar(false)).addTo(main);
		area.text = "Line 1\nLine 2\nLine 3";*/
		
		var area = new CTextArea(new MScrollBar(false)).addTo(main);
		area.type = TextFieldType.INPUT;
		area.text = "Line 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
			"\nLine 1\nLine 2\nLine 3";
		
		/*var sb = new MScrollBar(false).addTo(main);
		
		sb.minValue = 1;
		sb.maxValue = 20;
		sb.pageSize = 20;
		sb.value = 20;
		sb.validate();
		
		sb.maxValue = 22;
		//sb.validate();
		*/
		
		new TestScrollBarBug(true).addTo(main);
		new TestScrollBarBug(false).addTo(main);
	}
}
import temperate.minimal.MScrollBar;
class TestScrollBarBug extends MScrollBar
{
	public function new(horizontal:Bool)
	{
		super(horizontal);
		
		value = 1;
		minValue = 1;
		maxValue = 7;
		pageSize = 6;
		
		Timer.delay(onDelay1, 100);
		Timer.delay(onDelay2, 200);
	}
	
	function onDelay1()
	{
		value = 8;
		minValue = 1;
		maxValue = 8;
		pageSize = 13;
	}
	
	function onDelay2()
	{
		minValue = 1;
		maxValue = 8;
		pageSize = 13;
	}
}