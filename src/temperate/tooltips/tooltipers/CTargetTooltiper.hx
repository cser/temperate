package temperate.tooltips.tooltipers;
import flash.display.DisplayObject;
import flash.geom.Rectangle;
import temperate.tooltips.CTooltipOwner;
import temperate.tooltips.managers.ICTooltipManager;

class CTargetTooltiper< T > extends ACTargetTooltiper<CTargetTooltiper<T>, T>
{	
	public function new(owner:CTooltipOwner, manager:ICTooltipManager) 
	{
		super(this, owner, manager);
	}
	
	function getTargetRect(target:DisplayObject)
	{
		return target.getRect(_owner.container);
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