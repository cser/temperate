package temperate.windows;
import flash.display.DisplayObjectContainer;
import flash.errors.ArgumentError;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.TypedDictionary;
import temperate.core.ICArea;

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
	}
	
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
	
	public function add(popUp:ICPopUp, modal:Bool)
	{
		container.addChild(popUp.view);
		_popUps.remove(popUp);
		_popUps.push(popUp);
		_isModal.set(popUp, modal);
		updateModal();
	}
	
	public function moveToTop(popUp:ICPopUp)
	{
		var exists = false;
		for (popUpI in _popUps)
		{
			if (popUpI == popUp)
			{
				exists = true;
				break;
			}
		}
		if (!exists)
		{
			throw new ArgumentError("Missing popUp: " + popUp);
		}
		_popUps.remove(popUp);
		_popUps.push(popUp);
		container.setChildIndex(popUp.view, container.numChildren - 1);
		updateModal();
	}
	
	public function remove(popUp:ICPopUp)
	{
		if (_popUps.remove(popUp))
		{
			_isModal.delete(popUp);
			container.removeChild(popUp.view);
			updateModal();
		}
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
}