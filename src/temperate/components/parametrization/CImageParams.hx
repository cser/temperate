package temperate.components.parametrization;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import temperate.components.CButtonState;

class CImageParams 
{
	public function new() 
	{
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