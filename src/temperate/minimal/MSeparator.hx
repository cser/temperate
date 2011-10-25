package temperate.minimal;
import flash.display.Shape;
import temperate.components.CSeparator;
import temperate.core.CMath;
import temperate.core.CSprite;

class MSeparator extends CSeparator
{
	public function new(horizontal:Bool)
	{
		super(horizontal);
		
		lightColor = 0xccffffff;
		shadowColor = 0xff808080;
	}
	
	public var lightColor:UInt;
	public var shadowColor:UInt;
	
	override function getLineWidth()
	{
		return 2;
	}
	
	override function redraw()
	{
		var g = graphics;
		g.clear();
		g.beginFill(CMath.colorPart(shadowColor), CMath.alphaPart(shadowColor));
		if (_horizontal)
		{
			g.drawRect(0, 0, _width, 1);
		}
		else
		{
			g.drawRect(0, 0, 1, _height);
		}
		g.endFill();
		g.beginFill(CMath.colorPart(lightColor), CMath.alphaPart(lightColor));
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