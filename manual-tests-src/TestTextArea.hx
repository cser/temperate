package ;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldType;
import helpers.Scaler;
import temperate.components.CScrollPolicy;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MLabel;
import temperate.minimal.MScrollBar;
import temperate.minimal.MTextArea;
import temperate.minimal.skins.MFieldRectSkin;
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
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin())
				.addTo(line);
			area.height = 200;
			area.text = "Line 1\nLine 2\nLine 3\nLine 4\nLine 5\nLine 6\nLine 7\nLine 8\nLine 9" +
				"\nLine10\nlines11";
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin())
				.addTo(line);
			area.text = "Line 1\nLine 2\n" + MFormatFactory.LABEL_ERROR.toHtml("Line 3");
			area.html = true;
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.editable = true;
			area.updateOnMove = true;
			area.height = 250;
			area.text = "updateOnMove = true\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 0);
			
			{
				var column = new CVBox().addTo(line);
				new MLabel().setText("Scroll bar\nbug checking").addTo(column);
				new TestScrollBarBug(true).addTo(column);
				new TestScrollBarBug(false).addTo(column);
				var area = new MTextArea().addTo(column);
				area.isEnabled = false;
				area.selectable = false;
				area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
					"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			}
			
			{
				var column = new CVBox().addTo(line);
				new MLabel().setText("mouseWheelDimRatio = 3").addTo(column);
				var area = new MTextArea();
				area.mouseWheelDimRatio = 3;
				area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
					"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
				var scaler = new Scaler(area);
				column.add(scaler);
			}
		}
		
		{
			new MLabel().setText("Scroll policies").addTo(main);
			
			var line = new CHBox().addTo(main);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.editable = true;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.hScrollPolicy = CScrollPolicy.ON;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.editable = true;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.hScrollPolicy = CScrollPolicy.OFF;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.editable = true;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.vScrollPolicy = CScrollPolicy.ON;
			area.vScrollValue = 2;
			area.hScrollValue = 10;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.editable = true;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.vScrollPolicy = CScrollPolicy.OFF;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.editable = true;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.worldWrap = true;
			area.vScrollPolicy = CScrollPolicy.ON;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
		}
		
		{
			var line = new CHBox().addTo(main);
			
			new MLabel().setText("Compact\nand min sizes").addTo(line);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.editable = true;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.setCompact(true, false);
			area.minWidth = 60;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			var area = new CTextArea(newHScrollBar, newVScrollBar, new MFieldRectSkin());
			area.editable = true;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.setCompact(false, true);
			area.minHeight = 70;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			new MLabel().setText("World wrap").addTo(line);
			
			var area = new MTextArea();
			area.editable = true;
			area.text = "Line 1 text text\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3" +
				"\nLine 1\nLine 2\nLine 3\nLine 1\nLine 2\nLine 3";
			area.worldWrap = true;
			var scaler = new Scaler(area);
			line.add(scaler).setIndents(0, 50, 0, 50);
			
			new MLabel().setText("Native").addTo(line);
			
			_tf = new TextField();
			_tf.type = TextFieldType.INPUT;
			_tf.addEventListener(Event.CHANGE, onTfChange);
			_tf.multiline = true;
			_tf.wordWrap = true;
			_tf.border = true;
			MFormatFactory.LABEL.applyTo(_tf);
			line.add(_tf);
		}
		
		//new FPSMonitor().addTo(this);
	}
	
	var _tf:TextField;
	
	function onTfChange(event:Event)
	{
		_tf.width += Math.random() * 2 - 1;
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
		haxe.Timer.delay(onDelay, 100);
	}
	
	function onDelay()
	{
		pageSize = 30;
	}
}