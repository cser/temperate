package temperate.raster;
import flash.display.BitmapData;
import flash.display.Graphics;

interface IDrawer 
{
	public var graphics:Graphics;
	
	var x:Int;
	
	var y:Int;
	
	var width:Int;
	
	var height:Int;
	
	function setBounds(x:Int, y:Int, width:Int, height:Int):IDrawer;
	
	var bitmapData(default, null):BitmapData;
	
	var bitmapWidth(default, null):Int;
	
	var bitmapHeight(default, null):Int;
	
	function setBitmapData(bitmapData:BitmapData):IDrawer;
	
	function redraw():Void;
	
	function clear():Void;
}