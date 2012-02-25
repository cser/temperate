package temperate.minimal;
import flash.geom.ColorTransform;

class MFilterFactory 
{
	public static var LIGHT = new ColorTransform(1.1, 1.1, 1.1, 1, 10, 10, 10, 0);
	
	public static var LIGHT_AMPLIFIED = new ColorTransform(1.2, 1.2, 1, 1, 20, 20, 20, 0);
	
	public static var GRAYED = new ColorTransform(.7, .7, .7, 1, 50, 50, 50, 0);
}