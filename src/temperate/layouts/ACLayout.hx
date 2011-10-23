package temperate.layouts;
import temperate.layouts.ICLayout;
import temperate.layouts.parametrization.CChildWrapper;

class ACLayout implements ICLayout
{
	function new() 
	{
		width = 0;
		height = 0;
		gapX = 4;
		gapY = 4;
	}
	
	public function arrange(offsetX:Int, offsetY:Int)
	{
		
	}
	
	public function removeAll()
	{
		
	}
	
	public function iterator():Iterator<CChildWrapper>
	{
		return null;
	}
	
	public var width:Float;
	
	public var height:Float;
	
	public var gapX:Float;
	
	public var gapY:Float;
	
	public var isCompactWidth:Bool;
	
	public var isCompactHeight:Bool;
	
	public var indentLeft:Int;
	
	public var indentRight:Int;
	
	public var indentTop:Int;
	
	public var indentBottom:Int;
}