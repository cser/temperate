package temperate.skins;
import flash.display.Sprite;

class ACWindowSkin implements ICWindowSkin
{
	function new() 
	{
		
	}
	
	public function link(owner:Sprite, container:Sprite):Void
	{
		owner.addChild(container);
	}
	
	public function validateSize(width:Int, height:Int):Void
	{
		this.width = width;
		this.height = height;
	}
	
	public var width(default, null):Int;
	
	public var height(default, null):Int;
	
	public function validateView():Void
	{
	}
}