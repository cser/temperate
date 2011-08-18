package temperate.layouts;
import temperate.layouts.parametrization.ChildWrapper;

class ALineLayout extends ALayout, implements ILineLayout
{
	public function new()
	{
		super();
		_components = [];
	}
	
	var _components:Array<ChildWrapper>;
	
	public function add(component:ChildWrapper)
	{
		_components.push(component);
	}
	
	public function remove(component:ChildWrapper)
	{
		_components.remove(component);
	}
	
	public function addAt(component:ChildWrapper, index:Int)
	{
		_components.insert(index, component);
	}
	
	public override function iterator()
	{
		return _components.iterator();
	}
}