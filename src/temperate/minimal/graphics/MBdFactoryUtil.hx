package temperate.minimal.graphics;
import flash.display.Shape;
import flash.display.StageQuality;
import flash.Lib;
using temperate.core.CMath;

class MBdFactoryUtil 
{
	static var _shape:Shape;
	
	public static function getShape():Shape
	{
		if (_shape == null)
		{
			_shape = new Shape();
		}
		return _shape;
	}
	
	static var _oldQuality:StageQuality;
	
	public static function qualityOn()
	{
		var stage = Lib.current.stage;
		_oldQuality = stage.quality;
		if (_oldQuality != StageQuality.BEST && _oldQuality != StageQuality.HIGH)
		{
			stage.quality = StageQuality.HIGH;
		}
	}
	
	public static function qualityOff()
	{
		var stage = Lib.current.stage;
		if (stage.quality != _oldQuality)
		{
			stage.quality = _oldQuality;
		}
	}
	
	public static function getColorsAndAlphas(
		source:Array<Int>, outColors:Array<Int>, outAlphas:Array<Float>)
	{
		for (i in 0 ... source.length)
		{
			var color = source[i];
			outColors[i] = color.getColor();
			outAlphas[i] = color.getAlpha();
		}
	}
}