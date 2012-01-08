package temperate.components;

class CButtonState
{
	public static var UP = new CButtonState(false, true, "up");
	
	public static var OVER = new CButtonState(false, true, "over");
	
	public static var DOWN = new CButtonState(false, true, "down");
	
	public static var DISABLED = new CButtonState(false, false, "disabled");
	
	public static var UP_SELECTED = new CButtonState(true, true, "upSelected");
	
	public static var OVER_SELECTED = new CButtonState(true, true, "overSelected");
	
	public static var DOWN_SELECTED = new CButtonState(true, true, "downSelected");

	public static var DISABLED_SELECTED = new CButtonState(true, false, "disabledSelected");
	
	static var _currentIndex = 0;
	
	function new(selected:Bool, enabled:Bool, name:String)
	{
		index = _currentIndex++;
		this.selected = selected;
		this.enabled = enabled;
		_name = name;
	}
	
	public var index(default, null):Int;
	
	public var selected(default, null):Bool;
	
	public var enabled(default, null):Bool;
	
	var _name:String;
	
	public function toString():String
	{
		return "[CButtonState: " + _name + "]";
	}
	
	public static function selectStateNormal(
		isDown:Bool, isOver:Bool, selected:Bool, enabled:Bool
	):CButtonState
	{
		var state;
		if (enabled)
		{
			if (isDown && isOver)
			{
				state = selected ? DOWN_SELECTED : DOWN;
			}
			else if (isDown || isOver)
			{
				state = selected ? OVER_SELECTED : OVER;
			}
			else
			{
				state = selected ? UP_SELECTED : UP;
			}
		}
		else
		{
			state = selected ? DISABLED_SELECTED : DISABLED;
		}
		return state;
	}
	
	public static function selectStateThumb(
		isDown:Bool, isOver:Bool, selected:Bool, enabled:Bool
	):CButtonState
	{
		var state;
		if (enabled)
		{
			if (isDown)
			{
				state = selected ? DOWN_SELECTED : DOWN;
			}
			else if (isOver)
			{
				state = selected ? OVER_SELECTED : OVER;
			}
			else
			{
				state = selected ? UP_SELECTED : UP;
			}
		}
		else
		{
			state = selected ? DISABLED_SELECTED : DISABLED;
		}
		return state;
	}
}