package temperate.text;
import flash.text.TextField;

class CDefaultFormatFactory 
{
	static var _defaultFormat:CTextFormat;
	
	public static function getDefaultFormat()
	{
		if (_defaultFormat == null)
		{
			_defaultFormat = new CTextFormat("Tahoma", 12);
		}
		return _defaultFormat;
	}
}