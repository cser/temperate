package temperate.windows;
import flash.display.DisplayObjectContainer;
import flash.errors.ArgumentError;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.TypedDictionary;
import temperate.core.ICArea;
import temperate.core.ArrayUtil;
import temperate.windows.animators.CNullPopUpAnimator;
import temperate.windows.animators.ICPopUpAnimator;
using temperate.core.ArrayUtil;

class CPopUpManager extends EventDispatcher, implements ICArea
{	
	public function new(container:DisplayObjectContainer) 
	{
		super();
		
		this.container = container;
		
		areaX = 0;
		areaY = 0;
		areaWidth = 100;
		areaHeight = 100;
		_popUps = [];
		_isModal = new TypedDictionary();
		modal = false;
		updateOnMove = false;
		_defaultAnimator = new CNullPopUpAnimator();
	}
	
	public var updateOnMove:Bool;
	
	public var container(default, null):DisplayObjectContainer;
	
	public var areaX(default, null):Int;
	
	public var areaY(default, null):Int;
	
	public var areaWidth(default, null):Int;
	
	public var areaHeight(default, null):Int;
	
	public function setArea(x:Int, y:Int, width:Int, height:Int)
	{
		if (areaX != x || areaY != y || areaWidth != width || areaHeight != height)
		{
			areaX = x;
			areaY = y;
			areaWidth = width;
			areaHeight = height;
			for (popUp in _popUps)
			{
				var dispatcher = popUp.innerDispatcher;
				if (dispatcher.hasEventListener(Event.RESIZE))
				{
					dispatcher.dispatchEvent(new Event(Event.RESIZE));
				}
			}
		}
	}
	
	var _popUps:Array<ICPopUp>;
	var _isModal:TypedDictionary<ICPopUp, Bool>;
	
	public function add(popUp:ICPopUp, modal:Bool, fast:Bool = false)
	{
		container.addChild(popUp.view);
		_popUps.remove(popUp);
		_popUps.push(popUp);
		_isModal.set(popUp, modal);
		updateModal();
		
		var animator = getAnimator(popUp);
		animator.setPopUp(popUp);
		animator.initBeforeShow();
		animator.show(fast);
	}
	
	public function moveToTop(popUp:ICPopUp)
	{
		if (!_popUps.exists(popUp))
		{
			throw new ArgumentError("Missing popUp: " + popUp);
		}
		_popUps.remove(popUp);
		_popUps.push(popUp);
		container.setChildIndex(popUp.view, container.numChildren - 1);
		updateModal();
	}
	
	public function remove(popUp:ICPopUp, fast:Bool = false)
	{
		if (_popUps.remove(popUp))
		{
			_isModal.delete(popUp);
			updateModal();
			var animator = getAnimator(popUp);
			animator.setPopUp(popUp);
			animator.onHideComplete = onAnimatorHideComplete;
			animator.hide(fast);
		}
	}
	
	function onAnimatorHideComplete(animator:ICPopUpAnimator)
	{
		container.removeChild(animator.popUp.view);
	}
	
	function updateModal()
	{
		var length = _popUps.length;
		var i = length;
		var newModal = false;
		while (i-- > 0)
		{
			var popUp = _popUps[i];
			popUp.isActive = i == length - 1;
			popUp.isLocked = newModal;
			newModal = newModal || _isModal.get(popUp);
		}
		if (modal != newModal)
		{
			modal = newModal;
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
	
	public var modal(default, null):Bool;
	
	var _defaultAnimator:ICPopUpAnimator;
	
	function getAnimator(popUp:ICPopUp)
	{
		var animator = popUp.animator;
		if (animator == null)
		{
			animator = _animator;
			if (animator == null)
			{
				animator = _defaultAnimator;
			}
		}
		return animator;
	}
	
	public var animator(get_animator, set_animator):ICPopUpAnimator;
	var _animator:ICPopUpAnimator;
	function get_animator()
	{
		return _animator;
	}
	function set_animator(value)
	{
		_animator = value;
		return _animator;
	}
}