package temperate.components;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import temperate.skins.ICRectSkin;

class CScrollPane extends ACScrollPane
{
	public function new(
		newHScrollBar:Void->CScrollBar, newVScrollBar:Void->CScrollBar, bgSkin:ICRectSkin) 
	{
		super(newHScrollBar, newVScrollBar, bgSkin);
		
		_scrollRect = new Rectangle();
		
		_container = new Sprite();
		addChild(_container);
		
		_hScrollStep = 10;
		_vScrollStep = 10;
		
		_size_valid = false;
		postponeSize();
	}
	
	private var _scrollRect:Rectangle;
	private var _container:Sprite;
	
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
				_container.removeChild(_content);
			}
			_content = value;
			if (_content != null)
			{
				_container.addChild(_content);
			}
			_size_valid = false;
			postponeSize();
		}
		return _content;
	}
	
	override function doValidateSize()
	{
		if (!_size_valid)
		{
			_size_valid = true;
			
			_width = isCompactWidth ? 0 : _settedWidth;
			_height = isCompactHeight ? 0 : _settedHeight;
			
			if (_content != null)
			{
				if (_content.width > _width)
				{
					showHScrollBar();
				}
				if (_content.height > _height)
				{
					showVScrollBar();
				}
				if (_hScrollAvailable)
				{
					_hScrollBar.width = _width;
				}
				if (_vScrollAvailable)
				{
					_vScrollBar.height = _height;
				}
			}
			
			_view_valid = false;
		}
		if (!_view_valid)
		{
			postponeView();
		}
	}
	
	override function doValidateView()
	{
		if (!_view_valid)
		{
			_view_valid = true;
			
			if (_hScrollAvailable)
			{
				_hScrollBar.y = _height - _hScrollBar.height;
			}
			if (_vScrollAvailable)
			{
				_vScrollBar.x = _width - _vScrollBar.width;
			}
			_scrollRect.x = 0;
			_scrollRect.y = 0;
			_scrollRect.width = _width - (_vScrollAvailable ? _vScrollBar.width : 0);
			_scrollRect.height = _height - (_hScrollAvailable ? _hScrollBar.height : 0);
			_container.scrollRect = _scrollRect;
		}
	}
	
	override function onHScroll(event:Event)
	{
		_scrollRect.x = _hScrollBar.value;
		_container.scrollRect = _scrollRect;
	}
	
	override function onVScroll(event:Event)
	{
		_scrollRect.y = _vScrollBar.value;
		_container.scrollRect = _scrollRect;
	}
}