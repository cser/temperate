package temperate.layouts;

class CanvasLayout extends ALineLayout
{
	public function new() 
	{
		super();
	}
	
	public override function arrange()
	{
		if (_autoSize)
		{
			width = 0;
			height = 0;
		}
		
		// Disable of listeners
		
		for (component in _components)
		{
			if (!Math.isNaN(component.heightPortion) || !Math.isNaN(component.widthPortion))
			{
				disableComponent(component);
			}
		}
		
		// Scale by X
		
		for (component in _components)
		{
			if (!Math.isNaN(component.widthPortion))
			{
				component.width = 0;
			}
			var size = component.x + component.width;
			if (size > width)
			{
				width = size;
			}
		}
		
		for (component in _components)
		{
			if (!Math.isNaN(component.widthPortion))
			{
				var size = component.widthPortion * width;
				if (component.x + size > width)
				{
					size = width - component.x;
				}
				component.width = size;
			}
		}
		
		// Scale by Y
		
		for (component in _components)
		{
			if (!Math.isNaN(component.heightPortion))
			{
				component.height = 0;
			}
			var size = component.y + component.height;
			if (size > height)
			{
				height = size;
			}
		}
		
		for (component in _components)
		{
			if (!Math.isNaN(component.heightPortion))
			{
				var size = component.heightPortion * height;
				if (component.x + size > height)
				{
					size = height - component.y;
				}
				component.height = size;
			}
		}
		
		// Listeners enable
		
		for (component in _components)
		{
			if (!Math.isNaN(component.heightPortion) || !Math.isNaN(component.widthPortion))
			{
				enableComponent(component);
			}
		}
	}
	
	public override function add(component:ILayoutable)
	{
		component.heraldMove.add(onComponentResize);
		super.add(component);
	}
	
	public override function remove(component:ILayoutable)
	{
		component.heraldMove.remove(onComponentResize);
		super.remove(component);
	}
	
	override function onComponentResize(component:ILayoutable)
	{
		if (
			!Math.isNaN(component.widthPortion) ||
			!Math.isNaN(component.heightPortion) ||
			component.x + component.width > width ||
			component.y + component.height > height
		)
		{
			heraldChange.dispatch(this);
		}
	}
	
	override function setGapX(value)
	{
		_gapX = value;
		return value;
	}
	
	override function setGapY(value)
	{
		_gapY = value;
		return value;
	}
}