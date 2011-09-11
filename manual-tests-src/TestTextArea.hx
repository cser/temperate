package ;
import flash.display.Sprite;
import flash.text.TextFieldType;
import haxe.Timer;
import helpers.Scaler;
import temperate.components.CScrollPolicy;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.core.CValidator;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MLabel;
import temperate.minimal.MScrollBar;
import temperate.minimal.MTextArea;
import temperate.minimal.skins.MFieldRectSkin;
import temperate.skins.CNullRectSkin;
import temperate.text.CDefaultFormatFactory;
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
		
		{
			var line = new CHBox().addTo(main);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin()).addTo(line);
			area.text = "Line 1\nLine 2\nLine 3\nLine 4\nLine 5\nLine 6\nLine 7\nLine 8\nLine 9" +
				"\nLine10\nlines11";
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin()).addTo(line);
			area.text = "Line 1\nLine 2\n" + MFormatFactory.LABEL_ERROR.toHtml("Line 3");
			area.html = true;
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.type = TextFieldType.INPUT;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			new MLabel().setText("Scroll bar\nbug checking").addTo(line);
			new TestScrollBarBug(true).addTo(line);
			new TestScrollBarBug(false).addTo(line);
			
			new MLabel().setText("Scroll policies").addTo(main);
		}
		
		{
			var line = new CHBox().addTo(main);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.type = TextFieldType.INPUT;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.hScrollPolicy = CScrollPolicy.ON;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.type = TextFieldType.INPUT;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.hScrollPolicy = CScrollPolicy.OFF;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.type = TextFieldType.INPUT;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.vScrollPolicy = CScrollPolicy.ON;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.type = TextFieldType.INPUT;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.vScrollPolicy = CScrollPolicy.OFF;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
		}
		
		{
			var line = new CHBox().addTo(main);
			
			new MLabel().setText("Compact\nand min sizes").addTo(line);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.type = TextFieldType.INPUT;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.setCompact(true, false);
			area.minWidth = 60;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.type = TextFieldType.INPUT;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.setCompact(false, true);
			area.minHeight = 70;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			new MLabel().setText("World wrap").addTo(line);
			
			var area = new MTextArea();
			area.type = TextFieldType.INPUT;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.worldWrap = true;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
		}
		
		/*
		TODO
		Обеспечить работу worldWrap
		Отступы у текста
		Нормальное обвновление позиций скроллеров (без двойной пересылки событий)
		*/
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