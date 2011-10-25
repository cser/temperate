package temperate.raster;
import flash.display.BitmapData;
import flash.display.Graphics;

interface ICDrawer 
{
	public var graphics:Graphics;
	
	var x:Int;
	
	var y:Int;
	
	var width:Int;
	
	var height:Int;
	
	function setBounds(x:Int, y:Int, width:Int, height:Int):ICDrawer;
	
	var bitmapData(default, null):BitmapData;
	
	var bitmapWidth(default, null):Int;
	
	var bitmapHeight(default, null):Int;
	
	function setBitmapData(bitmapData:BitmapData):ICDrawer;
	
	function redraw():Void;
	
	function clear():Void;
}