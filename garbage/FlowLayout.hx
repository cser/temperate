package temperate.layouts;

class FlowLayout extends ALineLayout
{
	public function new() 
	{
		super();
	}
	
	public override function arrange()
	{
		var gapX = _gapX;
		var gapY = _gapY;
		
		var proxyWidth = width + gapX;
		
		for (component in _components)
		{
			if (Math.isNaN(component.widthPortion) || Math.isNaN(component.heightPortion))
			{
				disableComponent(component);
			}
			if (Math.isNaN(component.widthPortion))
			{
				if (component.width + gapX > proxyWidth)
				{
					proxyWidth = component.width + gapX;
				}
			}
			else
			{
				component.width = proxyWidth * component.widthPortion - gapX;
				var newProxyWidth = component.width + gapX;
				if (newProxyWidth > proxyWidth)
				{
					proxyWidth = newProxyWidth;
				}
			}
		}
		
		var length = _components.length;
		var numLines = 0.;
		
		var offsetY = 0.;
		var offsetX = 0.;
		var lineHeight = 0.;
		var lineIndex = 0;
		for (i in 0 ... length)
		{
			var component = _components[i];
			component.x = offsetX;
			
			if (Math.isNaN(component.heightPortion))
			{
				if (component.height > lineHeight)
				{
					lineHeight = component.height;
				}
			}
			
			offsetX += component.width + gapX;
			if (i == length - 1 || offsetX + _components[i + 1].width + gapX > proxyWidth + .1)
			{
				numLines++;
				
				var heightChanged = false;
				for (j in lineIndex ... i + 1)
				{
					var component = _components[j];
					if (!Math.isNaN(component.heightPortion))
					{
						component.height = lineHeight * component.heightPortion;
						if (component.height > lineHeight + .1)
						{
							lineHeight = component.height;
							heightChanged = true;
						}
					}
				}
				
				for (j in lineIndex ... i + 1)
				{
					var component = _components[j];
					if (!Math.isNaN(component.heightPortion) && heightChanged)
					{
						component.height = lineHeight * component.heightPortion;
					}
					component.y = offsetY + (lineHeight - component.height) * component.alignY;
				}
				
				offsetX = 0;
				offsetY += lineHeight + gapY;
				lineHeight = 0;
				lineIndex = i + 1;
			}
			
			if (Math.isNaN(component.widthPortion) || Math.isNaN(component.heightPortion))
			{
				enableComponent(component);
			}
		}
		
		width = proxyWidth - gapX;
		var minHeight = offsetY;
		if (numLines > 1)
		{
			minHeight -= gapY;
		}
		if (height < minHeight || _autoSize)
		{
			height = minHeight;
		}
	}
}