package temperate.windows.components;
import flash.display.DisplayObject;
import temperate.skins.ICWindowSkin;
import temperate.windows.CPopUpManager;
import temperate.windows.ICPopUp;

class ACWindowComponent 
{
	function new() 
	{
	}
	
	var _popUp:ICPopUp;
	var _view:DisplayObject;
	var _getManager:Void->CPopUpManager;
	var _skin:ICWindowSkin;
	
	public function subscribe(popUp:ICPopUp, getManager:Void->CPopUpManager, skin:ICWindowSkin):Void
	{
		_popUp = popUp;
		_view = popUp.view;
		_getManager = getManager;
		_skin = skin;
		doSubscribe();
	}
	
	public function unsubscribe():Void
	{
		doUnsubscribe();
		_popUp = null;
		_view = null;
	}
	
	function doSubscribe():Void
	{
	}
	
	function doUnsubscribe():Void
	{
	}
	
	public var next:ACWindowComponent;
	
	public function getX():Int
	{
		return next != null ? next.getX() : 0;
	}
	
	public function getY():Int
	{
		return next != null ? next.getY() : 0;
	}
	
	public function move(x:Int, y:Int):Void
	{
		if (next != null)
		{
			next.move(x, y);
		}
	}
	
	public function getWidth():Int
	{
		return next != null ? next.getWidth() : 0;
	}
	
	public function getHeight():Int
	{
		return next != null ? next.getHeight() : 0;
	}
	
	public function setSize(width:Int, height:Int):Void
	{
		if (next != null)
		{
			next.setSize(width, height);
		}
	}
	
	public function animateShow(fast:Bool):Void
	{
		if (next != null)
		{
			next.animateShow(fast);
		}
	}
	
	public function animateHide(fast:Bool, onComplete:ICPopUp->Void):Void
	{
		if (next != null)
		{
			next.animateHide(fast, onComplete);
		}
	}
}