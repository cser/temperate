package windowApplication.states;
import windowApplication.assets.Pencil;

class PencilDrawState extends ADrawState
{
	public function new() 
	{
		super();
		
		icon = Pencil;
	}
	
	override function doStart()
	{
		_graphics.lineStyle(0x000000);
		moveTo(_image.mouseX, _image.mouseY);
	}
	
	override function doMove()
	{
		lineTo(_image.mouseX, _image.mouseY);
	}
	
	override function doComplete()
	{
	}
}