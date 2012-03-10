package temperate.tooltips.managers;
import flash.utils.Timer;
import temperate.collections.CObjectHash;
import temperate.collections.CValueStack;
import temperate.collections.ICValueSwitcher;
import temperate.tooltips.managers.helpers.TooltiperProcessExecutor;
import temperate.tooltips.tooltipers.ICTooltiper;

class CTooltipManager implements ICTooltipManager
{
	var _executor:TooltiperProcessExecutor;
	var _stack:CValueStack<ICTooltiper>;
	var _switcherByTooltiper:CObjectHash<ICTooltiper, ICValueSwitcher<ICTooltiper>>;
	
	public function new() 
	{
		_stack = new CValueStack(onStackChange);
		_switcherByTooltiper = new CObjectHash();
		_executor = new TooltiperProcessExecutor(newTimer);
	}
	
	function newTimer()
	{
		return new Timer(1000, 1);
	}
	
	public function show(tooltiper:ICTooltiper)
	{
		var switcher = _switcherByTooltiper.get(tooltiper);
		if (switcher == null)
		{
			switcher = _stack.newSwitcher();
		}
		_switcherByTooltiper.set(tooltiper, switcher);
		switcher.value = tooltiper;
		switcher.on();
	}
	
	public function hide(tooltiper:ICTooltiper)
	{
		var switcher = _switcherByTooltiper.get(tooltiper);
		if (switcher != null)
		{
			_switcherByTooltiper.delete(tooltiper);
			switcher.off();
		}
	}
	
	var _tooltiper:ICTooltiper;
	
	function onStackChange()
	{
		if (_tooltiper != null)
		{
			_executor.hide(_tooltiper);
		}
		_tooltiper = _stack.value;
		if (_tooltiper != null)
		{
			_executor.show(_tooltiper);
		}
	}
	
	public function setDelays(showDelay:Int, secondShowDelay:Int, hideDelay:Int,
		secondShowTimeout:Int)
	{
		this.showDelay = showDelay;
		this.secondShowDelay = secondShowDelay;
		this.hideDelay = hideDelay;
		this.secondShowTimeout = secondShowTimeout;
		return this;
	}
	
	public var showDelay(get_showDelay, set_showDelay):Int;
	function get_showDelay()
	{
		return _executor.showDelay;
	}
	function set_showDelay(value)
	{
		_executor.showDelay = value;
		return value;
	}
	
	public var secondShowDelay(get_secondShowDelay, set_secondShowDelay):Int;
	function get_secondShowDelay()
	{
		return _executor.secondShowDelay;
	}
	function set_secondShowDelay(value)
	{
		_executor.secondShowDelay = value;
		return value;
	}
	
	public var hideDelay(get_hideDelay, set_hideDelay):Int;
	function get_hideDelay()
	{
		return _executor.hideDelay;
	}
	function set_hideDelay(value)
	{
		_executor.hideDelay = value;
		return value;
	}
	
	/**
	 * Time for second showing after tooltip hide
	 */
	public var secondShowTimeout(get_secondShowTimeout, set_secondShowTimeout):Int;
	function get_secondShowTimeout()
	{
		return _executor.secondShowTimeout;
	}
	function set_secondShowTimeout(value)
	{
		_executor.secondShowTimeout = value;
		return value;
	}
}