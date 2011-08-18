package temperate.tooltips.tooltipers;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import temperate.tooltips.animators.CNullTooltipAnimator;
import temperate.tooltips.animators.ICTooltipAnimator;
import temperate.tooltips.CTooltipOwner;
import temperate.tooltips.docks.CVTooltipDock;
import temperate.tooltips.docks.ICTooltipDock;
import temperate.tooltips.managers.ICTooltipManager;
import temperate.tooltips.renderers.ICTooltip;

class ACTargetTooltiper< TSelf, T > implements ICTooltiper
{
	var _self:TSelf;
	var _owner:CTooltipOwner;
	var _manager:ICTooltipManager;
	
	public function new(self:TSelf, owner:CTooltipOwner, manager:ICTooltipManager)
	{
		_self = self;
		_owner = owner;
		_manager = manager;
		
		_hideOnMouseDown = true;
		
		_nullAnimator = new CNullTooltipAnimator();
		_animator = _nullAnimator;
		
		_defaultDock = new CVTooltipDock();
		_dock = _defaultDock;
	}
	
	var _target:DisplayObject;
	
	public function setTarget(target:DisplayObject)
	{
		if (_target != target)
		{
			if (_target != null)
			{
				_target.removeEventListener(MouseEvent.ROLL_OVER, onTargetRollOver);
				_target.removeEventListener(MouseEvent.ROLL_OUT, onTargetRollOut);
				_target.removeEventListener(MouseEvent.MOUSE_DOWN, onTargetMouseDown);
			}
			_target = target;
			if (_target != null)
			{
				_target.addEventListener(MouseEvent.ROLL_OVER, onTargetRollOver);
				_target.addEventListener(MouseEvent.ROLL_OUT, onTargetRollOut);
				_target.addEventListener(MouseEvent.MOUSE_DOWN, onTargetMouseDown);
			}
		}
		return _self;
	}
	
	function onTargetRollOver(event:Event)
	{
		_manager.show(this);
	}
	
	function onTargetRollOut(event:Event)
	{
		_manager.hide(this);
	}
	
	function onTargetMouseDown(event:Event)
	{
		if (_hideOnMouseDown)
		{
			_manager.hide(this);
		}
	}
	
	var _hideOnMouseDown:Bool;
	
	public function setHideOnMouseDown(hideOnMouseDown:Bool)
	{
		_hideOnMouseDown = hideOnMouseDown;
		return _self;
	}
	
	var _nullAnimator:ICTooltipAnimator<T>;
	var _animator:ICTooltipAnimator<T>;
	
	public function setAnimator(animator:ICTooltipAnimator<T>)
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
	
	var _data:T;
	
	public function setData(data:T)
	{
		trace("setData: " + data);
		if (_data != data)
		{
			var tooltip = _animator.tooltip;
			if (_data != null && tooltip != null)
			{
				tooltip.unsubscribe();
			}
			_data = data;
			if (tooltip != null)
			{
				if (data != null)
				{
					tooltip.initData(_data);
					tooltip.subscribe();
					arrange();
				}
				else
				{
					_manager.hide(this);
				}
			}
		}
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
	
	function subscribeForRenderer()
	{
	}
	
	function unsubscribeForRenderer()
	{
	}
	
	var _rendererWidth:Int;
	var _rendererHeight:Int;
	
	function onRendererResize(width:Int, height:Int)
	{
		_rendererWidth = width;
		_rendererHeight = height;
	}
	
	function arrange()
	{
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
	
	//----------------------------------------------------------------------------------------------
	//
	//  Factory
	//
	//----------------------------------------------------------------------------------------------
	
	var _tooltipClass:Class<ICTooltip<T>>;
	
	public function setTooltipClass(tooltipClass:Class<ICTooltip<T>>)
	{
		_tooltipClass = tooltipClass;
		_tooltipMethod = null;
		return _self;
	}
	
	var _tooltipMethod:Void->ICTooltip<T>;
	
	public function setTooltipMethod(tooltipMethod:Void->ICTooltip<T>)
	{
		_tooltipMethod = tooltipMethod;
		_tooltipClass = null;
		return _self;
	}
	
	function newTooltip():ICTooltip<T>
	{
		return _tooltipClass != null ? Type.createInstance(_tooltipClass, []) : _tooltipMethod();
	}
}