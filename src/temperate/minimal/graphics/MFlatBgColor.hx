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
	
	public var bgColorsUp:Array<UInt>;
	public var bgColorsOver:Array<UInt>;
	public var bgColorsDown:Array<UInt>;
	public var bgColorsDisabled:Array<UInt>;
	
	public var bgBottomRightColor:UInt;
	public var bgBottomRightDisabledColor:UInt;
	
	public var bgTopLeftColor:UInt;
	public var bgTopLeftDisabledColor:UInt;
	
	public var bgInnerTopLeftColor:UInt;
	public var bgInnerBottomRightColor:UInt;
	
	public var bgInnerDownColor:UInt;
}