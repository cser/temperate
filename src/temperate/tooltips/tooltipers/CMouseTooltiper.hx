package temperate.tooltips.tooltipers;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.geom.Rectangle;
import temperate.tooltips.CTooltipOwner;
import temperate.tooltips.managers.ICTooltipManager;
import temperate.tooltips.renderers.ICTooltip;

class CMouseTooltiper extends ACForcedTooltiper<CMouseTooltiper>
{
	public function new(owner:CTooltipOwner, manager:ICTooltipManager) 
	{
		super(this, owner, manager);
		
		_mouseRectLeft = 8;
		_mouseRectRight = 8;
		_mouseRectTop = 8;
		_mouseRectBottom = 18;
	}
	
	public function showClass<T>(tooltipClass:Class<ICTooltip<T>>, data:T)
	{
		_tooltipClass = tooltipClass;
		_newTooltip = null;
		
		_data = data;
		
		_manager.show(this);
	}
	
	public function showMethod<T>(newTooltip:Void->ICTooltip<T>, data:T)
	{
		_tooltipClass = null;
		_newTooltip = newTooltip;
		
		_data = data;
		
		_manager.show(this);
	}
	
	override function subscribeForRenderer()
	{
		_owner.container.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	override function unsubscribeForRenderer()
	{
		_owner.container.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	var _mouseRectLeft:Int;
	var _mouseRectRight:Int;
	var _mouseRectTop:Int;
	var _mouseRectBottom:Int;
	
	public function setMouseRect(left:Int, right:Int, top:Int, bottom:Int)
	{
		_mouseRectLeft = left;
		_mouseRectRight = right;
		_mouseRectTop = top;
		_mouseRectBottom = bottom;
		return this;
	}
	
	function onEnterFrame(event:Event = null)
	{
		arrange();
	}
	
	var _mouseRect:Rectangle;
	
	function getTargetRect(target:DisplayObject)
	{
		return target.getRect(_owner.container);
	}
	
	override function arrange()
	{
		if (_mouseRect == null)
		{
			_mouseRect = new Rectangle();
		}
		_mouseRect.x = _owner.container.mouseX - _mouseRectLeft;
		_mouseRect.y = _owner.container.mouseY - _mouseRectTop;
		_mouseRect.width = _mouseRectRight + _mouseRectLeft;
		_mouseRect.height = _mouseRectTop + _mouseRectBottom;
		
		_owner.arrange(_dock, _mouseRect, _rendererWidth, _rendererHeight);
		var x = _owner.rendererX;
		var y = _owner.rendererY;
		var geom = new Rectangle(
			_mouseRect.x - x,
			_mouseRect.y - y,
			_mouseRect.width,
			_mouseRect.height
		);
		_animator.arrange(x, y, _rendererWidth, _rendererHeight, geom);
	}
}