package windowApplication.states;
import windowApplication.assets.Rect;
import windowApplication.Primitive;

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
		topLineStyle();
		_topGraphics.drawRect(_x, _y, _image.mouseX - _x, _image.mouseY - _y);
	}
	
	override function doComplete()
	{
		_topGraphics.clear();
		lineStyle();
		var width = _image.mouseX - _x;
		var height = _image.mouseY - _y;
		_graphics.drawRect(_x, _y, width, height);
		_primitives.push(RECT(_x, _y, width, height));
	}
}