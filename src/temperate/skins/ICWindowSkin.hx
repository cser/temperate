package temperate.skins;
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.Sprite;

interface ICWindowSkin 
{
	var view(default, null):DisplayObject;
	
	var head(default, null):InteractiveObject;
	
	var headHeight(get_headHeight, null):Float;
	
	function link(container:Sprite):Void;
	
	var isLocked(get_isLocked, set_isLocked):Bool;
	
	var isActive(get_isActive, set_isActive):Bool;
	
	var title(get_title, set_title):String;
}