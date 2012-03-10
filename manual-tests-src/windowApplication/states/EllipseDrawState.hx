package windowApplication.states;
import windowApplication.BdFactory;
import windowApplication.Primitive;

class EllipseDrawState extends ADrawState
{
	public function new() 
	{
		super();
		
		icon = BdFactory.getEllipse();
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
		_topGraphics.drawEllipse(_x, _y, _image.mouseX - _x, _image.mouseY - _y);
	}
	
	override function doComplete()
	{
		_topGraphics.clear();
		lineStyle();
		var width = _image.mouseX - _x;
		var height = _image.mouseY - _y;
		_graphics.drawEllipse(_x, _y, width, height);
		_primitives.push(ELLIPSE(_x, _y, width, height));
	}
}