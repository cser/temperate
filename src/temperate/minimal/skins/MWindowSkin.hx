package temperate.minimal.skins;
import flash.display.Sprite;
import flash.text.TextField;
import temperate.minimal.MFormatFactory;
import temperate.skins.ACWindowSkin;

class MWindowSkin extends ACWindowSkin
{
	public function new() 
	{
		super();
	}
	
	var _titleTF:TextField;
	
	override public function link(container:Sprite):Void 
	{
		super.link(container);
		_titleTF = MFormatFactory.WINDOW_TITLE.newAutoSized();
		addChild(_titleTF);
	}
	
	override function doValidateSize():Void
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_container.width = getNeededWidth();
			_container.height = getNeededHeight();
			_width = Std.int(_container.width);
			_height = Std.int(_container.height);
			
			_view_valid = false;
			postponeView();
		}
	}
	
	override function doValidateView():Void
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			var g = graphics;
			g.clear();
			g.lineStyle(2, 0x000000);
			g.beginFill(0xeeeeee);
			g.drawRoundRect(0, 0, width, height, 10);
			g.endFill();
		}
	}
	
	override function set_title(value:String) 
	{
		_title = value;
		_titleTF.text = _title;
		return _title;
	}
}