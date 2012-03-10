package temperate.layouts;
import temperate.core.CMath;
import temperate.layouts.parametrization.CExcessSpaceMode;
import temperate.layouts.helpers.CLayoutAlgoritms;
import temperate.layouts.helpers.CSizeInfo;

class CVLayout extends ACLineLayout
{
	public function new() 
	{	
		super();
		excessSpaceMode = UNIFORM;
	}
	
	public override function arrange(offsetX:Int, offsetY:Int)
	{
		universalArrange(false, offsetX, offsetY);
	}
	
	inline function universalArrange(horizontal:Bool, offsetX:Int, offsetY:Int)
	{
		var gap = horizontal ? gapX : gapY;
		var gapSize = {
			var num = _components.length;
			num > 1 ? (num - 1) * gap : 0;
		}
		var isCompactA = horizontal ? isCompactWidth : isCompactHeight;
		var isCompactB = horizontal ? isCompactHeight : isCompactWidth;
		
		if (isCompactA)
		{
			_sizeA = 0;
		}
		else
		{
			_sizeA = horizontal ? width : height;
		}
		
		if (isCompactB)
		{
			_sizeB = 0;
		}
		else
		{
			_sizeB = horizontal ? height : width;
		}
		
		if (horizontal)
		{
			calculateA(horizontal, gap, gapSize);
			calculateB(horizontal);
		}
		else
		{
			calculateB(horizontal);
			calculateA(horizontal, gap, gapSize);
		}
		
		for (component in _components)
		{
			if (horizontal)
			{
				component.y = (_sizeB - component.getHeight()) * component.alignY;
			}
			else
			{
				component.x = (_sizeB - component.getWidth()) * component.alignX;
			}
			component.updatePosition(offsetX, offsetY);
		}
		
		width = horizontal ? _sizeA : _sizeB;
		height = horizontal ? _sizeB : _sizeA;
	}
	
	var _sizeA:Float;
	
	var _sizeB:Float;
	
	inline function calculateB(horizontal:Bool)
	{
		for (component in _components)
		{
			if (Math.isNaN(horizontal ? component.heightPortion : component.widthPortion))
			{
				var size = horizontal ? component.getHeight() : component.getWidth();
				if (size > _sizeB)
				{
					_sizeB = size;
				}
			}
		}
		
		var needResizeB = false;
		for (component in _components)
		{
			var portion = horizontal ? component.heightPortion : component.widthPortion;
			if (!Math.isNaN(portion))
			{
				if (horizontal)
				{
					component.setHeight(_sizeB * portion);
				}
				else
				{
					component.setWidth(_sizeB * portion);
				}
				var size = horizontal ? component.getHeight() : component.getWidth();
				if (size > _sizeB)
				{
					_sizeB = size;
					needResizeB = true;
				}
			}
		}
		
		if (needResizeB)
		{
			for (component in _components)
			{
				var portion = horizontal ? component.heightPortion : component.widthPortion;
				if (!Math.isNaN(portion))
				{
					if (horizontal)
					{
						component.setHeight(_sizeB * portion);
					}
					else
					{
						component.setWidth(_sizeB * portion);
					}
				}
			}
		}
	}
	
	inline function calculateA(horizontal:Bool, gap:Float, gapSize:Float)
	{
		var infos = [];
		var sumPortion = 0.;
		var sumScaled = CMath.max(_sizeA - gapSize, 0);
		var num = _components.length;
		for (i in 0 ... num)
		{
			var component = _components[i];
			var portion = horizontal ? component.widthPortion : component.heightPortion;
			if (!Math.isNaN(portion))
			{
				sumPortion += portion;
				
				var info = CSizeInfo.get();
				info.portion = portion;
				info.index = i;
				if (horizontal)
				{
					component.setWidth(_sizeA);
					info.max = component.getWidth();
					component.setWidth(0);
					info.min = component.getWidth();
				}
				else
				{
					component.setHeight(_sizeA);
					info.max = component.getHeight();
					component.setHeight(0);
					info.min = component.getHeight();
				}
				infos.push(info);
			}
			else
			{
				sumScaled -= horizontal ? component.getWidth() : component.getHeight();
			}
		}
		
		var space = CLayoutAlgoritms.distributeProportionally(sumScaled, sumPortion, infos);
		
		for (info in infos)
		{
			var component = _components[info.index];
			if (horizontal)
			{
				component.setWidth(info.size);
			}
			else
			{
				component.setHeight(info.size);
			}
			info.dispose();
		}
		
		var isUniform = false;
		var isCompact = false;
		var globalAlign = 0.;
		switch (excessSpaceMode)
		{
			case UNIFORM:
				isUniform = true;
			case INCREASE_GAPS:
				if (num > 1)
				{
					isCompact = true;
					gap = gap + space / (num - 1);
				}
			case COMPACT_CONTAINER:
				isCompact = true;
			case MOVE_TO_EDGES(align):
				globalAlign = align;
		}
		if (isUniform && space > .1)
		{
			if (num > 0)
			{
				var offset = 0.;
				var spaceI = space / num;
				for (component in _components)
				{
					var size;
					if (horizontal)
					{
						component.x = offset + spaceI * component.alignX;
						size = component.getWidth();
					}
					else
					{
						component.y = offset + spaceI * component.alignY;
						size = component.getHeight();
					}
					offset += size + gap + spaceI;
				}
				_sizeA = offset - gap;
			}
		}
		else
		{
			if (num > 0)
			{
				var offset = space * globalAlign;
				for (component in _components)
				{
					var size;
					if (horizontal)
					{
						component.x = offset;
						size = component.getWidth();
					}
					else
					{
						component.y = offset;
						size = component.getHeight();
					}
					offset += size + gap;
				}
				_sizeA = isCompact
					? offset - gap
					: offset - gap + space * (1 - globalAlign);
			}
		}
		if (_sizeA < 0)
		{
			_sizeA = 0;
		}
	}
	
	public var excessSpaceMode:CExcessSpaceMode;
}