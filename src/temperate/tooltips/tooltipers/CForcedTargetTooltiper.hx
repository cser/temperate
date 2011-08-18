package temperate.tooltips.tooltipers;
import flash.display.DisplayObject;
import flash.geom.Rectangle;
import temperate.tooltips.CTooltipOwner;
import temperate.tooltips.managers.ICTooltipManager;
import temperate.tooltips.renderers.ICTooltip;

class CForcedTargetTooltiper extends ACForcedTooltiper<CForcedTargetTooltiper>
{
	public function new(owner:CTooltipOwner, manager:ICTooltipManager) 
	{
		super(this, owner, manager);
	}
	
	function getTargetRect(target:DisplayObject)
	{
		return target.getRect(_owner.container);
	}
	
	var _target:DisplayObject;
	
	public function showClass<T>(target:DisplayObject, tooltipClass:Class<ICTooltip<T>>, data:T)
	{
		_tooltipClass = tooltipClass;
		_newTooltip = null;
		
		_target = target;
		_data = data;
		
		_manager.show(this);
	}
	
	public function showMethod<T>(target:DisplayObject, newTooltip:Void->ICTooltip<T>, data:T)
	{
		_tooltipClass = null;
		_newTooltip = newTooltip;
		
		_target = target;
		_data = data;
		
		_manager.show(this);
	}
	
	override function arrange()
	{
		var target = getTargetRect(_target);
		_owner.arrange(_dock, target, _rendererWidth, _rendererHeight);
		var x = _owner.rendererX;
		var y = _owner.rendererY;
		var geom = new Rectangle(
			target.x - x,
			target.y - y,
			target.width,
			target.height
		);
		_animator.arrange(x, y, _rendererWidth, _rendererHeight, geom);
	}
}