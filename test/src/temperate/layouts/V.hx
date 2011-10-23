package temperate.layouts;
import temperate.core.CMath;
import temperate.core.CSprite;

class V extends CSprite
{
	public static var MIN_WIDTH = 14;
	public static var MIN_HEIGHT = 20;
	
	public function new()
	{
		super();
	}
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_width = MIN_WIDTH;
			_height = CMath.max(MIN_HEIGHT, _settedHeight);
		}
	}
}