package temperate.tooltips.renderers;
import flash.display.DisplayObject;
import flash.geom.Rectangle;

interface ICTooltip< T >
{
	var view(default, null):DisplayObject;
	
	function initData(data:T):Void;
	
	function subscribe():Void;
	
	function unsubscribe():Void;
	
	function setTailTarget(target:Rectangle):Void;
	
	function dispose():Void;
	
	public var onResize:Int->Int->Void;
}