package temperate.cursors;
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import temperate.collections.CValueStack;
import temperate.collections.ICValueSwitcher;

class CHoverSwitcher< T >
{
	public function new(stack:CValueStack<T>, priority:Int) 
	{
		_switcher = stack.newSwitcher(priority);
	}
	
	var _switcher:ICValueSwitcher<T>;
	
	public var value(default, set_value):T;
	function set_value(value)
	{
		return _switcher.value = value;
	}
	
	public function setValue(value:T)
	{
		this.value = value;
		return this;
	}
	
	public var target(get_target, set_target):DisplayObject;
	var _target:DisplayObject;
	function get_target()
	{
		return _target;
	}
	function set_target(value)
	{
		if (_target != value)
		{
			if (_target != null)
			{
				_target.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
				_target.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
			}
			_target = value;
			if (_target != null)
			{
				_target.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
				_target.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			}
		}
		return _target;
	}
	
	public function setTarget(target:DisplayObject)
	{
		this.target = target;
		return this;
	}
	
	function onRollOver(event:MouseEvent)
	{
		_switcher.on();
	}
	
	function onRollOut(event:MouseEvent)
	{
		_switcher.off();
	}
}