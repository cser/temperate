package temperate.skins;
import flash.display.Sprite;

interface ICWindowSkin 
{
	function link(owner:Sprite, container:Sprite):Void;
	
	function validateSize(width:Int, height:Int):Void;
	
	var width(default, null):Int;
	
	var height(default, null):Int;
	
	function validateView():Void;
}