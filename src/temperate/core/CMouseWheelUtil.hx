package temperate.core;

class CMouseWheelUtil 
{
	/**
	 * @return abs can't be less than 1
	 */
	public static function getDimDelta(delta:Int, dimRatio:Int):Int
	{
		var sign = delta > 0 ? 1 : -1;
		var correctDimRatio = dimRatio > 0 ? dimRatio : 1;
		return sign * CMath.intMax(1, Math.round(CMath.intAbs(delta) / correctDimRatio));
	}
}