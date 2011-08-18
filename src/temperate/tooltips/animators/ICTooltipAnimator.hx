package temperate.tooltips.animators;
import flash.geom.Rectangle;
import temperate.tooltips.renderers.ICTooltip;

interface ICTooltipAnimator< T >
{
	function setTooltip(tooltip:ICTooltip<T>):Void;
	
	function arrange(x:Float, y:Float, width:Float, height:Float, target:Rectangle):Void;
	
	var tooltip:ICTooltip<T>;
	
	function initBeforeShow():Void;
	
	function show(fast:Bool):Void;
	
	function hide(fast:Bool):Void;
	
	var onHideComplete:Void->Void;
}