package windowApplication;
import flash.display.BitmapData;
import temperate.minimal.graphics.MBdInlineUtil;

class BdFactory
{
	static var _ellipse:BitmapData;
	
	public static function getEllipse():BitmapData
	{
		if (_ellipse == null)
		{
			_ellipse = MBdInlineUtil.decode(
				[0x1b, 0x1a, 0x7f, 0x0, 0x1f000000, 0xf, 0x3f000000, 
				0x1f000000, 0x1f, 0x0, 0x4f000000, 0xaf000000, 0xdf000000, 0x13, 
				0xff000000, 0xdf000000, 0xaf000000, 0x4f000000, 0x15, 0x0, 0x7f000000, 
				0xdf000000, 0x7, 0xff000000, 0xff06080c, 0xf, 0xff1e2438, 0xff06080c, 
				0x7, 0xff000000, 0xdf000000, 0x7f000000, 0xf, 0x0, 0x8f000000, 
				0x5, 0xff000000, 0xff1e2438, 0xff455280, 0xff7589d6, 0x13, 0xff7d93e6, 
				0xff7589d6, 0xff455280, 0xff1e2438, 0x5, 0xff000000, 0x8f000000, 0xb, 
				0x0, 0x9f000000, 0xff000000, 0xff0e111a, 0xff6d80c8, 0x1f, 0xff7d93e6, 
				0xff6d80c8, 0xff0e111a, 0xff000000, 0x9f000000, 0x7, 0x0, 0x7f000000, 
				0xff000000, 0xff161a2a, 0xff7589d6, 0x23, 0xff7d93e6, 0xff7589d6, 0xff161a2a, 
				0xff000000, 0x7f000000, 0x0, 0x3f000000, 0xff000000, 0xff06080c, 0xff7589d6, 
				0x27, 0xff7d93e6, 0xff7589d6, 0xff06080c, 0xff000000, 0x3f000000, 0xbf000000, 
				0xff000000, 0xff5d6eac, 0x2b, 0xff7d93e6, 0xff5d6eac, 0xff000000, 0xbf000000, 
				0xff000000, 0xff0e111a, 0x2f, 0xff7d93e6, 0xff0e111a, 0x5, 0xff000000, 
				0xff363f64, 0x2f, 0xff7d93e6, 0xff363f64, 0x5, 0xff000000, 0xff3e4972, 
				0x2f, 0xff7d93e6, 0xff3e4972, 0x5, 0xff000000, 0xff3e4972, 0x2f, 
				0xff7d93e6, 0xff3e4972, 0x5, 0xff000000, 0xff1e2438, 0x2f, 0xff7d93e6, 
				0xff1e2438, 0x7, 0xff000000, 0xff6d80c8, 0x2b, 0xff7d93e6, 0xff6d80c8, 
				0x5, 0xff000000, 0x9f000000, 0xff000000, 0xff262d46, 0x2b, 0xff7d93e6, 
				0xff262d46, 0xff000000, 0x9f000000, 0xf000000, 0xef000000, 0xff000000, 0xff455280, 
				0x27, 0xff7d93e6, 0xff455280, 0xff000000, 0xef000000, 0xf000000, 0x0, 
				0x2f000000, 0xef000000, 0xff000000, 0xff2e3654, 0xff6d80c8, 0x1f, 0xff7d93e6, 
				0xff6d80c8, 0xff2e3654, 0xff000000, 0xef000000, 0x2f000000, 0x7, 0x0, 
				0x2f000000, 0xdf000000, 0x5, 0xff000000, 0xff3e4972, 0x1b, 0xff7d93e6, 
				0xff3e4972, 0x5, 0xff000000, 0xdf000000, 0x2f000000, 0xb, 0x0, 
				0xf000000, 0x6f000000, 0x7, 0xff000000, 0xff363f64, 0xff55649c, 0xf, 
				0xff7d93e6, 0xff55649c, 0xff363f64, 0x7, 0xff000000, 0x6f000000, 0xf000000, 
				0x11, 0x0, 0x2f000000, 0xaf000000, 0x1b, 0xff000000, 0xaf000000, 
				0x2f000000, 0x19, 0x0, 0x2f000000, 0x6f000000, 0xbf000000, 0xef000000, 
				0xb, 0xff000000, 0xef000000, 0xbf000000, 0x6f000000, 0x2f000000, 0xaf, 
				0x0, 0x0]);
		}
		return _ellipse;
	}
	
	static var _figure:BitmapData;
	
	public static function getFigure():BitmapData
	{
		if (_figure == null)
		{
			_figure = MBdInlineUtil.decode(
				[0x1b, 0x19, 0x81, 0x0, 0x4f000000, 0x1d, 0xff000000, 
				0xcf000000, 0x17, 0x0, 0x5f000000, 0x1f, 0xff000000, 0x17, 
				0x0, 0xf000000, 0x5, 0xff000000, 0xff6d80c8, 0x15, 0xff7d93e6, 
				0x5, 0xff000000, 0x19, 0x0, 0xaf000000, 0xff000000, 0xff455280, 
				0x15, 0xff7d93e6, 0x5, 0xff000000, 0x19, 0x0, 0x5f000000, 
				0xff000000, 0xff161a2a, 0x15, 0xff7d93e6, 0x5, 0xff000000, 0x19, 
				0x0, 0xf000000, 0x5, 0xff000000, 0xff6d80c8, 0x13, 0xff7d93e6, 
				0x5, 0xff000000, 0x1b, 0x0, 0xaf000000, 0xff000000, 0xff455280, 
				0x13, 0xff7d93e6, 0x5, 0xff000000, 0x1b, 0x0, 0x5f000000, 
				0xff000000, 0xff161a2a, 0x13, 0xff7d93e6, 0x5, 0xff000000, 0x1b, 
				0x0, 0xf000000, 0x5, 0xff000000, 0xff6d80c8, 0x11, 0xff7d93e6, 
				0x5, 0xff000000, 0x1d, 0x0, 0xbf000000, 0xff000000, 0xff455280, 
				0x11, 0xff7d93e6, 0x5, 0xff000000, 0x13, 0x0, 0x2f000000, 
				0x5f000000, 0x8f000000, 0xbf000000, 0x7, 0xff000000, 0xff1e2438, 0x11, 
				0xff7d93e6, 0x5, 0xff000000, 0x9, 0x0, 0x3f000000, 0x6f000000, 
				0x9f000000, 0xcf000000, 0xd, 0xff000000, 0xff06080c, 0xff1e2438, 0xff6577ba, 
				0x11, 0xff7d93e6, 0x5, 0xff000000, 0x5, 0x0, 0x8f000000, 
				0xd, 0xff000000, 0xff06080c, 0xff1e2438, 0xff3e4972, 0xff55649c, 0xff6d80c8, 
				0x17, 0xff7d93e6, 0x5, 0xff000000, 0x5, 0x0, 0x5, 
				0xff000000, 0xff0e111a, 0xff262d46, 0xff3e4972, 0xff5d6eac, 0xff7589d6, 0x21, 
				0xff7d93e6, 0x5, 0xff000000, 0x5, 0x0, 0x5, 0xff000000, 
				0x2b, 0xff7d93e6, 0x5, 0xff000000, 0x5, 0x0, 0x5, 
				0xff000000, 0x2b, 0xff7d93e6, 0x5, 0xff000000, 0x5, 0x0, 
				0x5, 0xff000000, 0x2b, 0xff7d93e6, 0x5, 0xff000000, 0x5, 
				0x0, 0x5, 0xff000000, 0x2b, 0xff7d93e6, 0x5, 0xff000000, 
				0x5, 0x0, 0x5, 0xff000000, 0x2b, 0xff7d93e6, 0x5, 
				0xff000000, 0x5, 0x0, 0x5, 0xff000000, 0x2b, 0xff7d93e6, 
				0x5, 0xff000000, 0x5, 0x0, 0x33, 0xff000000, 0x0, 
				0x3f000000, 0x31, 0xff000000, 0x9f000000, 0x37, 0x0, 0x0]);
		}
		return _figure;
	}
	
	static var _line:BitmapData;
	
	public static function getLine():BitmapData
	{
		if (_line == null)
		{
			_line = MBdInlineUtil.decode(
				[0x16, 0x18, 0x4b, 0x0, 0x2f000000, 0xdf000000, 0x5, 
				0xff000000, 0xef000000, 0x21, 0x0, 0x1f000000, 0xef000000, 0xffcecece, 
				0xfffefefe, 0xffcecece, 0xff6e6e6e, 0x8f000000, 0x1f, 0x0, 0x7f000000, 
				0xff3e3e3e, 0x9, 0xfffefefe, 0xef000000, 0x1f, 0x0, 0x6f000000, 
				0xff6e6e6e, 0x9, 0xfffefefe, 0xcf000000, 0x1f, 0x0, 0x2f000000, 
				0xff000000, 0xff5e5e5e, 0xfffefefe, 0xffcecece, 0xff5e5e5e, 0x7f000000, 0x1f, 
				0x0, 0xaf000000, 0x9, 0xff000000, 0x8f000000, 0x1f, 0x0, 
				0x9f000000, 0x5, 0xff000000, 0x2f000000, 0x23, 0x0, 0x5f000000, 
				0x5, 0xff000000, 0x5f000000, 0x23, 0x0, 0x3f000000, 0x5, 
				0xff000000, 0x7f000000, 0x23, 0x0, 0x2f000000, 0xef000000, 0xff000000, 
				0x9f000000, 0x23, 0x0, 0xf000000, 0xdf000000, 0xff000000, 0xcf000000, 
				0xf000000, 0x21, 0x0, 0xf000000, 0xcf000000, 0xff000000, 0xdf000000, 
				0xf000000, 0x23, 0x0, 0x9f000000, 0xff000000, 0xef000000, 0x2f000000, 
				0x23, 0x0, 0x7f000000, 0x5, 0xff000000, 0x3f000000, 0x23, 
				0x0, 0x5f000000, 0x5, 0xff000000, 0x5f000000, 0x1f, 0x0, 
				0x1f000000, 0x3f000000, 0x4f000000, 0x5, 0xff000000, 0x9f000000, 0x1d, 
				0x0, 0x1f000000, 0xcf101010, 0x5, 0xff3e3e3e, 0x5, 0xff000000, 
				0xaf000000, 0x1f, 0x0, 0x8f000000, 0xff9e9e9e, 0x5, 0xfffefefe, 
				0xff5e5e5e, 0xff1e1e1e, 0x1f000000, 0x1f, 0x0, 0xdf000000, 0x9, 
				0xfffefefe, 0xff7e7e7e, 0x6f000000, 0x1f, 0x0, 0xef000000, 0xffeeeeee, 
				0x7, 0xfffefefe, 0xff6e6e6e, 0x6f000000, 0x1f, 0x0, 0x8f000000, 
				0xff5e5e5e, 0x5, 0xfffefefe, 0xffbebebe, 0xef000000, 0x1f000000, 0x21, 
				0x0, 0x5f000000, 0xef000000, 0xff000000, 0xaf000000, 0x1f000000, 0x49, 
				0x0, 0x0]);
		}
		return _line;
	}
	
	static var _pencil:BitmapData;
	
	public static function getPencil():BitmapData
	{
		if (_pencil == null)
		{
			_pencil = MBdInlineUtil.decode(
				[0x18, 0x19, 0x1f, 0x0, 0x6f000000, 0xff000000, 0xef000000, 
				0x8f000000, 0x1f000000, 0x25, 0x0, 0x9f000000, 0xff120504, 0xff7d2928, 
				0xff812d2c, 0xff3b1414, 0xff000000, 0x8f000000, 0xf000000, 0x1f, 0x0, 
				0x3f000000, 0xff000000, 0xff682222, 0xff983232, 0xffa93a3a, 0xffc04544, 0xff9b3736, 
				0xff230c0c, 0xcf000000, 0xf000000, 0x1b, 0x0, 0x5f151514, 0xff252524, 
				0xff535352, 0xff381212, 0x5, 0xff983232, 0xffb84140, 0xffc04544, 0xffb34040, 
				0xff230c0c, 0xaf000000, 0x19, 0x0, 0x4f2d2d2c, 0xff191918, 0xff474746, 
				0xff828282, 0xff000000, 0xff842b2a, 0xff983232, 0xff9f3534, 0xffbd4342, 0xffc04544, 
				0xffb34040, 0xff170706, 0x4f000000, 0x15, 0x0, 0x2f000000, 0xef231f12, 
				0xff474746, 0xff9e9e9e, 0xff464646, 0xff585858, 0xff250b0a, 0x5, 0xff983232, 
				0xff9f3534, 0xffbd4342, 0xffc04544, 0xff832f2e, 0xcf000000, 0x13, 0x0, 
				0x2f000000, 0xef302700, 0xffeebe00, 0xff4b452a, 0xff989898, 0xff4e4e4e, 0xff6d6d6c, 
				0xff212120, 0xff381212, 0x5, 0xff983232, 0xff9d3434, 0xffb33f3e, 0xffc04544, 
				0xff0b0302, 0x11, 0x0, 0x2f000000, 0xef302700, 0xffeebe00, 0xfffecb00, 
				0xffb19112, 0xff454544, 0xff9e9e9e, 0xff3a3a3a, 0xff747474, 0xff1d1d1c, 0xff2e0e0e, 
				0xff8e2e2e, 0x5, 0xff983232, 0xff953232, 0xff170706, 0xf, 0x0, 
				0x2f000000, 0xef302700, 0xffeebe00, 0x5, 0xfffecb00, 0xffd79f00, 0xff554724, 
				0xff636362, 0xff959594, 0xff393938, 0xff626262, 0xff2b2b2a, 0xff120504, 0xff411514, 
				0xff842b2a, 0xff2e0e0e, 0xaf000000, 0xd, 0x0, 0x5f000000, 0xff4e3e00, 
				0xffeebe00, 0x5, 0xfffecb00, 0xffd79f00, 0xffc08600, 0xffb78004, 0xff4c4128, 
				0xff5c5c5c, 0xff858584, 0xff434342, 0xff464646, 0xff3d3d3c, 0xff292928, 0xff000000, 
				0xcf000000, 0xf000000, 0xb, 0x0, 0x5f000000, 0xff5e4b00, 0x7, 
				0xfffecb00, 0xffd79f00, 0x7, 0xffc08600, 0xffb78004, 0xff4c4128, 0xff494948, 
				0xff6f6f6e, 0xff565656, 0xff393938, 0xff323232, 0xcf050504, 0xf000000, 0xb, 
				0x0, 0x5f000000, 0xff5e4b00, 0x7, 0xfffecb00, 0xffd79f00, 0xd, 
				0xffc08600, 0xff5a441c, 0xff36332e, 0xff393938, 0xff353534, 0xcf0e0e0e, 0xf000000, 
				0xb, 0x0, 0x5f000000, 0xff5e4b00, 0x7, 0xfffecb00, 0xffd79f00, 
				0xd, 0xffc08600, 0xff956000, 0x5, 0xff7c4a00, 0xff392912, 0x9f222222, 
				0xf000000, 0xb, 0x0, 0x2f000000, 0xff2e2500, 0x7, 0xfffecb00, 
				0xffd79f00, 0xd, 0xffc08600, 0xff956000, 0x5, 0xff7c4a00, 0xff4d2d00, 
				0x9f000000, 0xf, 0x0, 0x7f000000, 0xff7e6836, 0xfffdcc14, 0xfffecb00, 
				0xffd79f00, 0xd, 0xffc08600, 0xff956000, 0x5, 0xff7c4a00, 0xff4d2d00, 
				0x9f000000, 0x11, 0x0, 0xbf000000, 0xffbd9d52, 0xfffdce36, 0xffd79f00, 
				0xd, 0xffc08600, 0xff956000, 0x5, 0xff7c4a00, 0xff4d2d00, 0x9f000000, 
				0x13, 0x0, 0xff000000, 0xfffdd26e, 0xfff1c048, 0xffd69e1c, 0xb, 
				0xffc08600, 0xff956000, 0x5, 0xff7c4a00, 0xff4d2d00, 0x9f000000, 0x13, 
				0x0, 0x2f000000, 0xff2e2614, 0xfffdd16c, 0xfffdc84e, 0xfffdc84c, 0xffedb73a, 
				0xffc38a04, 0x5, 0xffc08600, 0xff956000, 0x5, 0xff7c4a00, 0xff4d2d00, 
				0x9f000000, 0x15, 0x0, 0x6f000000, 0xff6e5b30, 0xfffdcd5e, 0x7, 
				0xfffdc84c, 0xffe9b334, 0xffc08600, 0xff956000, 0x5, 0xff7c4a00, 0xff4d2d00, 
				0x9f000000, 0x17, 0x0, 0xaf000000, 0xffad8f48, 0xfffdc84e, 0x9, 
				0xfffdc84c, 0xff956000, 0x5, 0xff7c4a00, 0xff4d2d00, 0x9f000000, 0x19, 
				0x0, 0xff000000, 0xffbd9842, 0xfffcc646, 0xfffcc33e, 0xfffcc034, 0xfffaba28, 
				0xffefaa08, 0xffcd9000, 0xffa17100, 0xff513600, 0x9f000000, 0x19, 0x0, 
				0x4f000000, 0xff000000, 0xff2e2204, 0xffcc961c, 0xffbc8b1a, 0xff8c6610, 0xff583e00, 
				0xff1c1300, 0xdf000000, 0xaf000000, 0x6f000000, 0x1b, 0x0, 0x8f000000, 
				0x7, 0xff000000, 0xdf000000, 0x8f000000, 0x5f000000, 0x1f000000, 0x21, 
				0x0, 0x8f000000, 0xbf000000, 0x6f000000, 0x2f000000, 0x57, 0x0, 
				0x0]);
		}
		return _pencil;
	}
	
	static var _rect:BitmapData;
	
	public static function getRect():BitmapData
	{
		if (_rect == null)
		{
			_rect = MBdInlineUtil.decode(
				[0x1b, 0x19, 0x6d, 0x0, 0xcf000000, 0x33, 0xff000000, 
				0x9f000000, 0x3b, 0xff000000, 0x2f, 0xff7d93e6, 0x9, 0xff000000, 
				0x2f, 0xff7d93e6, 0x9, 0xff000000, 0x2f, 0xff7d93e6, 0x9, 
				0xff000000, 0x2f, 0xff7d93e6, 0x9, 0xff000000, 0x2f, 0xff7d93e6, 
				0x9, 0xff000000, 0x2f, 0xff7d93e6, 0x9, 0xff000000, 0x2f, 
				0xff7d93e6, 0x9, 0xff000000, 0x2f, 0xff7d93e6, 0x9, 0xff000000, 
				0x2f, 0xff7d93e6, 0x9, 0xff000000, 0x2f, 0xff7d93e6, 0x9, 
				0xff000000, 0x2f, 0xff7d93e6, 0x9, 0xff000000, 0x2f, 0xff7d93e6, 
				0x9, 0xff000000, 0x2f, 0xff7d93e6, 0x9, 0xff000000, 0x2f, 
				0xff7d93e6, 0x9, 0xff000000, 0x2f, 0xff7d93e6, 0x9, 0xff000000, 
				0x2f, 0xff7d93e6, 0x9, 0xff000000, 0x2f, 0xff7d93e6, 0x3b, 
				0xff000000, 0xdf000000, 0x33, 0xff000000, 0xbf000000, 0x6b, 0x0, 
				0x0]);
		}
		return _rect;
	}
	
	static var _text:BitmapData;
	
	public static function getText():BitmapData
	{
		if (_text == null)
		{
			_text = MBdInlineUtil.decode(
				[0x1b, 0x1a, 0x119, 0x0, 0x25, 0xff000000, 0x13, 
				0x0, 0x7, 0xff000000, 0x6d000000, 0x7, 0x0, 0x9, 
				0xff000000, 0x7, 0x0, 0x6d000000, 0x7, 0xff000000, 0x13, 
				0x0, 0x5, 0xff000000, 0x6d000000, 0x9, 0x0, 0x9, 
				0xff000000, 0x9, 0x0, 0x6d000000, 0x5, 0xff000000, 0x13, 
				0x0, 0x5, 0xff000000, 0xb, 0x0, 0x9, 0xff000000, 
				0xb, 0x0, 0x5, 0xff000000, 0x13, 0x0, 0xff000000, 
				0x6d000000, 0xb, 0x0, 0x9, 0xff000000, 0xb, 0x0, 
				0x6d000000, 0xff000000, 0x13, 0x0, 0xff000000, 0xd, 0x0, 
				0x9, 0xff000000, 0xd, 0x0, 0xff000000, 0x13, 0x0, 
				0x6d000000, 0xd, 0x0, 0x9, 0xff000000, 0xd, 0x0, 
				0x6d000000, 0x21, 0x0, 0x9, 0xff000000, 0x2f, 0x0, 
				0x9, 0xff000000, 0x2f, 0x0, 0x9, 0xff000000, 0x2f, 
				0x0, 0x9, 0xff000000, 0x2f, 0x0, 0x9, 0xff000000, 
				0x2f, 0x0, 0x9, 0xff000000, 0x2f, 0x0, 0x9, 
				0xff000000, 0x2f, 0x0, 0x9, 0xff000000, 0x2d, 0x0, 
				0x6d000000, 0x9, 0xff000000, 0x6d000000, 0x29, 0x0, 0xab000000, 
				0xd, 0xff000000, 0x6d000000, 0x25, 0x0, 0xab000000, 0x11, 
				0xff000000, 0x6d000000, 0xb1, 0x0, 0x0]);
		}
		return _text;
	}
}