package windowApplication.states;
import windowApplication.assets.Ellipse;

class EllipseDrawState extends ADrawState
{
	public function new() 
	{
		super();
		
		icon = Ellipse;
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
		_topGraphics.drawEllipse(_x, _y, _image.mouseX - _x, _image.mouseY - _y);
	}
	
	override function doComplete()
	{
		_topGraphics.clear();
		_graphics.lineStyle(0x000000);
		_graphics.drawEllipse(_x, _y, _image.mouseX - _x, _image.mouseY - _y);
	}
}