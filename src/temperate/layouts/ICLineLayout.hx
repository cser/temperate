package temperate.layouts;
import temperate.layouts.parametrization.CChildWrapper;

interface ICLineLayout implements ICLayout
{
	function add(component:CChildWrapper):Void;
	
	function remove(component:CChildWrapper):Void;
	
	function addAt(component:CChildWrapper, index:Int):Void;
}