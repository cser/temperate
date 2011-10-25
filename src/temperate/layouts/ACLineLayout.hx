package temperate.layouts;
import temperate.layouts.parametrization.CChildWrapper;

class ACLineLayout extends ACLayout, implements ICLineLayout
{
	function new()
	{
		super();
		_components = [];
	}
	
	var _components:Array<CChildWrapper>;
	
	public function add(component:CChildWrapper)
	{
		_components.push(component);
	}
	
	public function remove(component:CChildWrapper)
	{
		_components.remove(component);
	}
	
	public function addAt(component:CChildWrapper, index:Int)
	{
		_components.insert(index, component);
	}
	
	public override function iterator()
	{
		return _components.iterator();
	}
}