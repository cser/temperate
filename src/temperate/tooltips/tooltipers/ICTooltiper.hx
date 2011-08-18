package temperate.tooltips.tooltipers;

interface ICTooltiper 
{
	function internalShow(fast:Bool):Void;
	
	function internalHide(fast:Bool):Void;
	
	var showDelay:Null<Int>;
	
	var secondShowDelay:Null<Int>;
	
	var hideDelay:Null<Int>;
	
	var secondShowTimeout:Null<Int>;
}