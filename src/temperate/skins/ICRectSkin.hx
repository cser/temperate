package temperate.skins;
import flash.display.DisplayObject;
import flash.display.Graphics;

interface ICRectSkin
{
	function link(
		addChildAt0:DisplayObject->Dynamic, removeChild:DisplayObject->Dynamic, graphics:Graphics
	):Void;
	
	function unlink():Void;
	
	function getFixedWidth():Float;
	
	function getFixedHeight():Float;
	
	var state:CSkinState;
	
	function setBounds(x:Int, y:Int, width:Int, height:Int):Void;
	
	function redraw():Void;
}