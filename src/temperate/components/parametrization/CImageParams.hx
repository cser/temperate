package temperate.components.parametrization;
import flash.display.DisplayObject;

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
}