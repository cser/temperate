package temperate.windows;
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;
import temperate.windows.animators.ICPopUpAnimator;

interface ICPopUp
{
	var view(default, null):DisplayObject;
	
	var innerDispatcher(default, null):IEventDispatcher;
	
	var isLocked(get_isLocked, set_isLocked):Bool;
	
	var isActive(get_isActive, set_isActive):Bool;
	
	var animator(get_animator, set_animator):ICPopUpAnimator;
}