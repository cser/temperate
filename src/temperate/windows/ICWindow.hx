package temperate.windows;
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;

interface ICWindow
{
	var view(default, null):DisplayObject;
	
	var innerDispatcher(default, null):IEventDispatcher;
	
	var isEnabled(get_isEnabled, set_isEnabled):Bool;
	
	var isActive(get_isActive, set_isActive):Bool;
	
	var isOpened:Bool;
	
	var manager:CWindowManager;
	
	function animateShow(fast:Bool):Void;
	
	function animateHide(fast:Bool, onComplete:ICWindow->Void):Void;
}