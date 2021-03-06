package ;
import flash.display.Sprite;
import flash.filters.GlowFilter;
import flash.geom.ColorTransform;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import temperate.minimal.MFormatFactory;
import temperate.text.CTextFormat;

class NmeTestText extends Sprite
{
	public function new() 
	{
		super();
	}
	
	public function init():Void
	{
		{
			var tf = MFormatFactory.LABEL.newAutoSized();
			tf.text = "LABEL-formated text";
			addChild(tf);
		}
		
		{
			var tf = new CTextFormat("Arial", 12, 0xffffff, true).setFilters([new GlowFilter()])
				.newAutoSized();
			tf.text = "TextField with CTextFormat";
			tf.y = 50;
			addChild(tf);
		}
		
		{
			var tf = new CTextFormat("Arial", 12, 0xff0080, true)
				.setAlpha(.5)
				.newAutoSized();
			tf.text = "TextField with CTextFormat alpha = .5";
			tf.x = 200;
			addChild(tf);
			
			var tf = new CTextFormat("Arial", 12, 0xff0080, true)
				.setColorTransform(new ColorTransform(0, 0, 2, .4, 0, 0, 0, 0))
				.newAutoSized();
			tf.text = "TextField with CTextFormat no alpha, colorTransform with alpha = .4";
			tf.x = 200;
			tf.y = 20;
			addChild(tf);
			
			var tf = new CTextFormat("Arial", 12, 0xff0080, true)
				.setAlpha(.5)
				.setColorTransform(new ColorTransform(0, 0, 2, .4, 0, 0, 0, 0))
				.newAutoSized();
			tf.text = "TextField with CTextFormat alpha = .5, colorTransform with alpha = .4";
			tf.x = 200;
			tf.y = 40;
			addChild(tf);
			
			var tf = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = "Apply format test (shakeAsPlainText = false)";
			tf.x = 10;
			tf.y = 300;
			addChild(tf);
			new CTextFormat("Arial", 12, 0xff0080, true).applyTo(tf);
			
			var tf = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = "Apply format test (shakeAsPlainText = true)";
			tf.x = 10;
			tf.y = 350;
			addChild(tf);
			new CTextFormat("Arial", 12, 0xff0080, true).applyTo(tf, true);
		}
	}
}