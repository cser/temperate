package temperate.windows.components;
import flash.display.DisplayObject;
import temperate.windows.ICPopUp;

class ACWindowComponent 
{
	function new() 
	{
	}
	
	var _popUp:ICPopUp;
	var _view:DisplayObject;
	
	public function subscribe(popUp:ICPopUp):Void
	{
		_popUp = popUp;
		_view = popUp.view;
	}
	
	public function unsubscribe(popUp:ICPopUp):Void
	{
		_popUp = null;
		_view = null;
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
	
	public function move(x:Float, y:Float):Void
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
	
	public function animateShow(fast:Bool)
	{
		if (next != null)
		{
			next.animateShow(fast);
		}
	}
	
	public function animateHide(fast:Bool, onComplete:ICPopUp->Void)
	{
		if (next != null)
		{
			next.animateHide(fast, onComplete);
		}
	}
}