package temperate.minimal.graphics;

class MBdFlatColors 
{
	public static var bgColor(get_bgColor, set_bgColor):MFlatBgColor;
	static var _bgColor:MFlatBgColor;
	static function get_bgColor()
	{
		if (_bgColor == null)
		{
			var color = new MFlatBgColor();
			
			color.bgRatiosUp = [ 0, 138, 140, 250 ];
			color.bgRatiosOver = [ 0, 138, 140, 250 ];
			color.bgRatiosDown = [ 0, 250 ];
			color.bgRatiosDisabled = [ 0, 250 ];

			color.bgColorsUp = [ 0xffd0f060, 0xff80c020, 0xff60a000, 0xffa0c000 ];
			color.bgColorsOver = [ 0xffbfef50, 0xffafcf50, 0xff8fbf30, 0xffafcf30 ];
			color.bgColorsDown = [ 0xff506f00, 0xffc0ff30 ];
			color.bgColorsDisabled = [ 0xffeeeeee, 0xffcccccc ];

			color.bgBottomRightColor = 0xff105000;
			color.bgBottomRightDisabledColor = 0xffbabaaa;

			color.bgTopLeftColor = 0xff80a080;
			color.bgTopLeftDisabledColor = 0xffcccccc;

			color.bgInnerTopLeftColor = 0xa0ffffff;
			color.bgInnerBottomRightColor = 0xe0ffffff;

			color.bgInnerDownColor = 0x2e000000;
			
			_bgColor = color;
		}
		return _bgColor;
	}
	static function set_bgColor(value:MFlatBgColor)
	{
		_bgColor = value;
		return _bgColor;
	}
	
	public static var bgSelectedColor(get_bgSelectedColor, set_bgSelectedColor):MFlatBgColor;
	static var _bgSelectedColor:MFlatBgColor;
	static function get_bgSelectedColor()
	{
		if (_bgSelectedColor == null)
		{
			var color = new MFlatBgColor();
			
			color.bgRatiosUp = [ 0, 138, 140, 250 ];
			color.bgRatiosOver = [ 0, 138, 140, 250 ];
			color.bgRatiosDown = [ 0, 250 ];
			color.bgRatiosDisabled = [ 0, 250 ];

			color.bgColorsUp = [ 0xffe0fe00, 0xffe0c000, 0xffc0a000, 0xffe3c300 ];
			color.bgColorsOver = [ 0xfffffe00, 0xffead000, 0xffdab700, 0xffeae000 ];
			color.bgColorsDown = [ 0xffaa8000, 0xfffffe00 ];
			color.bgColorsDisabled = [ 0xffeeeecc, 0xffcccc82 ];

			color.bgBottomRightColor = 0xff202020;

			color.bgBottomRightDisabledColor = 0xffb5b5b5;

			color.bgTopLeftColor = 0xff8b8b8b;
			color.bgTopLeftDisabledColor = 0xffcccccc;

			color.bgInnerTopLeftColor = 0xa0ffffff;
			color.bgInnerBottomRightColor = 0xe0ffffff;

			color.bgInnerDownColor = 0x2e000000;
			
			_bgSelectedColor = color;
		}
		return _bgSelectedColor;
	}
	static function set_bgSelectedColor(value:MFlatBgColor)
	{
		_bgSelectedColor = value;
		return _bgSelectedColor;
	}
}