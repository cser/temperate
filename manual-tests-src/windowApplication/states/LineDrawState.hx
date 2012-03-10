package windowApplication.states;
import windowApplication.BdFactory;

class LineDrawState extends ADrawState
{
	public function new() 
	{
		super();
		
		icon = BdFactory.getLine();
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
		_topGraphics.moveTo(_x, _y);
		_topGraphics.lineTo(_image.mouseX, _image.mouseY);
	}
	
	override function doComplete()
	{
		_topGraphics.clear();
		lineStyle();
		moveTo(_x, _y);
		lineTo(_image.mouseX, _image.mouseY);
	}
}