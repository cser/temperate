package temperate.windows;
import flash.display.DisplayObject;

interface ICWindow 
{
	var isLocked(get_isLocked, set_isLocked):Bool;
	
	var isActive(get_isActive, set_isActive):Bool;
	
	var view(default, null):DisplayObject;
}