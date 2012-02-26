package temperate.components.parametrization;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.geom.ColorTransform;
import temperate.components.CButtonState;

class CImageParams 
{
	private static var _nullColorTransform:ColorTransform = new ColorTransform();
	
	public static function clearTransforms(object:DisplayObject):Void
	{
		object.filters = null;
		object.transform.colorTransform = _nullColorTransform;
	}
	
	public function new() 
	{
		alpha = Math.NaN;
	}
	
	public var image:DisplayObject;
	
	public function setImage(image:DisplayObject):CImageParams
	{
		this.image = image;
		return this;
	}
	
	public function setBitmapData(bitmapData:BitmapData):CImageParams
	{
		this.image = new Bitmap(bitmapData);
		return this;
	}
	
	public var filters:Array<Dynamic>;
	
	public function setFilters(filters:Array<Dynamic>):CImageParams
	{
		this.filters = filters;
		return this;
	}
	
	public var colorTransform:ColorTransform;
	
	public function setColorTransform(colorTransform:ColorTransform):CImageParams
	{
		this.colorTransform = colorTransform;
		return this;
	}
	
	public var offsetX:Int;
	public var offsetY:Int;
	
	public function setOffset(offsetX:Int, offsetY:Int):CImageParams
	{
		this.offsetX = offsetX;
		this.offsetY = offsetY;
		return this;
	}
	
	public var alpha:Float;
	
	public function setAlpha(alpha:Float):CImageParams
	{
		this.alpha = alpha;
		return this;
	}
	
	public function applyTransforms(object:DisplayObject):Void
	{
		object.filters = filters;
		if (colorTransform != null)
		{
			object.transform.colorTransform = colorTransform;
		}
		else
		{
			object.transform.colorTransform = _nullColorTransform;
		}
		if (!Math.isNaN(alpha))
		{
			object.alpha = alpha;
		}
	}
	
	public static function getImage(
		paramsByIndex:Array<CImageParams>, state:CButtonState):DisplayObject
	{
		var image = null;
		var imageParams = paramsByIndex[state.index];
		if (imageParams != null)
		{
			image = imageParams.image;
		}
		if (image == null && state.selected)
		{
			var params = paramsByIndex[CButtonState.UP_SELECTED.index];
			if (params != null)
			{
				image = params.image;
			}
		}
		if (image == null)
		{
			var params = paramsByIndex[CButtonState.UP.index];
			if (params != null)
			{
				image = params.image;
			}
		}
		return image;
	}
}