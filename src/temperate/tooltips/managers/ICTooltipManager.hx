package temperate.tooltips.managers;
import temperate.tooltips.tooltipers.ICTooltiper;

interface ICTooltipManager 
{
	function show(tooltiper:ICTooltiper):Void;
	
	function hide(tooltiper:ICTooltiper):Void;
}