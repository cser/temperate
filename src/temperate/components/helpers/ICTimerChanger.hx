package temperate.components.helpers;

interface ICTimerChanger 
{
	function increaseDown(useSecondDelay:Bool):Void;
	
	function decreaseDown(useSecondDelay:Bool):Void;
	
	function up():Void;
	
	var onIncrease:Void->Void;
	var onDecrease:Void->Void;
}