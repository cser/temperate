package temperate.components;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import temperate.containers.ICInvalidateClient;
import temperate.core.CMath;
import temperate.layouts.CScrollLayout;
import temperate.layouts.ICScrollLayout;
import temperate.skins.ICRectSkin;

class CScrollPane extends ACScrollPane, implements ICInvalidateClient
{
	public function new(
		newHScrollBar:Void->CScrollBar, newVScrollBar:Void->CScrollBar, bgSkin:ICRectSkin) 
	{
		super(newHScrollBar, newVScrollBar, bgSkin);
		
		_scrollRect = new Rectangle();
		
		_container = new Sprite();
		addChild(_container);
		
		_layout = newScrollLayout();
		
		_hScrollStep = 10;
		_vScrollStep = 10;
		
		contentIndentLeft = 0;
		contentIndentRight = 0;
		contentIndentTop = 0;
		contentIndentBottom = 0;
		
		_size_valid = false;
		postponeSize();
	}
	
	private var _scrollRect:Rectangle;
	private var _container:Sprite;
	private var _layout:ICScrollLayout;
	
	function newScrollLayout():ICScrollLayout
	{
		return new CScrollLayout();
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
			
			var areaWidth = _width - (_vScrollAvailable ? _vScrollBar.width : 0);
			var areaHeight = _height - (_hScrollAvailable ? _hScrollBar.height : 0);
			
			if (_vScrollAvailable)
			{
				_vScrollBar.x = _width - _vScrollBar.width;
				_vScrollBar.maxValue = CMath.max(_container.height - areaHeight, 0);
				_vScrollBar.pageSize = areaWidth;
				_vScrollBar.height = areaHeight;
				_vScrollBar.validate();
			}
			if (_hScrollAvailable)
			{
				_hScrollBar.y = _height - _hScrollBar.height;
				_hScrollBar.maxValue = CMath.max(_container.width - areaWidth, 0);
				_hScrollBar.pageSize = areaHeight;
				_hScrollBar.width = areaWidth;
				_hScrollBar.validate();
			}
			
			_scrollRect.x = 0;
			_scrollRect.y = 0;
			_scrollRect.width = areaWidth;
			_scrollRect.height = areaHeight;
			_container.scrollRect = _scrollRect;
			
			_container.x = contentIndentLeft;
			_container.y = contentIndentTop;
			_bgSkin.setBounds(
				0,
				0,
				Std.int(areaWidth) + contentIndentLeft + contentIndentRight,
				Std.int(areaHeight) + contentIndentTop + contentIndentBottom);
			_bgSkin.redraw();
		}
	}
	
	public var contentIndentLeft(default, null):Int;
	
	public var contentIndentRight(default, null):Int;
	
	public var contentIndentTop(default, null):Int;
	
	public var contentIndentBottom(default, null):Int;
	
	public function setContentIndents(left:Int, right:Int, top:Int, bottom:Int)
	{
		contentIndentLeft = left;
		contentIndentRight = right;
		contentIndentTop = top;
		contentIndentBottom = bottom;
		_size_valid = false;
		postponeSize();
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
	
	/**
	 * Call it directly if content size changed
	 */
	public function invalidate()
	{
		_size_valid = false;
		postponeSize();
	}
}
/*
TODO
Обновление при изменении контента
Обновление при девалидации
Отступы и политики размеров для контента
Отступы относительно скроллируемой области
Скроллирование колесом мыши
*/