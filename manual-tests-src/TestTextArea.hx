package ;
import flash.display.Sprite;
import flash.text.TextFieldType;
import haxe.Timer;
import helpers.Scaler;
import temperate.containers.CVBox;
import temperate.core.CValidator;
import temperate.minimal.MScrollBar;
import temperate.minimal.skins.MFieldRectSkin;
import temperate.skins.CNullRectSkin;
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
		
		var area = new CTextArea(new MScrollBar(false), new MFieldRectSkin()).addTo(main);
		area.text = "Line 1\nLine 2\nLine 3\nLine 4\nLine 5\nLine 6\nLine 7\nLine 8\nLine 9" +
			"\nLine10\nlines11";
		
		var area = new CTextArea(new MScrollBar(false), new MFieldRectSkin()).addTo(main);
		area.text = "Line 1\nLine 2\nLine 3";
		
		var area = new CTextArea(new MScrollBar(false), new MFieldRectSkin());
		area.type = TextFieldType.INPUT;
		area.text = "Line 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
			"\nLine 1\nLine 2\nLine 3";
		var scaler = new Scaler(area);
		main.add(scaler);
		
		new TestScrollBarBug(true).addTo(main);
		new TestScrollBarBug(false).addTo(main);
	}
}
class TestScrollBarBug extends temperate.minimal.MScrollBar
{
	public function new(horizontal:Bool)
	{
		super(horizontal);
		
		value = 1;
		minValue = 1;
		maxValue = 7;
		pageSize = 6;
		value = 8;
		Timer.delay(onDelay, 100);
	}
	
	function onDelay()
	{
		pageSize = 30;
	}
}