package temperate.windows.animators;
import temperate.windows.animators.ICPopUpAnimator;
import temperate.windows.ICPopUp;

class CNullPopUpAnimator implements ICPopUpAnimator
{
	public function new() 
	{
	}
	
	public function initBeforeShow():Void
	{
	}
	
	public function setPopUp(popUp:ICPopUp):Void
	{
		this.popUp = popUp;
	}
	
	public function arrange(x:Float, y:Float, width:Float, height:Float):Void
	{
		popUp.view.x = x;
		popUp.view.y = y;
	}
	
	public var popUp:ICPopUp;
	
	public function show(fast:Bool):Void
	{
	}
	
	public function hide(fast:Bool):Void
	{
		if (onHideComplete != null)
		{
			onHideComplete(this);
		}
	}
	
	public var onHideComplete:ICPopUpAnimator->Void;
}