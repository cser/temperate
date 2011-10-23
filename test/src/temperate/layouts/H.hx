package temperate.layouts;
import temperate.core.CMath;
import temperate.core.CSprite;

class H extends CSprite
{
	public static var MIN_WIDTH = 22;
	public static var MIN_HEIGHT = 10;
	
	public function new()
	{
		super();
	}
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_width = CMath.max(MIN_WIDTH, _settedWidth);
			_height = MIN_HEIGHT;
		}
	}
}