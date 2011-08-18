package temperate.layouts;
import temperate.layouts.parametrization.ChildWrapper;

interface ILineLayout implements ILayout
{
	function add(component:ChildWrapper):Void;
	
	function remove(component:ChildWrapper):Void;
	
	function addAt(component:ChildWrapper, index:Int):Void;
}