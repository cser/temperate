package temperate.components.parametrization;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.geom.ColorTransform;
import temperate.text.CTextFormat;

class CRasterParams 
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
	
	public var bitmapData:BitmapData;
		
	public function setBitmapData(bitmapData:BitmapData):CRasterParams
	{
		this.bitmapData = bitmapData;
		return this;
	}
	
	public var format:CTextFormat;
	
	public function setFormat(format:CTextFormat):CRasterParams
	{
		this.format = format;
		return this;
	}
	
	public var filters:Array<Dynamic>;
	
	public function setFilters(filters:Array<Dynamic>):CRasterParams
	{
		this.filters = filters;
		return this;
	}
	
	public var colorTransform:ColorTransform;
	
	public function setColorTransform(colorTransform:ColorTransform):CRasterParams
	{
		this.colorTransform = colorTransform;
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
	
	public var bgOffsetLeft:Int;
	public var bgOffsetRight:Int;
	public var bgOffsetTop:Int;
	public var bgOffsetBottom:Int;
	
	public function setBgOffset(left:Int, right:Int, top:Int, bottom:Int):CRasterParams
	{
		bgOffsetLeft = left;
		bgOffsetRight = right;
		bgOffsetTop = top;
		bgOffsetBottom = bottom;
		return this;
	}
	
	public var textOffsetX:Int;
	public var textOffsetY:Int;
	
	public function setTextOffset(textOffsetX:Int, textOffsetY:Int):CRasterParams
	{
		this.textOffsetX = textOffsetX;
		this.textOffsetY = textOffsetY;
		return this;
	}
	
	public var alpha:Float;
	
	public function setAlpha(alpha:Float):CRasterParams
	{
		this.alpha = alpha;
		return this;
	}
}