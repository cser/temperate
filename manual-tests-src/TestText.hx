package ;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.GlowFilter;
import flash.geom.ColorTransform;
import temperate.containers.ACLineBox;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.containers.LayoutUtil;
import temperate.minimal.MButton;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MInputField;
import temperate.minimal.MNumericStepper;
import temperate.minimal.MSeparator;
import temperate.minimal.skins.MFieldRectSkin;
import temperate.text.CInputField;
import temperate.text.CLabel;
import temperate.text.CTextFormat;

class TestText extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{	
		_main = new CVBox();
		_main.addTo(this, 20, 10);
		
		{
			var tf = new CTextFormat("Tahoma", 12, 0xffffff, true).setFilters([new GlowFilter()])
				.newAutoSized();
			tf.text = "TextField with CTextFormat";
			_main.addChild(tf);
		}
		
		{
			var tf = new CTextFormat("Tahoma", 12, 0xff0080, true)
				.setAlpha(.5)
				.newAutoSized();
			tf.text = "TextField with CTextFormat alpha = .5";
			tf.x = 200;
			addChild(tf);
			
			var tf = new CTextFormat("Tahoma", 12, 0xff0080, true)
				.setColorTransform(new ColorTransform(0, 0, 2, .4, 0, 0, 0, 0))
				.newAutoSized();
			tf.text = "TextField with CTextFormat no alpha, colorTransform with alpha = .4";
			tf.x = 200;
			tf.y = 20;
			addChild(tf);
			
			var tf = new CTextFormat("Tahoma", 12, 0xff0080, true)
				.setAlpha(.5)
				.setColorTransform(new ColorTransform(0, 0, 2, .4, 0, 0, 0, 0))
				.newAutoSized();
			tf.text = "TextField with CTextFormat alpha = .5, colorTransform with alpha = .4";
			tf.x = 200;
			tf.y = 40;
			addChild(tf);
		}
		
		{
			var format = new CTextFormat("Tahoma", 14);
			
			var label = new CLabel().setText("CLabel").addTo(_main);
			label.format = format;
			
			var label = new CLabel().setText("CLabel (alignX=1, width=500)").addTo(_main);
			label.format = format;
			label.setTextAlign(1, 0);
			label.width = 500;
			
			var label = new CLabel().setText("CLabel (alignY=1, width=500, height=100)")
				.addTo(_main);
			label.format = format;
			label.setTextAlign(0, 1);
			label.width = 500;
			label.height = 100;
		}
		
		{
			var line = new CHBox().addTo(_main);
			
			{
				var column = new CVBox().addTo(line);
				column.add(new CLabel().setText("Default CInputField"));
				newInputField().addTo(column);
			}
			
			line.add(new MSeparator(false)).setPercents( -1, 100);
			
			{
				var column = new CVBox().addTo(line);
				
				column.add(new CLabel().setText("CInputField with listener"));
				_field = newInputField().addTo(column);
				_field.text = "Some text";
				_field.addEventListener(Event.CHANGE, onFieldChange);
				
				_label = new CLabel().addTo(column);
				_label.setSize(200, 0);
				_label.setTextAlign(1, 0);
				
				new MButton().setText("Set \"Another text\"")
					.addClickHandler(onSetAnotherTextClick)
					.addTo(column);
				
				onFieldChange();
			}
			
			line.add(new MSeparator(false)).setPercents( -1, 100);
			
			{
				var column = new CVBox().addTo(line);
				column.add(new CLabel().setText("Uneditable CInputField"));
				var field = newInputField().setText("Some text").addTo(column);
				field.editable = false;
			}
			
			line.add(new MSeparator(false)).setPercents( -1, 100);
			
			{
				var column = new CVBox().addTo(line);
				column.add(new CLabel().setText("Disabled CInputField"));
				var field = newInputField().setText("Some text").addTo(column);
				field.isEnabled = false;
			}
			
			line.add(new MSeparator(false)).setPercents( -1, 100);
			
			{
				var column = new CVBox().addTo(line);
				column.add(new CLabel().setText("MInputField"));
				
				new MInputField().setText("Some text").addTo(column);
				new MInputField().setText("Unselectable").addTo(column).selectable = false;
				new MInputField().setText("Uneditable").addTo(column).editable = false;
				
				var field = new MInputField().setText("Unaditable unselectable").addTo(column);
				field.editable = false;
				field.selectable = false;
				
				new MInputField().setText("Disabled").addTo(column).isEnabled = false;
				
				var field = new MInputField().setText("Disabled unselectable").addTo(column);
				field.isEnabled = false;
				field.selectable = false;
			}
		}
		
		_main.add(new MSeparator(true)).setPercents(100);
		
		{
			var line = new CHBox().addTo(_main);
			line.add(new CLabel().setText("MNumericStapper and MInputField comparision"));
			line.add(new MNumericStepper());
			line.add(new MInputField().setText("Some text"));
		}
		
		_main.add(new MSeparator(true)).setPercents(100);
			
		{
			var line = new CHBox().addTo(_main);
			
			{
				var column = new CVBox().addTo(line);		
				column.add(new CLabel().setText("MInputText with restrict 0123456789."));
				
				var field = new MInputField().setText("123").addTo(column);
			}
			
			line.add(new MSeparator(false)).setPercents( -1, 100);
			
			{
				var column = new CVBox().addTo(line);		
				column.add(new CLabel().setText("Password MInputText"));
				
				var field = new MInputField().setText("qwerty").addTo(column);
				field.displayAsPassword = true;
			}
			
			line.add(new MSeparator(false)).setPercents( -1, 100);
			
			{
				var column = new CVBox().addTo(line);		
				column.add(new CLabel().setText("MInputText with correct checking"));
				column.add(new CLabel().setText("Input text with 5 or more symbols"));
				
				_correctCheckedField = new MInputField().setText("text").addTo(column);
				_correctCheckedField.addEventListener(Event.CHANGE, onCorrectCheckedFieldChange);
				onCorrectCheckedFieldChange();
			}
		}
		
		_main.add(new MSeparator(true)).setPercents(100);
		
		{
			var line = new CHBox().addTo(_main);
			
			{
				var column = new CVBox().addTo(line);
				column.add(new CLabel().setText("MInputField (multiline=true, height=80)"));
				
				var field = new MInputField().addTo(column);
				field.multiline = true;
				field.height = 80;
				field.text = "Some\ntext";
			}
			
			line.add(new MSeparator(false)).setPercents(-1, 100);
			
			{
				var column = new CVBox().addTo(line);
				column.add(
					new CLabel().setText("MInputField (multiline=true, height=80, width=200"));
				
				var field = new MInputField().addTo(column);
				field.multiline = true;
				field.height = 80;
				field.width = 200;
				field.text = "Some\ntext";
			}
			
			line.add(new MSeparator(false)).setPercents(-1, 100);
			
			{
				var column = new CVBox().addTo(line);
				column.add(
					new CLabel().setHtmlText(
						"<font color='#0000ff'>CLabel</font> with " +
						"<font size='16'><b>HTML</b></font>\n" +
						"New <i>line</i>"));
				
				var label = new CLabel().setHtmlText(
					"CLabel, " +
					new CTextFormat("Tahoma", 14, 0x0000ff).toHtml("HTML") + " by format");
				column.add(label);
			}
		}
		
		//drawBoxChildsBounds(_main);
	}
	
	var _main:CVBox;
	
	var _field:CInputField;
	var _label:CLabel;
	
	function onFieldChange(event:Event = null)
	{
		_label.text = "Text of field: " + _field.text;
		LayoutUtil.invalidateContainers(_label);
	}
	
	function onSetAnotherTextClick(event:Event)
	{
		_field.text = "Another text";
	}
	
	var _correctCheckedField:CInputField;
	
	function onCorrectCheckedFieldChange(event:Event = null)
	{
		var text = _correctCheckedField.text;
		_correctCheckedField.isCorrect = text != null && text.length >= 5;
	}
	
	function drawBoxChildsBounds(box:ACLineBox)
	{
		box.validate();// Don't needed to call it in normal case
		
		var g = box.graphics;
		g.clear();
		g.lineStyle(0, 0xff0000);
		for (i in 0 ... box.numChildren)
		{
			var child = box.getChildAt(i);
			g.drawRect(child.x, child.y, child.width, child.height);
		}
	}
	
	function newInputField()
	{
		var input = new CInputField(new MFieldRectSkin());
		return input;
	}
}