package temperate.minimal.graphics;

class MFlatBgColor
{
	public function new()
	{
	}
	
	public var bgRatiosUp:Array<Int>;
	public var bgRatiosOver:Array<Int>;
	public var bgRatiosDown:Array<Int>;
	public var bgRatiosDisabled:Array<Int>;
	
	public var bgColorsUp:Array<Int>;
	public var bgColorsOver:Array<Int>;
	public var bgColorsDown:Array<Int>;
	public var bgColorsDisabled:Array<Int>;
	
	public var bgBottomRightColor:Int;
	public var bgBottomRightDisabledColor:Int;
	
	public var bgTopLeftColor:Int;
	public var bgTopLeftDisabledColor:Int;
	
	public var bgInnerTopLeftColor:Int;
	public var bgInnerBottomRightColor:Int;
	
	public var bgInnerDownColor:Int;
}