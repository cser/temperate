package temperate.core;
import flash.display.DisplayObject;
import flash.geom.Point;
import flash.geom.Rectangle;

class CDisplayObjectUtil 
{
	#if nme
	private static var _tl:Point;
	private static var _br:Point;
	#end
	
	public static function getRect(
		target:DisplayObject, targetCoordinateSpace:DisplayObject):Rectangle
	{
		#if nme
		if (_tl == null)
		{
			_tl = new Point(0, 0);
		}
		if (_br == null)
		{
			_br = new Point(target.width, target.height);
		}
		else
		{
			_br.x = target.width;
			_br.y = target.height;
		}
		var spaceTl = targetCoordinateSpace.globalToLocal(target.localToGlobal(_tl));
		var spaceBr = targetCoordinateSpace.globalToLocal(target.localToGlobal(_br));
		return new Rectangle(spaceTl.x, spaceTl.y, spaceBr.x - spaceTl.x, spaceBr.y - spaceTl.y);
		#else
		return target.getRect(targetCoordinateSpace);
		#end
	}
}