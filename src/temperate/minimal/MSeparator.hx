package temperate.minimal;
import temperate.components.CSeparator;
using temperate.core.CMath;

class MSeparator extends CSeparator
{
	public function new(horizontal:Bool)
	{
		super(horizontal);
		
		lightColor = 0xccffffff;
		shadowColor = 0xff808080;
	}
	
	public var lightColor:Int;
	public var shadowColor:Int;
	
	override function getLineWidth()
	{
		return 2;
	}
	
	override function redraw()
	{
		var g = graphics;
		g.clear();
		g.beginFill(shadowColor.getColor(), shadowColor.getAlpha());
		if (_horizontal)
		{
			g.drawRect(0, 0, _width, 1);
		}
		else
		{
			g.drawRect(0, 0, 1, _height);
		}
		g.endFill();
		g.beginFill(lightColor.getColor(), lightColor.getAlpha());
		if (_horizontal)
		{
			g.drawRect(1, 1, _width, 1);
		}
		else
		{
			g.drawRect(1, 1, 1, _height);
		}
		g.endFill();
	}
}