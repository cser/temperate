package temperate.minimal;
import flash.filters.ColorMatrixFilter;

class MFilterFactory 
{
	public static var LIGHT = [ new ColorMatrixFilter([
		1.1, 0, 0, 0, 0,
		0, 1.1, 0, 0, 0,
		0, 0, 1, 0, 0,
		0, 0, 0, 1, 0,
	]) ];
	
	public static var LIGHT_HARD = [ new ColorMatrixFilter([
		1.05, 0, 0, 0, 30,
		0, 1.05, 0, 0, 30,
		0, 0, 1, 0, 10,
		0, 0, 0, 1, 0,
	]) ];
	
	public static var GRAYED = [ new ColorMatrixFilter([
		.4, .2, .2, 0, 0,
		.2, .4, .2, 0, 0,
		.2, .2, .4, 0, 0,
		0, 0, 0, 1, 0,
	]) ];
}