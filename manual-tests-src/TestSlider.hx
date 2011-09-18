package ;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import helpers.Scaler;
import temperate.components.CSlider;
import temperate.containers.CHBox;
import temperate.containers.CVBox;
import temperate.minimal.graphics.MLineBdFactory;
import temperate.minimal.graphics.MScrollBarBdFactory;
import temperate.minimal.MButton;
import temperate.minimal.MLabel;
import temperate.minimal.MScrollBar;
import temperate.minimal.MSeparator;
import temperate.minimal.MSlider;
import temperate.minimal.MTooltipFactory;
import temperate.minimal.skins.MFieldRectSkin;

class TestSlider extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init()
	{
		var main = new CVBox().addTo(this, 10, 10);
		
		var thumb = new MButton().setText("::-::");
		var slider = new CSlider(true, thumb, new MFieldRectSkin());
		main.add(slider);
		
		var thumb = new MButton().setText("::\n|\n::");
		var slider = new CSlider(false, thumb, new MFieldRectSkin());
		main.add(slider);
		
		var scrollBar = new MScrollBar(true).addTo(main);
		scrollBar.value = 20;
		MTooltipFactory.newText(scrollBar, "It here just for skin comarision");
		
		main.add(new MSeparator(true)).setPercents(100);
		
		{
			var line = new CHBox().addTo(main);
			line.add(new Bitmap(MLineBdFactory.getHBg()));
			line.add(new Bitmap(MLineBdFactory.getVBg()));
			
			var line = new CHBox().addTo(main);
			line.add(new Bitmap(MScrollBarBdFactory.getSliderHThumbUp()));
			line.add(new Bitmap(MScrollBarBdFactory.getSliderHThumbOver()));
			line.add(new Bitmap(MScrollBarBdFactory.getSliderHThumbDown()));
			line.add(new Bitmap(MScrollBarBdFactory.getSliderHThumbDisabled()));
			
			var line = new CHBox().addTo(main);
			line.add(new Bitmap(MScrollBarBdFactory.getSliderVThumbUp()));
			line.add(new Bitmap(MScrollBarBdFactory.getSliderVThumbOver()));
			line.add(new Bitmap(MScrollBarBdFactory.getSliderVThumbDown()));
			line.add(new Bitmap(MScrollBarBdFactory.getSliderVThumbDisabled()));
		}
		
		main.add(new MSeparator(true)).setPercents(100);
		
		{
			var line = new CHBox().addTo(main);
			var column = new CVBox().addTo(line);
			new MSlider(true).addTo(column);
			new MSlider(true).addTo(column).value = 10;
			new MSlider(true).addTo(column).value = 20;
			new MSlider(true).addTo(column).value = 50;
			new MSlider(true).addTo(column).value = 100;
			new MSlider(false).addTo(line);
			new MSlider(false).addTo(line).value = 10;
			new MSlider(false).addTo(line).value = 20;
			new MSlider(false).addTo(line).value = 50;
			new MSlider(false).addTo(line).value = 100;
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("value = 50").addTo(column);
			new MSlider(true).addTo(column).value = 50;
			new MSlider(false).addTo(column).value = 50;
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("updateOnMove = true").addTo(column);
			new MSlider(true).addTo(column).updateOnMove = true;
			new MSlider(false).addTo(column).updateOnMove = true;
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("useHandCursor = true").addTo(column);
			new MSlider(true).addTo(column).useHandCursor = true;
			new MSlider(false).addTo(column).useHandCursor = true;
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("enabled = false, value = 50").addTo(column);
			var slider = new MSlider(true).addTo(column);
			slider.enabled = false;
			slider.value = 50;
			var slider = new MSlider(false).addTo(column);
			slider.enabled = false;
			slider.value = 50;
		}
		
		main.add(new MSeparator(true)).setPercents(100);
		
		{
			var line = new CHBox().addTo(main);
			line.add(new Scaler(new MSlider(true)));
			line.add(new Scaler(new MSlider(false)));
			
			line.add(new TestSliderEventsBlock(true));
			line.add(new TestSliderEventsBlock(false));
			
			line.add(new TestSliderStepEventsBlock(true));
			line.add(new TestSliderStepEventsBlock(false));
			
			var column = new CVBox().addTo(line);
			new MLabel().setText("Compact").addTo(column);
			new MSlider(true).addTo(column).setCompact(true, true);
			new MSlider(false).addTo(column).setCompact(true, true);
		}
	}
}
class TestSliderEventsBlock extends CVBox
{
	var _slider:MSlider;
	var _changeLabel:MLabel;
	var _completeLabel:MLabel;
	
	public function new(horizontal:Bool)
	{
		super();
		
		_slider = new MSlider(horizontal);
		_slider.addEventListener(Event.CHANGE, onChange);
		_slider.addEventListener(Event.COMPLETE, onComplete);
		add(_slider);
		
		_changeLabel = new MLabel();
		_changeLabel.width = 100;
		add(_changeLabel);
		onChange();
		
		_completeLabel = new MLabel();
		_completeLabel.width = 100;
		add(_completeLabel);
		onComplete();
	}
	
	function onChange(event:Event = null)
	{
		_changeLabel.text = "CHANGE: " + _slider.value;
	}
	
	function onComplete(event:Event = null)
	{
		_completeLabel.text = "COMPLETE: " + _slider.value;
	}
}
class TestSliderStepEventsBlock extends CVBox
{
	var _slider:MSlider;
	var _changeLabel:MLabel;
	var _completeLabel:MLabel;
	
	public function new(horizontal:Bool)
	{
		super();
		
		_slider = new MSlider(horizontal);
		_slider.setSize(150, 150);
		_slider.addEventListener(Event.CHANGE, onChange);
		_slider.addEventListener(Event.COMPLETE, onComplete);
		_slider.minValue = 0;
		_slider.maxValue = 1;
		_slider.value = .5;
		_slider.step = .1;
		add(_slider);
		
		_changeLabel = new MLabel();
		_changeLabel.width = 100;
		add(_changeLabel);
		onChange();
		
		_completeLabel = new MLabel();
		_completeLabel.width = 100;
		add(_completeLabel);
		onComplete();
	}
	
	function onChange(event:Event = null)
	{
		_changeLabel.text = "CHANGE: " + _slider.value;
	}
	
	function onComplete(event:Event = null)
	{
		_completeLabel.text = "COMPLETE: " + _slider.value;
	}
}