package temperate.debug;
import flash.events.Event;
import flash.text.TextField;

class DebugMonitor extends FPSMonitor
{
	public function new(width:Int = 200, height:Int = 100) 
	{
		super(width, height);
		_bitmaps = [];
	}
	
	var _bitmaps:Array<PlotBitmap>;
	
	public function addPlotBitmap():PlotBitmap
	{
		var bitmapHeight = _height - FPSMonitor.TEXT_HEIGHT * 2;
		var bitmap = new PlotBitmap(_width, bitmapHeight, bitmapHeight);
		bitmap.y = FPSMonitor.TEXT_HEIGHT;
		bitmap.onTextChange = onTextChange;
		_bitmaps.push(bitmap);
		addChild(bitmap);
		return bitmap;
	}
	
	override function onEnterFrame(event:Event)
	{
		super.onEnterFrame(event);
		for (bitmap in _bitmaps)
		{
			bitmap.scroll();
		}
	}
	
	function onTextChange(plot:PlotBitmap, tf:TextField)
	{
		if (tf.parent != this)
		{
			addChild(tf);
		}
		tf.x = (_width - tf.width) * plot.textAlignX;
		tf.y = (_height - tf.height) * plot.textAlignY;
	}
}