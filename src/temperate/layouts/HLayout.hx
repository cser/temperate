package temperate.layouts;

class HLayout extends VLayout
{
	public function new() 
	{
		super();
	}
	
	public override function arrange(offsetX:Int, offsetY:Int)
	{
		universalArrange(true, offsetX, offsetY);
	}
}