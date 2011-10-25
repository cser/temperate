package temperate.collections;

interface ICValueSwitcher< T >
{
	function on():Void;
	
	function off():Void;
	
	var value(default, set_value):T;
	
	function setValue(value:T):ICValueSwitcher<T>;
}