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
		_graphics.moveTo(_image.mouseX, _image.mouseY);
	}
	
	override function doMove()
	{
		_graphics.lineTo(_image.mouseX, _image.mouseY);
	}
	
	override function doComplete()
	{
	}
}