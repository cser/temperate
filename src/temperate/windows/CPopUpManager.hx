package temperate.windows;
import flash.display.DisplayObjectContainer;
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
		_popUps.push(popUp);
		_isModal.set(popUp, modal);
		updateModal();
	}
	
	public function remove(popUp:ICPopUp)
	{
		container.removeChild(popUp.view);
		_popUps.remove(popUp);
		_isModal.delete(popUp);
		updateModal();
	}
	
	function updateModal()
	{
		var i = _popUps.length;
		var newModal = false;
		while (i-- > 0)
		{
			var popUp = _popUps[i];
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