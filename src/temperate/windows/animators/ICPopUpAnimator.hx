package temperate.windows.animators;
import temperate.windows.ICPopUp;

interface ICPopUpAnimator 
{
	function setPopUp(popUp:ICPopUp):Void;
	
	var popUp:ICPopUp;
	
	function initBeforeShow():Void;
	
	function show(fast:Bool):Void;
	
	function hide(fast:Bool):Void;
	
	var onHideComplete:ICPopUpAnimator->Void;
}