package temperate.tooltips.managers;
import temperate.tooltips.tooltipers.ICTooltiper;

class CSimpleTooltipManager implements ICTooltipManager
{
	var _fast:Bool;
	
	public function new(fast:Bool = false) 
	{
		_fast = fast;
	}
	
	public function show(tooltiper:ICTooltiper)
	{
		tooltiper.internalShow(_fast);
	}
	
	public function hide(tooltiper:ICTooltiper)
	{
		tooltiper.internalHide(_fast);
	}
}