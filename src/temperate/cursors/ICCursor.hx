package temperate.cursors;
import flash.display.DisplayObject;
import flash.events.IEventDispatcher;

interface ICCursor 
{
	var view(default, null):DisplayObject;
	
	var updateOnMove(default, null):Bool;
	
	var viewOffsetX(default, null):Int;
	
	var viewOffsetY(default, null):Int;
	
	function subscribe(mouseEventSource:IEventDispatcher = null):Void;
	
	function unsubscribe(mouseEventSource:IEventDispatcher = null):Void;
}