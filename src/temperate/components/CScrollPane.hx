package temperate.components;
import flash.display.DisplayObject;
import temperate.skins.ICRectSkin;

class CScrollPane extends ACScrollPane
{
	public function new(
		newHScrollBar:Void->CScrollBar, newVScrollBar:Void->CScrollBar, bgSkin:ICRectSkin) 
	{
		super(newHScrollBar, newVScrollBar, bgSkin);
		
		_hScrollStep = 10;
		_vScrollStep = 10;
	}
	
	public var content(get_content, set_content):DisplayObject;
	var _content:DisplayObject;
	function get_content()
	{
		return _content;
	}
	function set_content(value:DisplayObject)
	{
		if (_content != value)
		{
			if (_content != null)
			{
				removeChild(_content);
			}
			_content = value;
			if (_content != null)
			{
				addChild(_content);
			}
		}
		return _content;
	}
}