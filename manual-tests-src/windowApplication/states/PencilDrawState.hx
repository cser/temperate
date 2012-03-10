package windowApplication.states;
import windowApplication.BdFactory;

class PencilDrawState extends ADrawState
{
	public function new() 
	{
		super();
		
		icon = BdFactory.getPencil();
	}
	
	override function doStart()
	{
		lineStyle();
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