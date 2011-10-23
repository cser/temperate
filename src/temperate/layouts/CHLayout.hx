package temperate.layouts;

class CHLayout extends CVLayout
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