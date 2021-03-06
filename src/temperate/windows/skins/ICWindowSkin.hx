package temperate.windows.skins;
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import temperate.layouts.parametrization.CChildWrapper;

interface ICWindowSkin 
{
	var view(default, null):DisplayObject;
	
	var head(default, null):InteractiveObject;
	
	var headHeight(get_headHeight, null):Float;
	
	function link(container:Sprite, wrapper:CChildWrapper):Void;
	
	function setMouseEnabled(value:Bool):Void;
	
	var isEnabled(get_isEnabled, set_isEnabled):Bool;
	
	var isActive(get_isActive, set_isActive):Bool;
	
	var title(get_title, set_title):String;
}