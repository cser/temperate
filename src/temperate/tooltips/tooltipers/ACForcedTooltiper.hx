package temperate.tooltips.tooltipers;
import flash.display.DisplayObject;
import temperate.tooltips.animators.CNullTooltipAnimator;
import temperate.tooltips.animators.ICTooltipAnimator;
import temperate.tooltips.CTooltipOwner;
import temperate.tooltips.docks.CVTooltipDock;
import temperate.tooltips.docks.ICTooltipDock;
import temperate.tooltips.managers.ICTooltipManager;
import temperate.tooltips.renderers.ICTooltip;

class ACForcedTooltiper<TSelf> implements ICTooltiper
{
	var _self:TSelf;
	var _owner:CTooltipOwner;
	var _manager:ICTooltipManager;
	
	public function new(self:TSelf, owner:CTooltipOwner, manager:ICTooltipManager)
	{
		_self = self;
		_owner = owner;
		_manager = manager;
		
		_nullAnimator = new CNullTooltipAnimator();
		_animator = _nullAnimator;
		
		_defaultDock = new CVTooltipDock();
		_dock = _defaultDock;
	}
	
	var _nullAnimator:ICTooltipAnimator<Dynamic>;
	var _animator:ICTooltipAnimator<Dynamic>;
	
	public function setAnimator(animator:ICTooltipAnimator<Dynamic>)
	{
		_animator = animator != null ? animator : _nullAnimator;
		return _self;
	}
	
	var _defaultDock:ICTooltipDock;
	var _dock:ICTooltipDock;
	
	public function setDock(value:ICTooltipDock)
	{
		_dock = value != null ? value : _defaultDock;
		return _self;
	}
	
	public function internalShow(fast:Bool)
	{
		if (_data == null)
		{
			return;
		}
		
		var tooltip = _animator.tooltip;
		if (tooltip == null)
		{
			tooltip = newTooltip();
			tooltip.onResize = onRendererResize;
			tooltip.initData(_data);
			tooltip.subscribe();
			_animator.setTooltip(tooltip);
			arrange();
			
			var view = tooltip.view;
			_owner.container.addChild(tooltip.view);
			_animator.initBeforeShow();
			_animator.show(fast);
		}
		else
		{
			arrange();
			_animator.show(fast);
		}
		subscribeForRenderer();
	}
	
	public function internalHide(fast:Bool)
	{
		var tooltip = _animator.tooltip;
		if (tooltip != null)
		{
			if (_data != null)
			{
				tooltip.unsubscribe();
			}
			_animator.onHideComplete = onHideComplete;
			_animator.hide(fast);
		}
	}
	
	function onHideComplete()
	{
		var tooltip = _animator.tooltip;
		if (tooltip != null)
		{
			_owner.container.removeChild(tooltip.view);
			tooltip.dispose();
			_animator.setTooltip(null);
		}
		unsubscribeForRenderer();
	}
	
	function subscribeForRenderer():Void
	{
		
	}
	
	function unsubscribeForRenderer():Void
	{
		
	}
	
	var _tooltipClass:Class<ICTooltip<Dynamic>>;
	var _newTooltip:Void->ICTooltip<Dynamic>;
	var _data:Dynamic;
	
	public function hide()
	{
		_manager.hide(this);
	}
	
	function arrange()
	{
	}
	
	function newTooltip()
	{
		return _tooltipClass != null ? Type.createInstance(_tooltipClass, []) : _newTooltip();
	}
	
	var _rendererWidth:Int;
	var _rendererHeight:Int;
	
	function onRendererResize(width:Int, height:Int)
	{
		_rendererWidth = width;
		_rendererHeight = height;
	}
	
	//----------------------------------------------------------------------------------------------
	//
	//  Delays
	//
	//----------------------------------------------------------------------------------------------
	
	public var showDelay:Null<Int>;
	
	public var secondShowDelay:Null<Int>;
	
	public var hideDelay:Null<Int>;
	
	public var secondShowTimeout:Null<Int>;
	
	public function setDelays(showDelay:Null<Int>, secondShowDelay:Null<Int>, hideDelay:Null<Int>,
		secondShowTimeout:Null<Int>)
	{
		this.showDelay = showDelay;
		this.secondShowDelay = secondShowDelay;
		this.hideDelay = hideDelay;
		this.secondShowTimeout = secondShowTimeout;
		return _self;
	}
}