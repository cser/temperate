package temperate.skins;
import flash.display.DisplayObject;
import flash.display.Sprite;

interface ICWindowSkin 
{
	var view(default, null):DisplayObject;
	
	function link(container:Sprite):Void;
	
	var isLocked(get_isLocked, set_isLocked):Bool;
	
	var isActive(get_isActive, set_isActive):Bool;
	
	var title(get_title, set_title):String;
}