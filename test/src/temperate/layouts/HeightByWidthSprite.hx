package temperate.layouts;
import temperate.core.CSprite;

class HeightByWidthSprite extends CSprite
{
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_width = _settedWidth;
			_height = getHeight(_width);
		}
	}
	
	public static function getHeight(width:Float):Int
	{
		return Std.int(200 / (width + 1)) + 10;
	}
}