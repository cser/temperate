package temperate.skins;
import flash.display.DisplayObject;
import flash.display.Graphics;

interface ICScrollSkin 
{
	function link(
		horizontal:Bool, addChildAt0:DisplayObject->Dynamic, removeChild:DisplayObject->Dynamic,
		graphics:Graphics
	):Void;
	
	function unlink():Void;
	
	function setSize(scrollLeft:Int, scrollSize:Int, size:Int):Void;
	
	function redrawUp():Void;
	
	function redrawDown(isLeft:Bool, thumbCenter:Int):Void;
}