package windowApplication.states;
import windowApplication.assets.Rect;

class RectDrawState extends ADrawState
{
	public function new() 
	{
		super();
		
		icon = Rect;
	}
	
	var _x:Float;
	var _y:Float;
	
	override function doStart()
	{
		_x = _image.mouseX;
		_y = _image.mouseY;
	}
	
	override function doMove()
	{
		_topGraphics.clear();
		_topGraphics.lineStyle(0x000000);
		_topGraphics.drawRect(_x, _y, _image.mouseX - _x, _image.mouseY - _y);
	}
	
	override function doComplete()
	{
		_topGraphics.clear();
		_graphics.lineStyle(0x000000);
		_graphics.drawRect(_x, _y, _image.mouseX - _x, _image.mouseY - _y);
	}
}