package temperate.tooltips.docks;
import flash.geom.Rectangle;

interface ICTooltipDock
{
	function arrange(
		target:Rectangle, ownerWidth:Int, ownerHeight:Int, rendererWidth:Int, rendererHeight:Int
	):Void;
	
	var rendererX(default, null):Int;
	
	var rendererY(default, null):Int;
}