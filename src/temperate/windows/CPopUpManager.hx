package temperate.windows;
import flash.display.DisplayObjectContainer;
import flash.errors.ArgumentError;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;
import flash.utils.TypedDictionary;
import temperate.core.ICArea;
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
		popUp.manager = this;
		popUp.animateShow(fast);
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
			popUp.animateHide(fast, onAnimateCloseComplete);
			popUp.manager = null;
		}
	}
	
	function onAnimateCloseComplete(popUp:ICPopUp)
	{
		container.removeChild(popUp.view);
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
	
	public var keyboardDispatcher(get_keyboardDispatcher, set_keyboardDispatcher):IEventDispatcher;
	var _keyboardDispatcher:IEventDispatcher;
	function get_keyboardDispatcher()
	{
		return _keyboardDispatcher;
	}
	function set_keyboardDispatcher(value)
	{
		if (_keyboardDispatcher != null)
		{
			_keyboardDispatcher.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		_keyboardDispatcher = value;
		if (_keyboardDispatcher != null)
		{
			_keyboardDispatcher.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		return _keyboardDispatcher;
	}
	
	function onKeyDown(event:KeyboardEvent)
	{
		var length = _popUps.length;
		if (length > 0)
		{
			// Mast don't bubbles
			_popUps[length - 1].innerDispatcher.dispatchEvent(
				new KeyboardEvent(
					KeyboardEvent.KEY_DOWN, false, false, event.charCode, event.keyCode,
					event.keyLocation, event.ctrlKey, event.altKey, event.shiftKey));
		}
	}
}