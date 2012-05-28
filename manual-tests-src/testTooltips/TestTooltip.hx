package testTooltips;
import flash.geom.Rectangle;
import flash.text.TextField;
import temperate.minimal.MFormatFactory;
import temperate.minimal.MTween;
import temperate.minimal.renderers.MTooltipBg;
import temperate.tooltips.renderers.ACTooltip;

class TestTooltip extends ACTooltip<String>
{
	var _bg:MTooltipBg;
	var _tf:TextField;
	
	public function new() 
	{
		super();
		
		_bg = new MTooltipBg();
		addChild(_bg);
		
		_tf = MFormatFactory.LABEL.newAutoSized();
		addChild(_tf);
	}
	
	var _data:String;
	
	override public function initData(data:String):Void
	{
		_data = data;
		
		_tf.text = _data;
		_tf.x = 5;
		_tf.y = 5;
		_width = _tf.width + 10;
		_height = _tf.height + 10;
		
		dispatchResize(Std.int(_width), Std.int(_height));
	}
	
	override public function setTailTarget(target:Rectangle):Void
	{
		_bg.redraw(_width, _height, target);
	}
}