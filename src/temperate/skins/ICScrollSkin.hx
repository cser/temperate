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
	
	var state:CScrollSkinState;
	
	function setSize(scrollLeft:Int, scrollSize:Int, size:Int):Void;
	
	function redraw():Void;
}