package temperate.windows.components;
import temperate.windows.ICPopUp;

class CBaseWindowComponent extends ACWindowComponent
{
	public function new() 
	{
		super();
	}
	
	override public function animateShow(fast:Bool):Void
	{
	}
	
	override public function animateHide(fast:Bool, onComplete:ICPopUp->Void):Void
	{
		if (onComplete != null)
		{
			onComplete(_popUp);
		}
	}
}