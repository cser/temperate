package temperate.components.parametrization;
import flash.display.BitmapData;
import temperate.text.CTextFormat;

class CRasterParams 
{
	public function new() 
	{
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