package temperate.components;
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;

interface ICButton implements IEventDispatcher
{
	var view(default, null):DisplayObject;
	
	/**
	 * isEnabled insteard of enabled couse confilct with SimpleButton enabled
	 */
	var isEnabled(get_isEnabled, set_isEnabled):Bool;
	
	var selected(get_selected, set_selected):Bool;
	
	/**
	 * For easear implementaion
	 * (HaXe getters/setters ideology is so stern to communicate with flashplayer9 API >_<)
	 */
	function setUseHandCursor(value:Bool):Void;
	
	function validate():Void;
}