package temperate.components;
import temperate.components.ACButton;

class FakeButton extends ACButton
{
	public function new(minWidth:Int, minHeight:Int)
	{
		this.minWith = minWidth;
		this.minHeight = minHeight;
		super();
	}
	
	public var minWith(default, null):Int;
	public var minHeight(default, null):Int;
	
	override function doValidateSize()
	{
		if (_width < minWith)
		{
			_width = minWith;
		}
		if (_height < minHeight)
		{
			_height = minHeight;
		}
	}
}